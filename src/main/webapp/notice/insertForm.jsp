<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="style.css">

<script type="text/javascript" src="./script.js"></script>
<style>
	th{width:80pt;}
	td{width:300pt;}
</style>
</head>
<body>
<header>
	<jsp:include page="../module/top-sub.jsp" flush="false"/>
	<jsp:include page="../module/header/board.jsp" flush="false"/>
</header>
<p>글쓰기</p>
	<form method="post" name="insertform" action="insertPro.jsp" onsubmit="return writeSave()">
		<table>
			<tr>
				<th class="thcolor">이 름</th>
				<td class="tdcolor1">
					<input type="text" size="10" maxlength="20" name="writer">
				</td>
			</tr>
			<tr>
				<th class="thcolor">제 목</th>
				<td class="tdcolor1">
					<input type="text" size="40" maxlength="30" name="subject">
				</td>
			</tr>
			<tr>
				<th class="thcolor">Email</th>
				<td class="tdcolor1">
					<input type="text" size="40" maxlength="30" name="email">
				</td>
			</tr>
			<tr>
				<th class="thcolor">내 용</th>
				<td class="tdcolor1">
					<textarea  name="content" rows="13" cols="42"></textarea>
				</td>
			</tr>
			<tr>
				<th class="thcolor">패스워드</th>
				<td class="tdcolor1">
					<input type="password" size="8" maxlength="15" name="passwd">
				</td>
			</tr>
			<tr>
				<th colspan="2" class="thcolor">
					<input type="submit" value="저장">
					<input type="reset" value="다시작성">
					<input type="button" value="목록보기" onclick="window.location='list.jsp'">
				</th>
			</tr>
		</table>
	</form>
<footer>
	<jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>