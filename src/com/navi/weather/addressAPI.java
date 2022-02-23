package com.navi.weather;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;

import javax.net.ssl.HttpsURLConnection;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class addressAPI {

	public static void main(String[] args) throws Exception {

		String address = "부산 북구 만덕2로 10";

		address = URLEncoder.encode(address, "UTF-8");

		String url = "https://dapi.kakao.com/v2/local/search/address.json?query=" + address;
		String jsonString = new String();
		String buf;

		URL Url = new URL(url);

		HttpsURLConnection conn = (HttpsURLConnection) Url.openConnection();
		String auth = "KakaoAK " + "f04578997ca2b542f3139ba72eb5bf15";

		conn.setRequestMethod("GET");
		conn.setRequestProperty("X-Requested-With", "curl");
		conn.setRequestProperty("Authorization", auth);

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		
		while ((buf = br.readLine()) != null) {
			jsonString += buf;
		}

		System.out.println(jsonString);

		JSONParser paser = new JSONParser();

		JSONObject J = (JSONObject) paser.parse(jsonString);

		JSONArray data = (JSONArray) J.get("documents");

		JSONObject tmp = (JSONObject) data.get(0);

		JSONObject tmp2 = (JSONObject) tmp.get("road_address");

		String tmp3 = (String) tmp2.get("region_2depth_name");
		String tmp4 = (String) tmp2.get("region_3depth_name");
		
		String x = (String) tmp2.get("x");
		String y = (String) tmp2.get("y");

		System.out.println(tmp3.toString());
		System.out.println(tmp4);
		
		System.out.println(x + " / " + y);
		
		String tmp5 = tmp3 + ", " + tmp4;
		System.out.println(tmp5);

	}

}
