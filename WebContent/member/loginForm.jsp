<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function loginCheck() {
			
			if(document.fr.id.value.length == 0) {
				alert("아이디를 입력하세요.");
				return false;
			}
			
			if(document.fr.pass.value.length == 0) {
				alert("패스워드를 입력하세요.")
				return false;
			}
			
		}	
	</script>
</head>
<body>
	
	<%
		String id = (String) session.getAttribute("id");
		if(id != null) {
			response.sendRedirect("../main/main.jsp");
		}
	%>
	
	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- 헤더 -->
	<div id="wrap">
		<!-- 본문들어가는 곳 -->
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="#">Join us</a></li>
				<li><a href="#">Privacy policy</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<article class="board_box">
			<h1>로그인</h1>
			<form action="loginPro.jsp" method="POST" id="join" name="fr" onsubmit="return loginCheck();">
				<fieldset>
					<legend>Login Info</legend>
					<label>아이디</label> <input type="text" name="id"><br>
					<label>패스워드</label> <input type="password" name="pass"><br>
				</fieldset>
				<div class="clear"></div>
				<div id="buttons">
					<input type="submit" value="Submit" class="submit"> <input
						type="button" value="Cancel" class="cancel">
				</div>
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