/* Java 1.8 */
package com.navi.weather;

import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.io.BufferedReader;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.net.ssl.HttpsURLConnection;
import javax.sql.DataSource;


import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;


public class WeatherDAO {
	
	Connection con = null; 
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	private Connection getCon() throws Exception {

		Context initCTX = new InitialContext();
		DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mysqldb");
		con = ds.getConnection();
		
		return con;
	}
	
	public void closeDB() {
		
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	public ArrayList<Object> getWeatherInfo(String gridX, String gridY) throws Exception {

		Date nowDate = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
		
		String nowDateFormated = simpleDateFormat.format(nowDate);

        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"); /*URL*/
        
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=%2BBOQJEy7fHg8hbbSn7qkEKFAaz9YEEomgyevIciDkkKq0JPTwRpiVSdPLS6r6MaUDGyu8BZcg6quxRhnMzeQzA%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("290", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식(XML/JSON) Default: XML*/
        urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(nowDateFormated, "UTF-8")); /*‘21년 6월 28일발표*/
        urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode("0200", "UTF-8")); /*05시 발표*/
        urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(gridX, "UTF-8")); /*예보지점의 X 좌표값*/
        urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(gridY, "UTF-8")); /*예보지점의 Y 좌표값*/
        
        URL url = new URL(urlBuilder.toString());
        
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        
        // System.out.println("Response code: " + conn.getResponseCode());
        
        BufferedReader rd;
        
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        
        StringBuilder sb = new StringBuilder();
        String line;
        
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        
        rd.close();
        
        conn.disconnect();
        // System.out.println(sb.toString());

        String result = sb.toString();
        
        JSONParser paser = new JSONParser();

		JSONObject obj1 = (JSONObject) paser.parse(result);

		JSONObject obj2 = (JSONObject) obj1.get("response");
		
		JSONObject obj3 = (JSONObject) obj2.get("body");

		JSONObject obj4 = (JSONObject) obj3.get("items");
  	
        JSONArray arr = (JSONArray) obj4.get("item");
        
        // System.out.println("파싱 끝");
        
        ArrayList<Object> weatherList = new ArrayList<Object>();
        
        for(int i = 0; i < arr.size(); i++) {
        	JSONObject obj5 = (JSONObject) arr.get(i);
        	
        	WeatherDTO wDto = new WeatherDTO();
        	wDto.setCategory((String) obj5.get("category"));
        	wDto.setFcstTime((String) obj5.get("fcstTime"));
        	wDto.setValue((String) obj5.get("fcstValue"));
        	wDto.setNx((long)obj5.get("nx"));
        	wDto.setNy((long)obj5.get("ny"));
        	
        	weatherList.add(wDto);	
        	// System.out.println("데이터 삽입 끝");
        }
        return weatherList;
	}
	
	
	public int weatherInfoDuplicationCheck(String gridX, String gridY) {
		
		int result = 0;
		
		try {
			con = getCon();
			sql = "SELECT DISTINCT nx, ny FROM navi_weather";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("nx").equals(gridX) && 
					rs.getString("ny").equals(gridY)) { // 중복된 좌표 있을때
					result = 1;
				} else { // 다른 데이터 있고 중복된 좌표 없을때
					result = 0;
				}
			} else {	// 아무 데이터도 없을 때 
				result = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
		
	}
	
	public void insertWeatherInfo(ArrayList<Object> weatherList) {
		
		try {
			con = getCon();
			sql = "INSERT INTO navi_weather(category, fcstTime, fcstValue, nx, ny, update_date) "
					+ "VALUES(?, ?, ?, ?, ?, now())";
			pstmt = con.prepareStatement(sql);
			
			for(int i = 0; i < weatherList.size(); i++) {
				WeatherDTO wDto = (WeatherDTO) weatherList.get(i);
				
				pstmt.setString(1, wDto.getCategory());
				pstmt.setString(2, wDto.getFcstTime());
				pstmt.setString(3, wDto.getValue());
				pstmt.setLong(4, wDto.getNx());
				pstmt.setLong(5, wDto.getNy());
				
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}
	
	public String[] getTmxTmn(String gridX, String gridY) {
		
		String[] tmxTmn = new String[2];
		
		try {
			con = getCon();
			sql = "SELECT category, fcstValue FROM navi_weather "
					+ "WHERE category IN('TMX', 'TMN') "
					+ "AND nx=? AND ny=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, gridX);
			pstmt.setString(2, gridY);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				switch (rs.getString("category")) {
				case "TMX":
					tmxTmn[0] = rs.getString("fcstValue");
					break;
				case "TMN":
					tmxTmn[1] = rs.getString("fcstValue");
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return tmxTmn;
	}
	
	
	public RealTimeWeatherDTO getRealTimeWeatherInfo(String gridX, String gridY) {
		
		RealTimeWeatherDTO rDto = new RealTimeWeatherDTO();;
		
		try {
			con = getCon();
			sql = "SELECT category, fcstValue FROM navi_weather "
					+ "WHERE category IN('TMP', 'REH', 'VEC', 'WSD', 'SKY', 'POP', 'PTY') "
					+ "AND fcstTime=date_format(curtime(), '%H00') "
					+ "AND nx=? "
					+ "AND ny=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, gridX);
			pstmt.setString(2, gridY);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				String category = rs.getString("category");
				
				if(category.equals("TMP")) {
					rDto.setTmp(rs.getString("fcstValue"));
				}
				
				if(category.equals("REH")) {
					rDto.setReh(rs.getString("fcstValue"));
				}
				
				if(category.equals("VEC")) {
					String vec = windTransfer(rs.getString("fcstValue"));
					rDto.setVec(vec);
				}
				
				if(category.equals("WSD")) {
					rDto.setWsd(rs.getString("fcstValue"));
				}
				
				if(category.equals("SKY")) {
					String sky = skyTransfer(rs.getString("fcstValue"));
					rDto.setSky(sky);
				}
				
				if(category.equals("POP")) {
					rDto.setPop(rs.getString("fcstValue"));
				}
				
				if(category.equals("PTY")) {
					rDto.setPty(rs.getString("fcstValue"));
				}
	
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return rDto;
		
	}
	
	public String skyTransfer (String sky) {
		
		String skyTransfer = "";
		
		switch (sky) {
		case "1":
			skyTransfer = "맑음";
			break;
		case "3":
			skyTransfer = "구름많음";
			break;
		case "4":
			skyTransfer = "흐림";
			break;
		}
		return skyTransfer;
		
	}
	
	
	public String windTransfer (String wsd) {
		
		String windTransfer = "";
		
		double windDouble = Double.parseDouble(wsd);
		
		int result = (int) Math.floor(((windDouble + 22.5) * 0.5) / 22.5);
		
		switch (result) {
		case 0:
			windTransfer = "북풍";
			break;
		case 1:
			windTransfer = "북북동풍";
			break;
		case 2:
			windTransfer = "북동풍";
			break;
		case 3:
			windTransfer = "동북동풍";
			break;
		case 4:
			windTransfer = "동풍";
			break;
		case 5:
			windTransfer = "동남동풍";
			break;
		case 6:
			windTransfer = "남동풍";
			break;
		case 7:
			windTransfer = "남남풍";
			break;
		case 8:
			windTransfer = "남풍";
			break;
		case 9:
			windTransfer = "남남서풍";
			break;
		case 10:
			windTransfer = "남서풍";
			break;
		case 11:
			windTransfer = "서남서풍";
			break;
		case 12:
			windTransfer = "서풍";
			break;
		case 13:
			windTransfer = "서북서풍";
			break;
		case 14:
			windTransfer = "북서풍";
			break;
		case 15:
			windTransfer = "북북서풍";
			break;
		case 16:
			windTransfer = "북풍";
			break;
		default:
			windTransfer = "오류";
		}
		return windTransfer;
		
	}
	
	
    
} // end class




