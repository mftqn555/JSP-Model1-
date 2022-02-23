<%@page import="com.navi.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
		String id = (String)session.getAttribute("id");
		
		if(id == null){
			response.sendRedirect("../alert/loginAlert.jsp");
		}
	
		MemberDAO mDao = new MemberDAO();
		
		String[] info = mDao.info(id);
	%>
	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp" />
	<!-- 헤더 -->
	<div id="wrap">
		<!-- 본문들어가는 곳 -->
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="passCheckForm.jsp">내 정보 수정</a></li>
				<li><a href="passUpdateForm.jsp">비밀번호 수정</a></li>
				<li><a href="deleteForm.jsp">회원탈퇴</a></li>				
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<article class="board_box">
			<h1>Info</h1>
			<form action="" id="join" name="fr">
				<fieldset>
					<legend>회원 정보</legend>
					<label>아이디</label><br><%=info[0] %><br>
					<label>성명</label><br> <%=info[2] %><br>
					<label>이메일</label><br> <%=info[3] %><br>
					<label>가입일</label><br> <%=info[4] %> <br>
				</fieldset>

				<fieldset>
					<legend>주소</legend>
					<label>우편번호</label> <br><%=info[5] %> <br>
					<label>도로명 주소</label> <br><%=info[6] %> <br>
					<label>지번 주소</label> <br><%=info[7] %> <br>
					<label>상세 주소</label> <br><%=info[8] %> <br>
					<label>참고항목</label><br> <%=info[9] %> <br>
				</fieldset>
				<div class="clear"></div>
			</form>
		</article>
		<!-- 본문내용 -->
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
	</div>
	<!-- 푸터 -->
	<jsp:include page="../inc/bottom.jsp" />
	<!-- 푸터 -->
</body>
</html>