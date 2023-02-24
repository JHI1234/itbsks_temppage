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
<link rel="icon" type="image/png" href="../images/logo.png" />  
<script>
  function check_input() {
      if (!document.notice_form.subject.value)
      {
          alert("제목을 입력하세요!");    
          document.notice_form.subject.focus();
          return;
      }
      if (!document.notice_form.writer.value)
      {
          alert("작성자를 입력하세요!");    
          document.notice_form.writer.focus();
          return;
      }
       if (!document.notice_form.content.value)
      {
          alert("내용을 입력하세요!");    
          document.notice_form.content.focus();
          return;
      }

      document.notice_form.submit();
   }
</script>
</head>
<body>
<header>
  <jsp:include page="../module/top-manager.jsp" flush="false"/>
  <jsp:include page="../module/header/manager.jsp" flush="false"/>
</header>
<section>
  <div id="noticeform_box">
    <h2>공지사항 관리 > 공지 등록</h2><hr>
  <form  name="notice_form" method="post" enctype="multipart/form-data" action="noticeinsertPro.jsp">
   	 <ul id="notice_form">		
   		<li>
   			<span class="col1">&nbsp;&nbsp;제&nbsp;&nbsp;&nbsp;&nbsp;목</span>
   			<span class="col2"><input name="subject" type="text"></span>
   		</li>
		<li>
			<span class="col1">&nbsp;&nbsp;작 성 자</span>
			<span class="col2"><input name="writer" type="text" value="관리자"></span>
		</li>
		<li>
			<span class="col1">&nbsp;&nbsp;등 록 일</span>
			<span class="col2"><input name="reg_date" type="date"></span>
		</li>  
		<li id="text_area">	
   			<span class="col1">&nbsp;&nbsp;내&nbsp;&nbsp;&nbsp;용</span>
   			<span class="col2">
   				<textarea name="content"></textarea>
   			</span>
   		</li>
   		<li>
		     <span class="col1">&nbsp;&nbsp;이 미 지</span>
		     <span class="col2"><input type="file" name="thumbnail"></span>
		</li>
    </ul>
   	<ul class="buttons">
		<li><button type="button" onclick="check_input()">등 록</button></li>
		<li><button type="button" onclick="location.href='noticelist.jsp'">목 록</button></li>
	</ul>
  </form>
  </div>
</section>
</body>
</html>
<%} %>