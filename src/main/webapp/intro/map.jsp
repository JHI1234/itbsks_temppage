<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>위치 및 연락처 | 학과 안내</title>
<link rel="icon" type="image/png" href="../images/logo.png" />
<link rel="stylesheet" href="../css/intro.css">
</head>
<body>
	<%@ include file="../module/top-sub.jsp" %> 
    <%@ include file="../module/header/intro.jsp"%>
    <%@ include file="../board/intro.jsp"%>
    <div class="intro_con">
    	<h2 class="sCont_title">위치 및 연락처</h2>	
		<div class="map">
			<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13043.55388569973!2d129.0991948!3d35.1843322!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x2686b75d5ca07394!2z67aA7IKw6rK97IOB64yA7ZWZ6rWQ!5e0!3m2!1sko!2skr!4v1674054213164!5m2!1sko!2skr" style="border:0;" allowfullscreen="" loading="lazy" ></iframe>
		
			<div class="map_info">
				<dl>
					<dt>주소</dt>
					<dd>(47583) 부산 연제구 고분로 170 부산경상대학교 컴퓨터정보·메타버스게임과 (멀티미디어관 3층)</dd>
				</dl>
				<dl>
					<dt>전화번호</dt>
					<dd><a href="tel:051-850-1226">051-850-1226</a></dd>
				</dl>
				<dl>
					<dt>입학문의</dt>
					<dd>051-850-1004</dd>
				</dl>
			</div>
		</div>
	</div>
	<%@ include file="../module/footer.jsp" %> 
</body>
</html>