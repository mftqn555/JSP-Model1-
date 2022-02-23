<%@page import="com.navi.member.MemberDAO"%>
<%@page import="com.navi.weather.WeatherDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

	// 로그인 후 로그인 정보로 X,Y좌표 받아서 중복 확인 후 중복 없으면 DB에 저장	

	request.setCharacterEncoding("UTF-8");
	
	String id = (String) session.getAttribute("id");
	
	MemberDAO mDao = new MemberDAO();
	WeatherDAO wDao = new WeatherDAO();
	
	String[] info = mDao.info(id);
	
	String gridX = info[10].substring(0, info[10].length()-2);
	String gridY = info[11].substring(0, info[11].length()-2);
	
	session.setAttribute("gridX", gridX);
	session.setAttribute("gridY", gridY);

	// DB에 날씨데이터 삽입, 중복체크
	
	int result = wDao.weatherInfoDuplicationCheck(gridX, gridY);
	
	if(result == 1){
		response.sendRedirect("../main/main.jsp?gridX=" + gridX + "&gridY=" + gridY);
	} else if(result <= 0){
		ArrayList<Object> weatherList = wDao.getWeatherInfo(gridX, gridY);
		
		wDao.insertWeatherInfo(weatherList);
		
		response.sendRedirect("../main/main.jsp?gridX=" + gridX + "&gridY=" + gridY);
	} 
%>

</body>
</html>