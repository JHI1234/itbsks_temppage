<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="freeboard.FreeboardDAO" %>
<%@ page import="freeboard.FreeboardVO" %>
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
</script>
</head>
<body>

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
	
</body>
</html>