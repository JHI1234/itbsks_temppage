<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
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
          alert("이미지 파일을 업로드하세요!");    
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
    <h2>학과앨범 관리 > 사진 등록</h2><hr>
  <form  name="gallery_form" method="post" enctype="multipart/form-data" action="galleryinsertPro.jsp">
   	 <ul id="gallery_form">		
   		<li>
   			<span class="col1">&nbsp;&nbsp;제&nbsp;&nbsp;&nbsp;&nbsp;목</span>
   			<span class="col2"><input name="gtitle" type="text"></span>
   		</li>
		<li>
			<span class="col1">&nbsp;&nbsp;등 록 일</span>
			<span class="col2"><input name="greg_date" type="date"></span>
		</li>    	
   		<li>
		     <span class="col1">&nbsp;&nbsp;이 미 지</span>
		     <span class="col2"><input type="file" name="gimage"></span>
		</li>
    </ul>
   	<ul class="buttons">
		<li><button type="button" onclick="check_input()">등 록</button></li>
		<li><button type="button" onclick="location.href='gallerylist.jsp'">목 록</button></li>
	</ul>
  </form>
  </div>
</section>
</body>
</html>
<%} %>