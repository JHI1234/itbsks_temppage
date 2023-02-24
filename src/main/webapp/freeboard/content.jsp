<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="freeboard.FreeboardDAO" %>
<%@ page import="freeboard.FreeboardVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");	
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
	FreeboardDAO nbao = FreeboardDAO.getInstance();
	FreeboardVO article = nbao.getArticle(num);
	
%>

<html>
<head>
<title>학과 소식 | 학과 게시판</title>
<link href="../css/board.css" rel="stylesheet" type="text/css">
<script>
  function check_input() {
      if (!document.reply_form.reply.value)
      {
          alert("댓글을 입력하세요!");    
          document.reply_form.reply.focus();
          return;
      }
      document.reply_form.submit();
   }
  
   function del(num, pageNum) {	  
	  if (confirm("삭제하시겠습니까?")) {
		  location.href="deletePro.jsp?num=" + num + "&pageNum=" + pageNum;
	  } else {
		  location.href="list.jsp?pageNum=" + pageNum;
	  }
   }
</script>
</head>
<body>
<header>
  <jsp:include page="../module/top-sub.jsp" flush="false"/>
  <jsp:include page="../module/header/board.jsp" flush="false"/>
</header>
<section class="board-top">
  <h2>학과 소식</h2>
  <div id="board_box">
    <div id="content-box">
    <ul id="view_content">
		<li>
			<span class="col1"><b>제 목 :</b> <%=article.getSubject()%> </span>
			<span class="col2"> <%=article.getWriter()%> | <%=sdf.format(article.getReg_date())%> </span>
		</li>
		<li id="content-space">
		<% if(article.getThumbnail() == null || article.getThumbnail() == "nothing.jpg"){ %>
			<%=article.getContent().replace("\r\n", "<br>")%>
		<%}else{ %>
			<img id="content-img" src="../images/freeboardimg/<%=article.getThumbnail()%>" /><br>		
			<%=article.getContent().replace("\r\n", "<br>")%>
		<%} %>
		</li>		
    </ul>
    
    <ul class="buttons center">
<%
	String id = (String) session.getAttribute("id");
	if (!(id==null) && id.equals(article.getWriter())) {
%>			
		<li><button onclick="location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>&exist_thumbnail=<%=article.getThumbnail()%>'">수정</button></li>
		<li><button onclick="del(<%=article.getNum()%>,<%=pageNum%>)">삭제</button></li>
		<li><button onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">목록</button></li>
<%
	} else {
%>
		<li><button onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">목록</button></li>
<%
	}
%>			
	</ul>
  </div>
  </div>
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>      
</body>
</html>