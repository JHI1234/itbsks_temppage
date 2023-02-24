<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="faqboard.FaqboardDAO" %>
<%@ page import="faqboard.FaqboardVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");	
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
	FaqboardDAO fabao = FaqboardDAO.getInstance();
	FaqboardVO article = fabao.getArticle(num);
	
%>

<html>
<head>
<title>입시 Q&A | 학과 게시판</title>
<link href="../css/board.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" href="../images/logo.png" />
</head>
<body>
<header>
  <jsp:include page="../module/top-sub.jsp" flush="false"/>
  <jsp:include page="../module/header/board.jsp" flush="false"/>
</header>
<section class="board-top">
  <h2>FAQ</h2>
  <div id="board_box">
  <div id="content-box">
    <ul id="view_content">
		<li>
			<span class="col1"><b>제 목 :</b> <%=article.getSubject()%> </span>
			<span class="col2"> <%=article.getWriter()%> | <%=sdf.format(article.getReg_date())%> </span>
		</li>
		<li id="content-space">
			<%=article.getContent().replace("\r\n", "<br>")%>
		</li>		
    </ul>
    
    <ul class="buttons">
		<li><button onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">목록</button></li>
	</ul>

  </div>
  </div>
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>      
</body>
</html>