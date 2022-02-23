<%@page import="com.navi.board.BoardDTO"%>
<%@page import="com.navi.board.BoardDAO"%>
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
			<h1>글 수정 페이지</h1>

			<%
				// 전달되는 정보저장(파라미터)
				int num = Integer.parseInt(request.getParameter("num"));
				String pageNum = request.getParameter("pageNum");
				// DB안에 있는데이터 저장
				BoardDAO bdao = new BoardDAO();
				BoardDTO bdto = bdao.getBoard(num);
			%>

			<form action="updatePro.jsp?pageNum=<%=pageNum%>" method="post">
				<input type="hidden" name="num" value="<%=bdto.getNum()%>">

				<table id="notice">
					<tr>
						<th class="tno" colspan="5">게시글 수정하기</th>
					</tr>
					<tr>
						<td colspan="2">글쓴이 :</td>
						<td class="left" colspan="3"><input type="text" name="name"
							value="<%=bdto.getName()%>"></td>
					</tr>

					<tr>
						<td colspan="2">글 비밀번호 :</td>
						<td class="left" colspan="3"><input type="password"
							name="pass"></td>
					</tr>

					<tr>
						<td colspan="2">글 제목 :</td>
						<td class="left" colspan="3"><input type="text"
							name="subject" value="<%=bdto.getSubject()%>"></td>
					</tr>

					<tr>
						<td colspan="2">글 내용 :</td>
						<td class="left" colspan="3"><textarea rows="20" cols="50"
								name="content"><%=bdto.getContent()%></textarea></td>
					</tr>
				</table>
				<div id="table_search">
					<input type="submit" value="수정하기" class="btn">
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