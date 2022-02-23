<%@page import="com.navi.member.MemberDAO"%>
<%@page import="com.navi.member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>joinPro.jsp</h1>
	
	<%
		request.setCharacterEncoding("UTF-8"); 
	%>
	
	<jsp:useBean id="mDto" class="com.navi.member.MemberDTO"></jsp:useBean>
	<jsp:setProperty property="*" name="mDto"/>

	<%
		MemberDAO mDao = new MemberDAO();
		mDao.insertMember(mDto);
		
		response.sendRedirect("loginForm.jsp");
	%>
	
</body>
</html>