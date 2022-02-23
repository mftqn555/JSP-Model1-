<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<header id="header_shadow">
	<nav id="header_wrap">
		<div id="login">
			<%
				String id = (String)session.getAttribute("id");
				String name = (String)session.getAttribute("name");
			%>
			
			<%if(id != null) {%>
				<%=name %>님 환영합니다! | <a href="../member/logoutPro.jsp">로그아웃</a>
			<% } else {%>
			<a href="../member/loginForm.jsp">로그인</a> | <a href="../member/joinForm.jsp">회원가입</a>
			<%} %>
		</div>
		<div class="clear"></div>
		<!-- 로고들어가는 곳 -->
		<div id="logo">
			<img src="../images/logo.gif" width="265" height="62" alt="Fun Web">
		</div>
		<!-- 로고들어가는 곳 -->
		<div id="top_menu">
			<ul class="top_menu_link">
				<li><a href="../index.jsp">홈</a></li>
				<li><a href="../center/notice.jsp">커뮤니티</a></li>
				<li><a href="../member/info.jsp">회원 정보</a></li>
			</ul>
		</div>
	</nav>
</header>
