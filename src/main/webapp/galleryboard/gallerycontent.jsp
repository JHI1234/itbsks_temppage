<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="galleryboard.GalleryDAO" %>
<%@ page import="galleryboard.GalleryVO" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
int gnum = Integer.parseInt(request.getParameter("gnum"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	
	GalleryDAO bdao = GalleryDAO.getInstance();
	GalleryVO article = bdao.getArticle(gnum);
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학과 앨범 | 학과 게시판</title>
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/gallery.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" href="../images/logo.png" />
</head>
<body>
<header>
	<jsp:include page="../module/top-sub.jsp" flush="false"/>
	<jsp:include page="../module/header/board.jsp" flush="false"/>
</header>
<section>
  <div class="main">
  	<article class="at_content">  
     	<div class="view_context">
			<div class="view_info">
				<h2><%=article.getGtitle()%></h2>
				<br>
				<ul class="info_list">          
            		<li><span><strong>등록일</strong></span><%=sdf.format(article.getGreg_date())%></li>
                </ul>
                <hr>
				<div class="view_img">
					<img class="img_content" src="../images/galleryimg/<%=article.getGimage()%>"/>												
				</div>
				<br><hr><br>
				<a href="#"><span id="btn" onclick="document.location.href='gallery.jsp?pageNum=<%=pageNum%>'">목 록</span></a>
			</div>
		</div>
  	</article>
  </div>
</section>
<footer>
	<jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>