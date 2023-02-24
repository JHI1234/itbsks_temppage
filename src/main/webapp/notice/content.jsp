<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="notice.NoticeDAO" %>
<%@ page import="notice.NoticeVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");	
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
	NoticeDAO nbao = NoticeDAO.getInstance();
	NoticeVO article = nbao.getArticle(num);
	
%>

<html>
<head>
<title>공지사항</title>
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
  <h2>공지사항</h2>
  <div id="board_box">
    <div id="content-box">
    <ul id="view_content">
		<li>
			<span class="col1"><b>제 목 :</b> <%=article.getSubject()%> </span>
			<span class="col2"> <%=article.getWriter()%> | <%=sdf2.format(article.getReg_date())%> </span>
		</li>
		<li>
			<%=article.getContent().replace("\r\n", "<br><br>")%>
		</li>		
    </ul>
    
    <ul class="buttons">
<%
	String id = (String) session.getAttribute("id");
	if (!(id==null) && id.equals(article.getWriter())) {
%>			
		<li><button onclick="location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">수정</button></li>
		<li><button onclick="del(<%=article.getNum()%>,<%=pageNum%>)">삭제</button></li>
		<li><button onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'">목록</button></li>
<%
	} else {
%>
		<li><button onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'">목록</button></li>
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