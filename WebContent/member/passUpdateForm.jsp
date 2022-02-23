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
		function passCheck() {
			
			if(document.fr.pass.value.length == 0) {
				alert("비밀번호를 입력하세요.")
				return false;
			}
			
			if(document.fr.newPass.value.length == 0) {
				alert("새 비밀번호를 입력하세요.")
				return false;
			}
			
			if(document.fr.newPass.value.length < 7) {
				alert("새 비밀번호는 7자리 이상 입력해주세요.")
				return false;
			}
			
			if(document.fr.newPass2.value.length == 0) {
				alert("새 비밀번호 확인을 입력해주세요.")
				return false;
			}
			
			if(document.fr.newPass.value != document.fr.newPass2.value) {
				alert("새 비밀번호 확인이 일치하지않습니다.")
				return false;
			}
			
		}	
	</script>
</head>
<body>

	<%
		String id = String.valueOf(session.getAttribute("id"));
	
		if(id == null){
			response.sendRedirect("../index.jsp");
		}	
	%>

	<jsp:include page="../inc/top.jsp"></jsp:include>
	
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
			<h1>비밀번호 변경</h1>
			<form action="passUpdatePro.jsp" method="POST" id="join" name="fr" onsubmit="return passCheck();">
				<fieldset>
					<legend>비밀번호 변경</legend>
					<label>현재 비밀번호</label> <input type="password" name="pass"><br>
					<label>새 비밀번호</label> <input type="password" name="newPass"><br>
					<label>새 비밀번호 확인</label> <input type="password" name="newPass2"><br>
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