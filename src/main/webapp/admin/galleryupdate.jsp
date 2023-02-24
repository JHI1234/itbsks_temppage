<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="galleryboard.GalleryDAO" %>
<%@ page import="galleryboard.GalleryVO" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%

	int gnum = Integer.parseInt(request.getParameter("gnum"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	//input의 date 타입은 'yyyy-MM-dd' 유형만 value 지정이 가능함.
	
	GalleryDAO gdao = GalleryDAO.getInstance();
	GalleryVO article = gdao.getArticle(gnum);
	
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 소개</title>
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/admin.css" rel="stylesheet" type="text/css">
<script>
  function check_input() {
      if (!document.gallery_form.gtitle.value)
      {
          alert("제목을 입력하세요!");    
          document.gallery_form.gtitle.focus();
          return;
      }
      if (!document.gallery_form.greg_date.value)
      {
          alert("등록일을 입력하세요!");    
          document.gallery_form.greg_date.focus();
          return;
      }
      if (!document.gallery_form.gimage.value)
      {
          alert("이미지를 업로드하세요!");    
          document.gallery_form.gimage.focus();
          return;
      }

      document.gallery_form.submit();
   }
</script>
</head>
<body>
<header>
  <jsp:include page="../module/top-manager.jsp" flush="false"/>
  <jsp:include page="../module/header/manager.jsp" flush="false"/>
</header>
<section>
  <div id="galleryform_box">
    <h2>학과 앨범 관리 > 사진 수정</h2><hr>
  <form  name="gallery_form" method="post" enctype="multipart/form-data" action="galleryupdatePro.jsp">
  	<input type="hidden" name="gnum" value="<%=gnum%>">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
   	 <ul id="gallery_form">		
   		<li>
   			<span class="col1">&nbsp;&nbsp;제&nbsp;&nbsp;&nbsp;목</span>
   			<span class="col2"><input name="gtitle" type="text" value="<%=article.getGtitle()%>"></span>
   		</li>
		<li>
			<span class="col1">&nbsp;&nbsp;등 록 일</span>
			<span class="col2"><input name="greg_date" type="date"  value="<%=sdf.format(article.getGreg_date())%>"></span>
		</li>
   		<li>
		     <span class="col1">&nbsp;&nbsp;이 미 지</span>
		     <span class="col2"><input type="file" name="gimage"><!-- input의 file은 value 지정이 안됨, 보안상의 이유로.. --></span>		     	
		</li>
    </ul>
   	<ul class="buttons">
		<li><button type="button" onclick="check_input()">수 정</button></li>
		<li><button type="button" onclick="location.href='gallerylist.jsp?pageNum=<%=pageNum%>'">목 록</button></li>
	</ul>
  </form>
  </div>
</section>
</body>
</html>
<%} %>