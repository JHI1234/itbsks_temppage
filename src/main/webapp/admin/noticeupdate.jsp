<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="notice.NoticeDAO" %>
<%@ page import="notice.NoticeVO" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%

	int nnum = Integer.parseInt(request.getParameter("nnum"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	//input의 date 타입은 'yyyy-MM-dd' 유형만 value 지정이 가능함.
	
	NoticeDAO ndao = NoticeDAO.getInstance();
	NoticeVO article = ndao.getArticle(nnum);
	
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
    <h2>학과 앨범 관리 > 사진 수정</h2><hr>
  <form  name="notice_form" method="post" enctype="multipart/form-data" action="galleryupdatePro.jsp">
  	<input type="hidden" name="nnum" value="<%=nnum%>">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
   	 <ul id="notice_form">		
   		<li>
   			<span class="col1">&nbsp;&nbsp;제&nbsp;&nbsp;&nbsp;&nbsp;목</span>
   			<span class="col2"><input name="subject" type="text" value="<%=article.getSubject()%>"></span>
   		</li>
		<li>
			<span class="col1">&nbsp;&nbsp;작 성 자</span>
			<span class="col2"><input name="writer" type="text" value="관리자"></span>
		</li>
		<li>
			<span class="col1">&nbsp;&nbsp;등 록 일</span>
			<span class="col2"><input name="reg_date" type="date" value="<%=sdf.format(article.getReg_date())%>"></span>
		</li>  
		<li id="text_area">	
   			<span class="col1">&nbsp;&nbsp;내&nbsp;&nbsp;&nbsp;용</span>
   			<span class="col2">
   				<textarea name="content"><%=article.getContent()%></textarea>
   			</span>
   		</li>
   		<li>
		     <span class="col1">&nbsp;&nbsp;이 미 지</span>
		     <span class="col2"><input type="file" name="thumbnail"></span>
		</li>
    </ul>
   	<ul class="buttons">
		<li><button type="button" onclick="check_input()">수 정</button></li>
		<li><button type="button" onclick="location.href='noticelist.jsp?pageNum=<%=pageNum%>'">목 록</button></li>
	</ul>
  </form>
  </div>
</section>
</body>
</html>
<%} %>