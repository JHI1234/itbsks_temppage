<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>마이페이지 | 부산경상대학교 컴퓨터정보·메타버스게임과 학과ㄴ</title>
<link href="../css/member.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" href="../images/logo.png" />  
</head>
<body>
<header>
  <jsp:include page="../module/top-sub.jsp" flush="false"/>
  <jsp:include page="../module/header/memberpage.jsp" flush="false"/>
</header>
<section>
	<div id="main_content">
		<div class="mypage">
			<a class="m_btn" href="memberInfo.jsp">회원정보 관리</a>
			<a class="m_btn" href="memberBoard.jsp">게시글 및 댓글 관리</a>						
		</div>	
	</div> <!-- main_content -->
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>