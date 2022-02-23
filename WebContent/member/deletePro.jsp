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
	<h1>deletePro.jsp</h1>
	
	<%
		request.setCharacterEncoding("UTF-8");
	
		String id = String.valueOf(session.getAttribute("id"));
		String pass = request.getParameter("pass");
		
		if(id == null){
			response.sendRedirect("../index.jsp");
		}
		
		MemberDAO mDao = new MemberDAO();
		
		int result = mDao.deleteMember(id, pass);
		
		if(result == -1) {
			%>
			<script type="text/javascript">	
				alert("오류입니다.");
				history.back();
			</script>
			<%	
		} else if(result == 0) {
			%>
			<script type="text/javascript">	
	    		alert("비밀번호가 잘못되었습니다.");
	    		history.back();
			</script>
			<%	
		} else {
			%>
			<script type="text/javascript">
				alert("회원탈퇴가 완료되었습니다.");
				location.href="../index.jsp";
			</script>
			<%
		}
	%>

</body>
</html>