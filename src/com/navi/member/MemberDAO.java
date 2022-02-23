package com.navi.member;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.net.ssl.HttpsURLConnection;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.navi.member.MemberDTO;


public class MemberDAO {

    public static final int TO_GRID= 0;
    public static final int TO_GPS= 1;
    
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
	
	public GpsXY getJsonData(String address) throws Exception {
		
		address = URLEncoder.encode(address,"UTF-8");
		
		String url = "https://dapi.kakao.com/v2/local/search/address.json?query="+ address;
		String jsonString = new String();
		String buf;
	
		  URL Url = new URL(url);
		
		  HttpsURLConnection conn = (HttpsURLConnection) Url.openConnection();
		  String auth ="KakaoAK " +"f04578997ca2b542f3139ba72eb5bf15";
		  
		  conn.setRequestMethod("GET");
		  conn.setRequestProperty("X-Requested-With", "curl");
		  conn.setRequestProperty("Authorization", auth);
		
		  BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		  while((buf = br.readLine()) != null) {
		  jsonString += buf;
		  }
		  JSONParser paser = new JSONParser();
		
		  JSONObject J = (JSONObject)paser.parse(jsonString);
		  JSONObject meta = (JSONObject) J.get("meta");
		
		  JSONArray data = (JSONArray) J.get("documents");
		  long size = (long) meta.get("total_count");
		
		  GpsXY rs = new GpsXY();
		
		  if(size > 0) {
		  JSONObject jsonX = (JSONObject)data.get(0);
		  
		  rs.setX(Double.parseDouble(jsonX.get("y").toString()));
		  rs.setY(Double.parseDouble(jsonX.get("x").toString()));
		  
		  }
		  return rs;
				
	}

    public LatXLngY convertGRID_GPS(int mode, double lat_X, double lng_Y ) {
    	
        double RE = 6371.00877; // 지구 반경(km)
        double GRID = 5.0; // 격자 간격(km)
        double SLAT1 = 30.0; // 투영 위도1(degree)
        double SLAT2 = 60.0; // 투영 위도2(degree)
        double OLON = 126.0; // 기준점 경도(degree)
        double OLAT = 38.0; // 기준점 위도(degree)
        double XO = 43; // 기준점 X좌표(GRID)
        double YO = 136; // 기1준점 Y좌표(GRID)

        //
        // LCC DFS 좌표변환 ( code : "TO_GRID"(위경도->좌표, lat_X:위도,  lng_Y:경도), "TO_GPS"(좌표->위경도,  lat_X:x, lng_Y:y) )
        //

        double DEGRAD = Math.PI/ 180.0;
        double RADDEG = 180.0 / Math.PI;

        double re = RE / GRID;
        double slat1 = SLAT1 * DEGRAD;
        double slat2 = SLAT2 * DEGRAD;
        double olon = OLON * DEGRAD;
        double olat = OLAT * DEGRAD;

        double sn = Math.tan(Math.PI* 0.25 + slat2 * 0.5) / Math.tan(Math.PI* 0.25 + slat1 * 0.5);
        sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);
        double sf = Math.tan(Math.PI* 0.25 + slat1 * 0.5);
        sf = Math.pow(sf, sn) * Math.cos(slat1) / sn;
        double ro = Math.tan(Math.PI* 0.25 + olat * 0.5);
        ro = re * sf / Math.pow(ro, sn);
        
        LatXLngY rs = new LatXLngY();

        if (mode ==TO_GRID) {
            rs.lat = lat_X;
            rs.lng = lng_Y;
            double ra = Math.tan(Math.PI* 0.25 + (lat_X) * DEGRAD * 0.5);
            ra = re * sf / Math.pow(ra, sn);
            double theta = lng_Y * DEGRAD - olon;
            if (theta > Math.PI) theta -= 2.0 * Math.PI;
            if (theta < -Math.PI) theta += 2.0 * Math.PI;
            theta *= sn;
            rs.x = Math.floor(ra * Math.sin(theta) + XO + 0.5);
            rs.y = Math.floor(ro - ra * Math.cos(theta) + YO + 0.5);
        } else {
            rs.x = lat_X;
            rs.y = lng_Y;
            double xn = lat_X - XO;
            double yn = ro - lng_Y + YO;
            double ra = Math.sqrt(xn * xn + yn * yn);
            if (sn < 0.0) {
                ra = -ra;
            }
            double alat = Math.pow((re * sf / ra), (1.0 / sn));
            alat = 2.0 * Math.atan(alat) - Math.PI* 0.5;

            double theta = 0.0;
            if (Math.abs(xn) <= 0.0) {
                theta = 0.0;
            } else {
                if (Math.abs(yn) <= 0.0) {
                    theta = Math.PI* 0.5;
                    if (xn < 0.0) {
                        theta = -theta;
                    }
                } else theta = Math.atan2(xn, yn);
            }
            double alon = theta / sn + olon;
            rs.lat = alat * RADDEG;
            rs.lng = alon * RADDEG;
        }
        return rs;
        
    }
	
	public void insertMember(MemberDTO mDto) throws Exception {
		
		GpsXY xy1 = new GpsXY();
		LatXLngY xy2  = new LatXLngY();
		
		xy1 = getJsonData(mDto.getRoadAddress());
		xy2 = convertGRID_GPS(0, xy1.getX(), xy1.getY());
		
		try {
			con = getCon();
			sql = "INSERT INTO navi_member("
					+ "id, pass, name, email, zonecode, roadAddress, jibunAddress, detailAddress, extraAddress, reg_date, gridX, gridY) "
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, mDto.getId());
			pstmt.setString(2, mDto.getPass());
			pstmt.setString(3, mDto.getName());
			pstmt.setString(4, mDto.getEmail());
			pstmt.setInt(5, mDto.getZonecode());
			pstmt.setString(6, mDto.getRoadAddress());
			pstmt.setString(7, mDto.getJibunAddress());
			pstmt.setString(8, mDto.getDetailAddress());
			pstmt.setString(9, mDto.getExtraAddress());
			pstmt.setInt(10, (int)xy2.x);
			pstmt.setInt(11, (int)xy2.y);
			
			pstmt.executeUpdate();
			
			// System.out.println("DAO: insertMember() 실행 성공");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}
	
	public int loginCheck(String id, String pass) {
		
		int result = -1;
		
		try {
			con = getCon();
			sql = "SELECT pass FROM navi_member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(pass.equals(rs.getString("pass"))) {
					result = 1;
				} else {
					result = 0;
				}				
			} else {
				result = -1;
			}
			// System.out.println("DAO: loginCheck() 실행 완료 / result:" + result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
		
	}
	
	public int idCheck(String id) {
		
		int result = 1;
		
		try {
			con = getCon();
			sql = "SELECT id FROM navi_member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next() || id.equals("")) {
				result = -1;
			} else {
				result = 1;
			}
			// System.out.println("DAO: idCheck() 실행완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	}
	
	public String[] info(String id) {
		String[] info = new String[12];
		try {
			con = getCon();
			sql = "SELECT * FROM navi_member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {

				info[0] = rs.getString("id");
				info[1] = rs.getString("pass");
				info[2] = rs.getString("name");
				info[3] = rs.getString("email");
				info[4] = rs.getString("reg_date");
				info[5] = String.valueOf(rs.getInt("zonecode"));
				info[6] = rs.getString("roadAddress");
				info[7] = rs.getString("jibunAddress");
				info[8] = rs.getString("detailAddress");
				info[9] = rs.getString("extraAddress");
				info[10] = String.valueOf(rs.getDouble("gridX"));
				info[11] = String.valueOf(rs.getDouble("gridY"));
				
				// System.out.println("DAO: info() 실행 완료");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return info;
		
	}
	
	public int updatePass(String id, String pass, String newPass) {
		
		int result = -1;
		
		try {
			con = getCon();
			sql = "SELECT pass FROM navi_member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(pass.equals(rs.getString("pass"))) {
					sql="UPDATE navi_member SET pass=? WHERE id=?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, newPass);
					pstmt.setString(2, id);
					pstmt.executeUpdate();
					
					result = 1;
				} else {
					result = 0;
				}				
			} else {
				result = -1;
			}
			// System.out.println("DAO: updatePass() 실행 완료 / result:" + result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
		
	}
	
	public void updateMember(MemberDTO mDto) {

		try {
			con = getCon();
			sql = "UPDATE navi_member SET "
					+ "name=?, email=?, zonecode=?, roadAddress=?, "
					+ "jibunAddress=?, detailAddress=?, extraAddress=? "
					+ "WHERE id=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, mDto.getName());
			pstmt.setString(2, mDto.getEmail());
			pstmt.setInt(3, mDto.getZonecode());
			pstmt.setString(4, mDto.getRoadAddress());
			pstmt.setString(5, mDto.getJibunAddress());
			pstmt.setString(6, mDto.getDetailAddress());
			pstmt.setString(7, mDto.getExtraAddress());
			pstmt.setString(8, mDto.getId());
			
			pstmt.executeUpdate();
			
			// System.out.println("DAO: updateMember() 실행 성공");
	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}
	
	public int deleteMember(String id, String pass) {
		int result = -1;
		try {
			con = getCon();
			sql = "SELECT pass FROM navi_member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,id);

			rs = pstmt.executeQuery();

			if(rs.next()) { 	
				if(pass.equals(rs.getString("pass"))) { 	
					sql = "DELETE from navi_member WHERE id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);					
					
					result = pstmt.executeUpdate();
					// System.out.println("회원탈퇴 완료");
				} else {
					result = 0;
				}
			} else {
				result = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	 
	}
	
}

class LatXLngY {
    public double lat;
    public double lng;

    public double x;
    public double y;
}

