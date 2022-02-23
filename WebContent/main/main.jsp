<%@page import="com.navi.weather.RealTimeWeatherDTO"%>
<%@page import="com.navi.weather.WeatherDTO"%>
<%@page import="com.navi.weather.WeatherDAO"%>
<%@page import="com.navi.member.MemberDAO"%>
<%@page import="com.navi.googletrend.GoogleTrendDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.navi.googletrend.GoogleTrendDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

<%
	String id = (String) session.getAttribute("id");
	String gridX = (String) session.getAttribute("gridX");
	String gridY = (String) session.getAttribute("gridY");
	
	MemberDAO mDao = new MemberDAO();
	Date nowDate = new Date(); 
	GoogleTrendDAO gTrendDAO = new GoogleTrendDAO();
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일 E요일");
	SimpleDateFormat simpleTimeFormat = new SimpleDateFormat("H");
	WeatherDAO wDao = new WeatherDAO();
	RealTimeWeatherDTO wDto = new RealTimeWeatherDTO();

	String nowDateFormated = simpleDateFormat.format(nowDate);
	int time = Integer.parseInt(simpleTimeFormat.format(nowDate));
	
	String dayNight = "";
	
	if(6 <= time && time <= 17) {
		dayNight = "day";
	} else {
		dayNight = "night";
	}

	ArrayList<Object> gTrendList = gTrendDAO.getGoogleTrend();
%>

</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp" />
	<!-- 헤더 -->
	<div id="wrap">
		<div class="clear"></div>
		<!-- 오늘의 이슈 박스 -->
		<div class="main_box issue_box">
			<div class="issue_box_title"> <h1>오늘의 키워드 <%=nowDateFormated %></h1></div>
			<hr>
			<%for(int i = 0; i < 10; i++) {
				GoogleTrendDTO gTrend = (GoogleTrendDTO) gTrendList.get(i); 
			%>
			<div class="issue_box_content">
				
			 <h2><%=i+1 %>위 <%=gTrend.getKeyWord() %></h2> <br>
			 <b><a href="<%=gTrend.getNewsLink() %>"> <%=gTrend.getNewsTitle() %> </a></b> <br><br>
			 <%=gTrend.getSnippet() %> <br><br>
			 <b>[<%=gTrend.getMediaName() %>]</b><br>
			</div>
			<hr>
			<%} %>
		</div>
		<!-- 오늘의 이슈 박스 -->
		<%
		
			/* 없음(0), 비(1), 비/눈(2), 눈(3), 소나기(4) */
  			String tmp = (String) session.getAttribute("tmp");
			
			// 로그아웃 상태
				// 실행 X - id == null
			
			// 로그인상태
				// 처음 로그인할때 id != null / tmp == null
				// 이미 로그인한 상태일때 id != null / tmp != null
				
			if (id == null) {
				 System.out.println("로그아웃 상태");
			} else if (id != null && tmp == null) {
				 System.out.println("첫 로그인");
				String[] tmxTmn = wDao.getTmxTmn(gridX, gridY);
				
				session.setAttribute("tmx", tmxTmn[0]);
				session.setAttribute("tmn", tmxTmn[1]);
				
				wDto = wDao.getRealTimeWeatherInfo(gridX, gridY);
				
				session.setAttribute("tmp", wDto.getTmp());
				session.setAttribute("pop", wDto.getPop());
				session.setAttribute("reh", wDto.getReh());
				session.setAttribute("vec", wDto.getVec());
				session.setAttribute("wsd", wDto.getWsd());
				session.setAttribute("sky", wDto.getSky());
				session.setAttribute("pty", wDto.getPty());
				
			} else if(id != null && tmp != null) {
				// System.out.println("로그인 상태");
			}
			
			String sky = (String) session.getAttribute("sky");
			String pty = (String) session.getAttribute("pty");
			String imgName = "";

			if(!pty.equals("0")) {
				switch(pty) {
				case "1":
				case "4":
					imgName = "rain";
					break;
				case "2":
				case "3":
					imgName = "snow";
				}	
			} else {
				switch(sky) {
				case "맑음":
					imgName = "sunny";
					break;
				case "구름많음":
					imgName = "cloud";
					break;
				case "흐림":
					imgName = "cloudy";
					break;
				}
			}
	
			System.out.println("imgName: " + imgName);
			System.out.println("SKY: " + sky);
			System.out.println("PTY: " + pty);
		%>
		<!-- 날씨 박스 -->
		<div class="main_box weather_box">
			<b class="weather_head">날씨정보</b> <hr>
			<div class="weather_box">
			<%if(id != null && wDto != null) { %> 
				<div class="tmp">
					<img class="weather_img" src="../images/weather_<%=dayNight %>/<%=imgName %>.png" width="50">
					<%=session.getAttribute("tmp") %>°
				</div> <br>
				<div class="tmx_tmn">
					<span class="red"><%=session.getAttribute("tmx") %>°</span> 
					<span class="grey" > / </span> 
					<span class="blue"><%=session.getAttribute("tmn") %>°</span> <br>
				</div> <br>
				<div class="rain">강수확률 <%=session.getAttribute("pop") %>%</div>
				<div class="rain">풍향 <%=session.getAttribute("vec") %> </div>
				<div class="rain">풍속 <%=session.getAttribute("wsd") %> m/s </div>
				<div class="rain">습도 <%=session.getAttribute("reh") %>%</div>
			<%} else { %>
			 	<h3>로그인하세요!</h3>
			<%}%>
			</div>
		</div>
		<!-- 날씨 박스 -->
		<div class="clear"></div>
	</div>
	<!-- 푸터  -->
	<jsp:include page="../inc/bottom.jsp" />
	<!-- 푸터  -->
	
</body>
</html>