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
	<h1>loginPro.jsp</h1>
	
	<%
		request.setCharacterEncoding("UTF-8");
	
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		
		// DB에 데이터 삽입
		
		
		MemberDAO mDao = new MemberDAO();
		
		int result = mDao.loginCheck(id, pass);
		
		if(result == -1) {
			%>
			<script type="text/javascript">	
				alert("아이디 또는 비밀번호가 잘못되었습니다.");
				history.back();
			</script>
			<%	
		} else if(result == 0) {
			%>
			<script type="text/javascript">	
	    		alert("아이디 또는 비밀번호가 잘못되었습니다.");
	    		history.back();
			</script>
			<%	
		} else {
			String[] info = mDao.info(id);
			session.setAttribute("name", info[2]);
			session.setAttribute("id", id);
			response.sendRedirect("weatherInsertPro.jsp");
		}
	%>

</body>
</html>