<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학과 소식 | 부산경상대학교 컴퓨터정보·메타버스게임과</title>
<link rel="icon" type="image/png" href="../images/logo.png" />  
</head>
<body>
<header>
  <jsp:include page="../module/top-sub.jsp" flush="false"/>
  <jsp:include page="../module/header/board.jsp" flush="false"/>
</header>
	<jsp:include page="../board/board.jsp" flush="false"/>
	<jsp:include page="../freeboard/list.jsp" flush="false"/>
<Footer>
	<jsp:include page="../module/footer.jsp" flush="false"/>
</Footer>
</body>
</html>