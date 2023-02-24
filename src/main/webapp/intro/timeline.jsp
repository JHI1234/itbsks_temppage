<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학과 연혁 | 학과 안내</title>
<link rel="icon" type="image/png" href="../images/logo.png" />
<link rel="stylesheet" href="../css/intro.css">
</head>
<body>
	<%@ include file="../module/top-sub.jsp" %> 
    <%@ include file="../module/header/intro.jsp"%>
    <%@ include file="../board/intro.jsp"%>
    <div class="intro_con">
    	<h2 class="sCont_title">학과 연혁</h2>	
	    <!-- time-line -->
		<div class="main-timeline">
		    <div class="timeline">
		        <div class="timeline-icon"></div>
		        <div class="timeline-content">
		            <span class="date">2022</span>
		            <h4 class="title">Metaverse</h4>
		            <p class="description">
		                가상, 초월을 의미하는 '메타'(meta)와 세계, 우주를 의미하는 '유니버스'(universe)를 합성한 신조어입니다. 이는 3차원에서 실제 생활과 법적으로 인정한 활동인 직업, 금융, 학습 등이 연결된 가상 세계를 뜻합니다. 가상현실, 증강현실의 상위 개념으로서 현실을 디지털 기반의 가상 세계로 확장해 가상 공간에서 모든 활동을 할 수 있게 만드는 시스템이라고 할 수 있습니다.
		            </p>
		        </div>
		    </div>
		    
		    <div class="timeline">
		        <div class="timeline-icon"></div>
		        <div class="timeline-content right">
		            <span class="date">2021</span>
		            <h4 class="title">Web Design</h4>
		            <p class="description">
		                웹디자인은 웹사이트에서 콘텐츠를 계획하고 배열하여 전 세계와 온라인으로 공유하고 액세스할 수 있도록 하는 기술을 뜻합니다. 미적 요소와 기능적 요소를 결합한 웹디자인은 웹사이트의 색상, 폰트 및 그래픽과 같은 외관을 결정하며 사이트 구조와 사용자 환경을 구성합니다.
		            </p>
		        </div>
		    </div>
		
		    <div class="timeline">
		        <div class="timeline-icon"></div>
		        <div class="timeline-content">
		            <span class="date">2020</span>
		            <h4 class="title">Web Development</h4>
		            <p class="description">
		                웹 프로그래밍은 웹 컨텐츠, 웹 클라이언트 및 서버 스크립팅 및 네트워크 보안을 포함하여 웹 개발과 관련된 쓰기, 마크 업 및 코딩을 말합니다. 웹 프로그래밍에 사용되는 가장 일반적인 언어는 XML, HTML, JavaScript, Perl 5 및 PHP입니다.
		            </p>
		        </div>
		    </div>
		
		    <div class="timeline">
		        <div class="timeline-icon"></div>
		        <div class="timeline-content right">
		            <span class="date">2019</span>
		            <h4 class="title">Responsive Design</h4>
		            <p class="description">
		                반응형웹 디자인(responsive web design, RWD)이란 하나의 웹사이트에서 PC, 스마트폰, 태블릿 PC 등 접속하는 디스플레이의 종류에 따라 화면의 크기가 자동으로 변하도록 만든 웹페이지 접근 기법을 말합니다.
		            </p>
		        </div>
		    </div>
		</div>
	</div>
	<%@ include file="../module/footer.jsp" %> 
</body>
</html>