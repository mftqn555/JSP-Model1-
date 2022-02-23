<%@page import="sun.security.krb5.internal.PAEncTSEnc"%>
<%@page import="com.navi.board.BoardDTO"%>
<%@page import="java.util.List"%>
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

		<%
			// BoardDAO 객체 생성
			BoardDAO bdao = new BoardDAO();
			// 게시판 DB에 있는 글 개수를 확인
			int cnt = bdao.getBoardCount();

			///////////////////////////////////////////////////////////////////////////////
			// 페이징 처리

			// 한 페이지에 출력될 글 개수
			int pageSize = 10;

			// 현 페이지 정보 설정
			String pageNum = request.getParameter("pageNum");
			if (pageNum == null) {
				pageNum = "1";
			}

			// 첫행번호를 계산
			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage - 1) * pageSize + 1;

			///////////////////////////////////////////////////////////////////////////////
		%>

		<!-- 게시판 -->
		<article class="board_box">
			<h2>게시판</h2>
			<hr>
			<div class="board_nav">
				
			</div>
			<table id="notice">
				<tr>
					<th class="tno">글번호</th>
					<th class="ttitle">제목</th>
					<th class="twrite">작성자</th>
					<th class="tdate">작성일</th>
					<th class="tread">조회수</th>
				</tr>
				<%
					if (cnt != 0) {
						// DB에 있는 게시판의 글정보 모두를 가져오기

						//List boardList = bdao.getBoardList();
						List boardList = bdao.getBoardList(startRow, pageSize);
						for (int i = 0; i < boardList.size(); i++) {
							BoardDTO bdto = (BoardDTO) boardList.get(i);
				%>
				<tr>
					<td><%=bdto.getNum()%></td>
					<td class="left">
						<%
							if (bdto.getRe_lev() > 0) { //답글일때
						%> 
						<img src="level.gif" height="10" width="<%=bdto.getRe_lev() * 10%>"> <img src="re.gif"> 
						<%
 							}
 						%> 
 					<a href="contents.jsp?num=<%=bdto.getNum()%>&pageNum=<%=pageNum%>"><%=bdto.getSubject()%></a>
					</td>
					<td><%=bdto.getName()%></td>
					<td><%=bdto.getDate()%></td>
					<td><%=bdto.getReadcount()%></td>
				</tr>
				<%
					} // end for
				} else {	// 게시판에 글이 없을 때
				%>
				<tr>
					<td colspan="5">게시판에 글이 없습니다.<br> 새 글을 작성하세요~!<br> <a
						href="boardWrite.jsp"> 글 쓰기페이지로 </a>
					</td>
				</tr>
				<%
					}
				%>
			</table>
			<div class="clear"></div>
			<div id="page_control">
				<%
					if (cnt != 0) {
						////////////////////////////////////////////////////////////
						// 페이징 처리
						// 전체 페이지수 계산
						int pageCount = cnt / pageSize + (cnt % pageSize == 0 ? 0 : 1);

						// 한 페이지에 보여줄 페이지블럭
						int pageBlock = 2;

						// 한 페이지에 보여줄 페이지 블럭 시작번호 계산
						int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;

						// 한 페이지에 보여줄 페이지 블럭 끝번호 계산
						int endPage = startPage + pageBlock - 1;
						if (endPage > pageCount) {
							endPage = pageCount;
						}
				%>
				<%
					if (startPage > pageBlock) {
				%>
				<a href="notice.jsp?pageNum=<%=startPage - pageBlock%>">Prev</a>
				<%
					}
				%>

				<%
					for (int i = startPage; i <= endPage; i++) {
				%>
				<a href="notice.jsp?pageNum=<%=i%>"><%=i%></a>
				<%
					}
				%>

				<%
					if (endPage < pageCount) {
				%>
				<a href="notice.jsp?pageNum=<%=startPage + pageBlock%>">Next</a>
				<%
					}
				%>

				<%
					}
				%>
			</div>
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