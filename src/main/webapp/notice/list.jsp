<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="notice.NoticeDAO" %>
<%@ page import="notice.NoticeVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
int count = 0;	//총 게시글 수
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); //SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	List<NoticeVO> alist= null;
	NoticeDAO bdao = NoticeDAO.getInstance();
	count = bdao.getArticleCount();
	
	
	//----------------------------------- 페이지 처리
	int pageSize = 10;	// 한 페이지에 표시할 게시물의 개수
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
	
	String sword = request.getParameter("sword");
	   if (sword==null || sword.equals("")) {
	      count = bdao.getArticleCount();   
	      if(count > 0) {		// 게시글 수가 0이 아닐 때 - 게시글이 존재할 때	
	         alist = bdao.getArticles(startRow, pageSize);
	      }
	   } else {
	      count = bdao.getArticleCount("%"+sword+"%");   
	      if(count > 0) {
	         alist = bdao.getArticles(startRow, pageSize, "%"+sword+"%");
	      }
	      else{
	    	  out.println("<script>alert('검색된 데이터가 없습니다!'); history.go(-1);</script>");
	      }
	   }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 | 학과 게시판</title>
<link href="../css/board.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" href="../images/logo.png" />  
<script>
function search_input() {
    if (!document.search_form.sword.value) {
        alert("검색어를 입력하세요");    
        document.search_form.sword.focus();
        return;
    }    
    document.search_form.submit();
}
</script>
</head>
<body>
<header>
  <jsp:include page="../module/top-sub.jsp" flush="false"/>
  <jsp:include page="../module/header/board.jsp" flush="false"/>
  <jsp:include page="../board/board.jsp" flush="false"/>
</header>
<section class="board-top">
  <h2>공지사항</h2>
  <div class="search_box">
	  <form name="search_form" method="get" action="list.jsp">
	    <input type="text" name="sword" placeholder="게시글 검색" />&nbsp;
	    <a href="#" class="searchbtn"><span onclick="search_input()">검색</span></a>
	  </form>
  </div>
  <div id="board_box">
  <ul id="board_list">
   <li class="b-title">
      <span class="col1">번호</span>
      <span class="col2">제 목</span>
      <span class="col3">작성자</span>
      <span class="col4">등록일</span>
      <span class="col5">조회</span>
   </li>

<%
if(count == 0){	
%>

	<div class="text-center roomy-60"><h5>게시판에 등록된 글이 없습니다.</h5></div>

<%
}else{ //게시글 개수가 0이 아닐 때

		for(int i=0;i<alist.size();i++){	// 반복문
			NoticeVO article = alist.get(i);	
%>
   	<li class="b-content">
      <span class="col1"><%=number--%></span>
      <span class="col2 board_title"><a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"><%=article.getSubject()%></a></span>
      <span class="col3"><%=article.getWriter()%></span>
      <span class="col4"><%=sdf.format(article.getReg_date())%></span>
      <span class="col5"><%=article.getReadcount()%></span>
   </li>
<%
		}

	}
%>
  </ul>   
  <br>
  <div class="page">
<%
//-----------------------------------페이지 번호 목록
	if(count > 0) {
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);	// 페이지 목록 수 구하기
		int startPage = 1;
		if(currentPage % 10 != 0){
			startPage = (int)(currentPage/10) * 10 + 1;
		}else{
			startPage = (int)(currentPage/10) - 1 * 10 + 1;
		}
		
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount){
			endPage = pageCount;
		}
%>
		<div class="pagebutton">
		<span>
<%
		if(startPage > 10){
%>
				<a class="pageNumBtn"  href="notice.jsp?pageNum=<%= startPage-pageBlock %>">이전</a>
<%	
		}
		for(int i = startPage; i<=endPage; i++){
			if(currentPage == i){
%>
				<a class="pageNumBtn current" href="notice.jsp?pageNum=<%=i%>"><%= i %></a>
<%
			}else{
%>
				<a class="pageNumBtn" href="notice.jsp?pageNum=<%=i%>"><%= i %></a>
<%
			}
		}
		if(endPage < pageCount){
%>
				<a class="pageNumBtn" href="notice.jsp?pageNum=<%= startPage+pageBlock %>">다음</a>
<%	
		}
	}
//-----------------------------------	
%>		</span>
		</div>
	</div>
	</div>  
	</section>
<footer>
	<jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>