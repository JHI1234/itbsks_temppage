<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%	
	int num = Integer.parseInt(request.getParameter("num"));	//<a href="content.jsp?num=<%=article.getNum() 에서 반환된 num
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="style.css">

<script type="text/javascript" src="./script.js"></script>
<style>
	th{width:200pt;}
	td{width:200pt;}
</style>
</head>
<body>
<header>
	<jsp:include page="../module/top-sub.jsp" flush="false"/>
	<jsp:include page="../module/header/board.jsp" flush="false"/>
</header>
	<p>글삭제</p>
	<form method="post" name="insertform" action="deletePro.jsp" onsubmit="return writeSave()">
		<table>
			<tr>
				<th class="thcolor">비밀번호를 입력해주세요!</th>
			</tr>
			<tr>
				<td class="tdcolor">
					<input class="passcheck" type="password" size="8" maxlength="15" name="passwd">
					<input type="hidden" name="num" value="<%= num %>"> <!--게시글 num 값은 hidden으로 전달  -->
					<input type="hidden" name="pageNum" value="<%= pageNum %>"> <!--게시글 num 값은 hidden으로 전달  -->
				</td>
			</tr>
			<tr>
				<th colspan="2" class="thcolor">
					<input type="submit" value="삭 제">
					<input type="button" value="목록보기" onclick="window.location='freeboard.jsp?pageNum=<%= pageNum %>'">
				</th>
			</tr>
		</table>
<footer>
	<jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>