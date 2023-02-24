<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="qnaboard.QnaboardDAO" %>
<%@ page import="qnaboard.QnaboardVO" %>

<%	
	int num = Integer.parseInt(request.getParameter("num"));	//<a href="content.jsp?num=<%=article.getNum() 에서 반환된 num
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));

	QnaboardDAO qdao = QnaboardDAO.getInstance();
	QnaboardVO article = qdao.getArticleUpdate(num);
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="../css/board.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="./script.js"></script>
<style>
	span{widspan:80pt;}
	span{widspan:300pt;}
</style>
</head>
<body>
<header>
	<jsp:include page="../module/top-sub.jsp" flush="false"/>
	<jsp:include page="../module/header/board.jsp" flush="false"/>
</header>
<section class="board-top">
	<h2>게시글 수정</h2>
	<hr>
	<div id="board_box">
	<form method="post" name="insertform" action="updatePro.jsp" onsubmit="return writeSave()">
   	 <ul id="board_form">
			<li>
				<span class="col1">이 름</span>
				<span class="col2">
					<input type="text" size="10" maxlength="20" name="writer" value="<%= article.getWriter()%>">
					<input type="hidden" name="num" value="<%= article.getNum()%>"> <!--게시글 num 값은 hidden으로 전달  -->
					<input type="hidden" name="pageNum" value="<%= pageNum%>">
				</span>
			</li>
			<li>
				<span class="col1">제 목</span>
				<span class="col2">
					<input type="text" size="40" maxlength="30" name="subject" value="<%= article.getSubject()%>">
				</span>
			</li>
   			<li id="text_area">	
				<span class="col1 t-area">내 용</span>
				<span class="col2">
					<textarea  name="content" rows="13" cols="42" ><%= article.getContent()%></textarea>
				</span>
			</li>
			<li>
				<span class="col1">패스워드</span>
				<span class="col2">
					<input type="password" size="8" maxlength="15" name="passwd">
				</span>
			</li>
		</ul>
		<hr>
   		<ul class="buttons center">
			<li>
				<input type="submit" value="수정" >
				<input type="reset" value="다시작성">
				<input type="button" value="목록보기" onclick="window.location='qna.jsp?pageNum=<%= pageNum %>'">
			</li>
		</ul>
	</form>
	</div>
</section>
<footer>
	<jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>