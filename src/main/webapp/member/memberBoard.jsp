<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="freeboard.FreeboardDAO" %>
<%@ page import="freeboard.FreeboardVO" %>
<%@ page import="qnaboard.QnaboardDAO" %>
<%@ page import="qnaboard.QnaboardVO" %>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="reply.ReplyVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	String id = (String) session.getAttribute("id");

	int count = 0;	//총 게시글 수
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); //SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
 	//----------------------------------- 학과 소식
	List<FreeboardVO> alist= null;
	FreeboardDAO fdao = FreeboardDAO.getInstance();
	count = fdao.getMemberArticleCount(id);
	
	
	//----------------------------------- 학과 소식 페이지 처리
	int pageSize = 5;	// 한 페이지에 표시할 게시물의 개수
	int number = 0;	// 현재 페이지의 시작 번호
 	String pageNum = null;	// 현재 페이지 번호
 	
 	pageNum = request.getParameter("pageNum");	
 	if(pageNum == null){
 		pageNum = "1";
 	}
 	
 	int currentPage = Integer.parseInt(pageNum);		// 1				// 2
 	int startRow = (currentPage - 1) * pageSize + 1;	// (1-1)*10+1=1		// (2-1)*10 +1=11
 	int endRow = currentPage * pageSize;				// 1*10 = 10		// 2*10= 20
 	
 	// 현재 페이지의 시작 번호
 	number = count - (currentPage - 1) * pageSize;		// 15-(1-1)*10 = 15 
 	
	//-----------------------------------
	
	// 게시글 수가 0이 아닐 때 - 게시글이 존재할 때
	if(count > 0){
		alist = fdao.getMemberArticles(id, startRow, pageSize);
	}
 	
 	//----------------------------------- 입시 Q&A 
	List<QnaboardVO> qlist= null;
	QnaboardDAO qdao = QnaboardDAO.getInstance();
	int qcount = qdao.getMemberArticleCount(id);
	
	int qreplycount = 0;	//총 댓글 수
	ReplyDAO rdao = ReplyDAO.getInstance();
	
	//----------------------------------- 입시 Q&A 페이지 처리
	int qpageSize = 5;	// 한 페이지에 표시할 게시물의 개수
	int qnumber = 0;	// 현재 페이지의 시작 번호
 	String qpageNum = null;	// 현재 페이지 번호
 	
 	qpageNum = request.getParameter("qpageNum");	
 	if(qpageNum == null){
 		qpageNum = "1";
 	}
 	
 	int qcurrentPage = Integer.parseInt(qpageNum);		// 1				// 2
 	int qstartRow = (qcurrentPage - 1) * qpageSize + 1;	// (1-1)*10+1=1		// (2-1)*10 +1=11
 	int qendRow = qcurrentPage * qpageSize;				// 1*10 = 10		// 2*10= 20
 	
	
 	// 현재 페이지의 시작 번호
 	qnumber = qcount - (qcurrentPage - 1) * qpageSize;		// 15-(1-1)*10 = 15 
 	
	//-----------------------------------
	
	// 게시글 수가 0이 아닐 때 - 게시글이 존재할 때
	if(qcount > 0){
		qlist = qdao.getMemberArticles(id, qstartRow, qpageSize);
	}
 	
	//----------------------------------- 작성 댓글 페이지 처리
		//페이지처리
	int rcount = 0; //총 댓글수		

	List<ReplyVO> rlist = null;
	ReplyDAO rDAO = ReplyDAO.getInstance();
	rcount = rDAO.getMemberArticleCount(id);
	
	int rpageSize = 5;
	int rnumber = 0; //현재 페이지의 시작 번호
	String rpageNum = null;

	rpageNum = request.getParameter("rpageNum");
	if(rpageNum == null) {
		rpageNum = "1";
	}
	
	int rcurrentPage = Integer.parseInt(rpageNum);    // 1			/2 
	int rstartRow = (rcurrentPage - 1) * rpageSize + 1;//(1-1)*10+1=1	/(2-1)*10+1=11
	int rendRow = rcurrentPage * rpageSize;			//1*10=10		/(2*10)=20
	//-----------------

	if (rcount > 0) {
		rlist = rDAO.getMemberArticles(id, rstartRow, rpageSize);
	}	
	
	rnumber = rcount - (rcurrentPage - 1) * rpageSize; //14-(1-1)*10=14 / 14-(2-1)*10=4
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 게시글 및 댓글</title>
<link href="../css/admin.css" rel="stylesheet" type="text/css">

<script>
function check(num) {
	  var ret = confirm("삭제하시겠습니까??");
	  if(ret == true) { 
		  document.location.href="freeboarddelete.jsp?num=" + num + "&pageNum=<%=currentPage%>";
    } else {
  	  return;
    }      
 }

  function qcheck(num) {
	  var ret = confirm("삭제하시겠습니까??");
	  if(ret == true) { 
		  document.location.href="qnaboarddelete.jsp?qnum=" + num + "&qpageNum=<%=currentPage%>";
      } else {
    	  return;
      }      
   }
  function rcheck(num) {
	  var ret = confirm("삭제하시겠습니까??");
	  if(ret == true) { 
		  document.location.href="replydelete.jsp?rnum=" + num + "&rpageNum=<%=currentPage%>";
      } else {
    	  return;
      }      
   }
</script>
</head>
<body>
<header>
  <jsp:include page="../module/top-sub.jsp" flush="false"/>
  <jsp:include page="../module/header/info.jsp" flush="false"/>
</header>
<section>
  <div id="board_box">
    <h2>학과 소식 > 게시글 관리</h2><hr>
  <ul id="board_list">
	<li>
		<span class="col1"><b>번호</b></span>
		<span class="col2"><b>제 목</b></span>
		<span class="col3"><b>글쓴이</b></span>
		<span class="col4"><b>등록일</b></span>
		<span class="col5"><b>조회수</b></span>
		<span class="col6"><b>삭제</b></span>
	</li>

<%
for(int i=0; i<alist.size(); i++) {
  		FreeboardVO article = alist.get(i);
%> 
	<li>
		<span class="col1"><%=number--%></span>
		<span class="col2 t-left"><%=article.getSubject()%></span>
		<span class="col3"><%=article.getWriter()%></span>
		<span class="col4"><%=sdf.format(article.getReg_date())%></span>
		<span class="col5"><%=article.getReadcount()%></span>
		<span class="col6"><button type="button" onclick="check(<%=article.getNum()%>)">삭제</button></span>
	</li>
<% 	} %>  
  </ul>	
  <br>
  <div class="page">
<%
	if(count > 0) {
		int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1); // 14/10+1=2
		int startPage = 1;
		if(currentPage%5 != 0) {
			startPage = (int)(currentPage/5) * 5 + 1; // (14/10)*10+1=11 / (2/10)*10+1=1
		} else {
			startPage = ((int)(currentPage/5)-1) * 5 + 1; // (10/10-1)*10+1=1 / (20/10-1)*10+1=11
		}
		
		int pageBlock = 5;
		int endPage = startPage + pageBlock - 1; // 1+10-1=10 / 11+10-1=20
		if(endPage > pageCount) {
			endPage = pageCount;
		}
%>
		<div class="pagebutton">
		<span>
<%
		if(startPage > 5 ) { %>
			<a class="pageNumBtn" href="memberBoard.jsp?pageNum=<%=startPage-5%>">이전</a>
<%		}
		for(int i = startPage; i<=endPage; i++){
			if(currentPage == i){
		%>
				<a class="pageNumBtn current" href="memberBoard.jsp?pageNum=<%=i%>"><%= i %></a>
		<%
			}else{
		%>
				<a class="pageNumBtn" href="memberBoard.jsp?pageNum=<%=i%>"><%= i %></a>
		<%
			}
		}
		if(endPage < pageCount ) { %>
			<a class="pageNumBtn" href="memberBoard.jsp?pageNum=<%=startPage+5%>">다음</a>
<%		}
	}
%>
	</span>
	</div>
  </div>
 
 </div>
</section>
	
<section>
  <div id="board_box">
    <h2>입시 Q&A > 게시글 관리</h2><hr>
  <ul id="board_list">
	<li>
		<span class="col1"><b>번호</b></span>
		<span class="col2"><b>제 목</b></span>
		<span class="col3"><b>글쓴이</b></span>
		<span class="col4"><b>등록일</b></span>
		<span class="col5"><b>조회수</b></span>
		<span class="col6"><b>삭제</b></span>
	</li>

<%
if(qcount == 0){	
%>

	<div class="text-center roomy-60"><h5>게시판에 등록된 글이 없습니다.</h5></div>

<%
}else{ //게시글 개수가 0이 아닐 때
for(int i=0; i<qlist.size(); i++) {
		QnaboardVO article = qlist.get(i);
  		qreplycount = rdao.getArticleCount(article.getNum());
%> 
	<li>
		<span class="col1"><%=qnumber--%></span>
		<span class="col2 t-left"><%=article.getSubject()%>
			<span class="replycount">
<%			if(qreplycount > 0) { %>
				 [<%=qreplycount %>]
<% 			} %>
			</span>
		</span>
		<span class="col3"><%=article.getWriter()%></span>
		<span class="col4"><%=sdf.format(article.getReg_date())%></span>
		<span class="col5"><%=article.getReadcount()%></span>
		<span class="col6"><button type="button" onclick="qcheck(<%=article.getNum()%>)">삭제</button></span>
	</li>
<%
		}

	}
%>
  </ul>	
  <br>
  <div class="page">
<%
	if(qcount > 0) {
		int qpageCount = qcount / qpageSize + (qcount%qpageSize == 0 ? 0 : 1); // 14/10+1=2
		int qstartPage = 1;
		if(qcurrentPage%5 != 0) {
			qstartPage = (int)(qcurrentPage/5) * 10 + 1; // (14/10)*10+1=11 / (2/10)*10+1=1
		} else {
			qstartPage = ((int)(qcurrentPage/5)-1) * 10 + 1; // (10/10-1)*10+1=1 / (20/10-1)*10+1=11
		}
		
		int qpageBlock = 5;
		int qendPage = qstartPage + qpageBlock - 1; // 1+10-1=10 / 11+10-1=20
		if(qendPage > qpageCount) {
			qendPage = qpageCount;
		}
%>
		<div class="pagebutton">
		<span>
<%
		if(qstartPage > 5 ) { %>
			<a class="pageNumBtn" href="memberBoard.jsp?qpageNum=<%=qstartPage-5%>">이전</a>
<%		}
		for(int i = qstartPage; i<=qendPage; i++){
			if(qcurrentPage == i){
		%>
				<a class="pageNumBtn current" href="memberBoard.jsp?qpageNum=<%=i%>"><%= i %></a>
		<%
			}else{
		%>
				<a class="pageNumBtn" href="memberBoard.jsp?qpageNum=<%=i%>"><%= i %></a>
		<%
			}
		}
		if(qendPage < qpageCount ) { %>
			<a class="pageNumBtn" href="memberBoard.jsp?qpageNum=<%=qstartPage+5%>">다음</a>
<%		}
	}
%>	
	</span>
	</div>
  </div>
 
 </div>
</section>

<section>
  <div id="board_box">
    <h2>입시 Q&A > 댓글 관리</h2><hr>
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
for(int i=0; i<rlist.size(); i++) {
		ReplyVO reply = rlist.get(i);
%> 
	<li>
		<span class="col1"><%=rnumber--%></span>
		<span class="col2 t-left"><%=reply.getReply()%></span>
		<span class="col3"><%=reply.getRwriter()%></span>
		<span class="col4"><%=sdf.format(reply.getReg_date())%></span>
		<span class="col5"><%=reply.getRef()%></span>
		<span class="col6"><button type="button" onclick="rcheck(<%=reply.getRnum()%>)">삭제</button></span>
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
		int rpageCount = rcount / rpageSize + (rcount%rpageSize == 0 ? 0 : 1); // 14/10+1=2
		int rstartPage = 1;
		if(rcurrentPage%10 != 0) {
			rstartPage = (int)(rcurrentPage/10) * 10 + 1; // (14/10)*10+1=11 / (2/10)*10+1=1
		} else {
			rstartPage = ((int)(rcurrentPage/10)-1) * 10 + 1; // (10/10-1)*10+1=1 / (20/10-1)*10+1=11
		}
		
		int rpageBlock = 10;
		int rendPage = rstartPage + rpageBlock - 1; // 1+10-1=10 / 11+10-1=20
		if(rendPage > rpageCount) {
			rendPage = rpageCount;
		}
%>
		<div class="pagebutton">
		<span>
<%
		if(rstartPage > 10 ) { %>
			<a class="pageNumBtn" href="memberBoard.jsp?rpageNum=<%=rstartPage-10%>">이전</a>
<%		}
		for(int i = rstartPage; i<=rendPage; i++){
			if(rcurrentPage == i){
		%>
				<a class="pageNumBtn current" href="memberBoard.jsp?rpageNum=<%=i%>"><%= i %></a>
		<%
			}else{
		%>
				<a class="pageNumBtn" href="memberBoard.jsp?rpageNum=<%=i%>"><%= i %></a>
		<%
			}
		}
		if(rendPage < rpageCount ) { %>
			<a class="pageNumBtn" href="memberBoard.jsp?rpageNum=<%=rstartPage+10%>">다음</a>
<%		}
	}
%>
	</span>
	</div>
  </div>
 
 </div>
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>