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

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	   function execDaumPostcode() {
	       new daum.Postcode({
	           oncomplete: function(data) {
	               var roadAddr = data.roadAddress; 
	               var extraRoadAddr = ''; 
	
	               if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                   extraRoadAddr += data.bname;
	               }
	               
	               if(data.buildingName !== '' && data.apartment === 'Y'){
	                  extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	               }
	               
	               if(extraRoadAddr !== ''){
	                   extraRoadAddr = ' (' + extraRoadAddr + ')';
	               }
	
	               document.getElementById('postcode').value = data.zonecode;
	               document.getElementById("roadAddress").value = roadAddr;
	               document.getElementById("jibunAddress").value = data.jibunAddress;
	               
	               if(roadAddr !== ''){
	                   document.getElementById("extraAddress").value = extraRoadAddr;
	               } else {
	                   document.getElementById("extraAddress").value = '';
	               }
	
	               var guideTextBox = document.getElementById("guide");
	               
	               if(data.autoRoadAddress) {
	                   var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                   guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                   guideTextBox.style.display = 'block';
	
	               } else if(data.autoJibunAddress) {
	                   var expJibunAddr = data.autoJibunAddress;
	                   guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                   guideTextBox.style.display = 'block';
	               } else {
	                   guideTextBox.innerHTML = '';
	                   guideTextBox.style.display = 'none';
	               }
	           }
	       }).open();
	       
	   }
	</script> 
	 
	 
	<script type="text/javascript">
	function passCheck(){
		if(document.fr.pass1.value != document.fr.pass2.value){
			alert(" 비밀번호가 일치하지 않습니다 ");
			document.fr.pass2.focus();
		} else if (document.fr.pass.value == document.fr.pass2.value){
			alert(" 비밀번호가 일치합니다 ");
			document.fr.pass2.disabled = true;
		}
		
	}
	
	function checkJoin(){
		if(document.fr.id.value.length < 5) {
			alert("아이디는 5글자 이상이여야 합니다");
			document.fr.id.focus();
			return false;
		}
		
		if(document.fr.pass.value < 7){
			alert(" 비밀번호를 입력하세요 ");
			document.fr.pass1.focus();
			return false;
		}
		
		if(document.fr.pass.value != document.fr.pass2.value){
			alert(" 비밀번호가 일치하지 않습니다 ");
			document.fr.pass2.focus();
			return false;
		}
		
		if(document.fr.name.value.length < 2){
			alert(" 이름을 입력하세요. ");
			document.fr.name.focus();
			return false;
		}
		
		if(document.fr.email.value.length < 2){
			alert(" 이메일을 입력하세요. ");
			document.fr.name.focus();
			return false;
		}
		
		var email = document.fr.email.value;
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	
		if(exptext.test(email)==false){
			//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
			alert("이메일형식이 올바르지 않습니다.");
			document.fr.email.focus();
			return false;
		}
		
	}
	</script>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp" />
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
			<h1>Join Us</h1>
			<form action="joinPro.jsp" id="join" name="fr" method="POST" onsubmit="return checkJoin();">
				<fieldset>
					<legend>정보</legend>
					<label>아이디</label> <input type="text" name="id" class="id">
					<input type="button" value="아이디 중복확인" class="dup" onclick=""><br>
					<label>비밀번호</label> <input type="password" name="pass"><br>
					<label>비밀번호 확인</label> <input type="password" name="pass2"><br>
					<label>성명</label> <input type="text" name="name"><br>
					<label>이메일</label> <input type="email" name="email"><br>
					<!-- 가입축하메일 보내기 -->
				</fieldset>

				<fieldset>
					<legend>주소</legend>
				
					<input type="text" id="postcode" name="zonecode" placeholder="우편번호">
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" id="roadAddress" name="roadAddress" placeholder="도로명주소">
					<input type="text" id="jibunAddress" name="jibunAddress" placeholder="지번주소">
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소">
					<input type="text" id="extraAddress" name="extraAddress" placeholder="참고항목">
					
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
	
	<%
		MemberDAO mDao = new MemberDAO();
	%>

	<script src="../js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">	
		$(document).ready(function(){
			$('.id').focusout(function(){
				var id = $('.id').val();
				
				$.ajax({
					url: "idCheckPro.jsp",
					type: "POST",
					data: {id: id},
					success : function(result) {
						console.log(result);
						if(result == 1) {
							alert("사용가능한 아이디입니다");
						} else {
							alert("사용할 수 없는 아이디입니다")
						}
					},
					error : function(){
						alert("오류입니다")
					}
					
				})
				
			});
		});
	</script>
		
</body>
</html>