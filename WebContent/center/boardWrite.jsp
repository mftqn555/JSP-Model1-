<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
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
				<li><a href="boardWrite.jsp">글쓰기</a></li>
				<li><a href="notice.jsp">게시판 목록</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 게시판 -->
		<article class="board_box">
			<h1>글쓰기 페이지</h1>

			<form action="boardWritePro.jsp" method="post">
				<table id="notice">
					<tr>
						<th class="tno" colspan="5">ITWILL 게시판</th>
					</tr>

					<tr>
						<td colspan="2">글쓴이 :</td>
						<td class="left" colspan="3"><input type="text" name="name">
						</td>
					</tr>

					<tr>
						<td colspan="2">글 비밀번호 :</td>
						<td class="left" colspan="3"><input type="password"
							name="pass"></td>
					</tr>

					<tr>
						<td colspan="2">글 제목 :</td>
						<td class="left" colspan="3"><input type="text"
							name="subject"></td>
					</tr>

					<tr>
						<td colspan="2">글 내용 :</td>
						<td class="left" colspan="3"><textarea rows="20" cols="50"
								name="content"
								></textarea></td>
					</tr>
				</table>
				<div id="table_search">
					<input type="submit" value="글쓰기" class="btn">
				</div>
			</form>
			<div class="clear"></div>
		</article>
		<!-- 게시판 -->
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
	</div>
	<!-- 푸터 -->
	<jsp:include page="../inc/bottom.jsp" />
	<!-- 푸터 -->
</body>
</html>