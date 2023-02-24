<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="qnaboard.QnaboardDAO" %>
<%@ page import="qnaboard.QnaboardVO" %>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="reply.ReplyVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%	// 관리자 페이지에만 포함됨
String managerId = (String) session.getAttribute("managerId");
if(managerId==null || managerId.equals("")) {
	response.sendRedirect("main.jsp");	
} else {

	//페이지처리
	int pageSize = 20;
	String pageNum = null;

	pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);    // 1			/2 
	int startRow = (currentPage - 1) * pageSize + 1;//(1-1)*10+1=1	/(2-1)*10+1=11
	int endRow = currentPage * pageSize;			//1*10=10		/(2*10)=20
	//-----------------
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	

	List<ReplyVO> replyList = null;
	int rcount = 0; //총 댓글수	
	int number = 0; //현재 페이지의 시작 번호
	
	ReplyDAO rDAO = ReplyDAO.getInstance();
	rcount = rDAO.getArticleCount();
	
	if (rcount > 0) {
		replyList = rDAO.getArticles(startRow, pageSize);
	}	
	
	number = rcount - (currentPage - 1) * pageSize; //14-(1-1)*10=14 / 14-(2-1)*10=4

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 관리 | 관리자 페이지</title>
<link href="../css/admin.css" rel="stylesheet" type="text/css">
<script>
  function check(num) {
	  var ret = confirm("삭제하시겠습니까??");
	  if(ret == true) { 
		  document.location.href="replydelete.jsp?num=" + num + "&pageNum=<%=currentPage%>";
      } else {
    	  return;
      }      
   }
</script>
</head>
<body>
<header>
  <jsp:include page="../module/top-manager.jsp" flush="false"/>
  <jsp:include page="../module/header/manager.jsp" flush="false"/>
</header>
	<jsp:include page="../board/adminqna.jsp" flush="false"/>
<section>
  <div id="board_box">
    <h2>입시 Q&A 관리 > 댓글 관리</h2><hr>
  <ul id="board_list">
	<li>
		<span class="col1"><b>번호</b></span>
		<span class="col2"><b>댓글 내용</b></span>
		<span class="col3"><b>작성자</b></span>
		<span class="col4"><b>댓글 등록일</b></span>
		<span class="col5"><b>게시글 번호</b></span>
		<span class="col6"><b>삭제</b></span>
	</li>

<%
if(rcount == 0){	
%>

	<div class="text-center roomy-60"><h5>게시판에 등록된 글이 없습니다.</h5></div>

<%
}else{ //게시글 개수가 0이 아닐 때
for(int i=0; i<replyList.size(); i++) {
		ReplyVO reply = replyList.get(i);
%> 
	<li>
		<span class="col1"><%=number--%></span>
		<span class="col2 t-left"><%=reply.getReply()%></span>
		<span class="col3"><%=reply.getRwriter()%></span>
		<span class="col4"><%=sdf.format(reply.getReg_date())%></span>
		<span class="col5"><%=reply.getRef()%></span>
		<span class="col6"><button type="button" onclick="check(<%=reply.getRnum()%>)">삭제</button></span>
	</li>
<%
		}

	}
%>
  </ul>	
  <br>
  <div class="page">
<%
	if(rcount > 0) {
		int pageCount = rcount / pageSize + (rcount%pageSize == 0 ? 0 : 1); // 14/10+1=2
		int startPage = 1;
		if(currentPage%10 != 0) {
			startPage = (int)(currentPage/10) * 10 + 1; // (14/10)*10+1=11 / (2/10)*10+1=1
		} else {
			startPage = ((int)(currentPage/10)-1) * 10 + 1; // (10/10-1)*10+1=1 / (20/10-1)*10+1=11
		}
		
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1; // 1+10-1=10 / 11+10-1=20
		if(endPage > pageCount) {
			endPage = pageCount;
		}
%>
		<div class="pagebutton">
		<span>
<%
		if(startPage > 10 ) { %>
			<a class="pageNumBtn" href="replylist.jsp?pageNum=<%=startPage-10%>">이전</a>
<%		}
		
		for(int i=startPage; i<=endPage; i++) { %>
			<a class="pageNumBtn current" href="replylist.jsp?pageNum=<%=i%>"><%=i%></a>
<%		}
		
		if(endPage < pageCount ) { %>
			<a class="pageNumBtn" href="replylist.jsp?pageNum=<%=startPage+10%>">다음</a>
<%		}
	}
%>
	</span>
	</div>
  </div>
 
 </div>
</section>
</body>
</html>
<%} %>