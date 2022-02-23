<%@page import="com.navi.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>updatePassCheckPro.jsp</h1>
	
	<%
		response.setCharacterEncoding("UTF-8");
	
		String id = String.valueOf(session.getAttribute("id"));	
		String pass = request.getParameter("pass");
		
		if(id == null){
			response.sendRedirect("../alert/wrongApproach.jsp");
		}
	
		MemberDAO mDao = new MemberDAO();
		String[] info = mDao.info(id);
		
		if(pass.equals(info[1])){
			response.sendRedirect("updateForm.jsp");
		} else {
			response.sendRedirect("../alert/passCheckFail.jsp");
		}
	%>

</body>
</html>