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
	<jsp:include page="../inc/top.jsp"/>
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
			<%
				// 전달된 파라미터값 저장(num,pageNum)
				int num = Integer.parseInt(request.getParameter("num"));
				String pageNum = request.getParameter("pageNum");

				// DAO 객체 생성
				BoardDAO bdao = new BoardDAO();

				// 조회수 1증가  - updateReadcount();
				bdao.updateReadcount(num);

				// 기존의 글정보를 가져오기
				BoardDTO bdto = bdao.getBoard(num);
			%>
			
			<h1><%=bdto.getSubject()%></h1>
			<hr>
			<div class="writer">
				작성자 | <b><%=bdto.getName() %></b>
			</div>
			<div class="readcount_date">
				조회수 <%=bdto.getReadcount() %> | 작성일 <%=bdto.getDate() %>
				<hr>
			</div>
			<div class="content">
				<%=bdto.getContent()%>
			</div>
			<div id="table_search">
				<hr>
				<input type="button" value="수정하기" class="btn"
					onclick="location.href='updateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
				<input type="button" value="삭제하기" class="btn"
					onclick="location.href='deleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
				<input type="button" value="답글쓰기" class="btn"
					onclick="location.href='reWriteForm.jsp?num=<%=num%>&re_ref=<%=bdto.getRe_ref()%>&re_lev=<%=bdto.getRe_lev()%>&re_seq=<%=bdto.getRe_seq()%>';">
				<input type="button" value="목록으로" class="btn"
					onclick=" location.href='notice.jsp?pageNum=<%=pageNum%>' ">
			</div>
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