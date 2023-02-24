<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="notice.NoticeDAO" %>
<%@ page import="notice.NoticeVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%	// 관리자 페이지에만 포함됨
String managerId = (String) session.getAttribute("managerId");
if(managerId==null || managerId.equals("")) {
	response.sendRedirect("main.jsp");	
} else {

	//페이지처리
	int pageSize = 10;
	String pageNum = null;

	pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);    // 1			/2 
	int startRow = (currentPage - 1) * pageSize + 1;//(1-1)*10+1=1	/(2-1)*10+1=11
	int endRow = currentPage * pageSize;			//1*10=10		/(2*10)=20
	//-----------------
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	

	List<NoticeVO> aList = null;
	int count = 0; //총 글수
	int number = 0; //현재 페이지의 시작 번호

	NoticeDAO nDAO = NoticeDAO.getInstance();
	count = nDAO.getArticleCount();
	
	if (count > 0) {
		aList = nDAO.getArticles(startRow, pageSize);
	}
	
	number = count - (currentPage - 1) * pageSize; //14-(1-1)*10=14 / 14-(2-1)*10=4
	
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
		  document.location.href="noticedelete.jsp?num=" + num + "&pageNum=<%=currentPage%>";
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
<section>
  <div id="notice_box">
    <h2>공지사항 관리</h2><hr>
  <ul id="notice_list">
	<li>
		<span class="col1"><b>번호</b></span>
		<span class="col2"><b>제 목</b></span>
		<span class="col3"><b>등록일</b></span>
		<span class="col4"><b>이미지</b></span>
		<span class="col5"><b>조회수</b></span>
		<span class="col6"><b>수정</b></span>
		<span class="col7"><b>삭제</b></span>
	</li>
<%
if(count == 0){	
%>

	<div class="text-center roomy-60"><h5>게시판에 등록된 글이 없습니다.</h5></div>

<%
}else{ //게시글 개수가 0이 아닐 때
	for(int i=0; i<aList.size(); i++) {
		NoticeVO article = aList.get(i);
%> 
	<li>
		<span class="col1"><%=number--%></span>
		<span class="col2 t-left"><%=article.getSubject()%></span>
		<span class="col3"><%=sdf.format(article.getReg_date())%></span>
		<%if(article.getThumbnail() == null){ %>
		<span class="col4"><a class="nopointer">이미지 없음</a></span>
		<%}else{ %>
		<span class="col4"><a href="nfiledownload.jsp?thumbnail=<%=article.getThumbnail()%>"><%=article.getThumbnail()%></a></span>
		<%} %>
		<span class="col5"><%=article.getReadcount()%></span>
		<span class="col6"><button type="button" onclick="location.href='noticeupdate.jsp?nnum=<%=article.getNum()%>&pageNum=<%=currentPage%>'">수정</button></span>
		<span class="col7"><button type="button" onclick="check(<%=article.getNum()%>)">삭제</button></span>
	</li>
<%
		}

	}
%> 
  </ul>	
  <br>
  <div class="page">
<%
	if(count > 0) {
		int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1); // 14/10+1=2
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
			<a class="pageNumBtn" href="noticelist.jsp?pageNum=<%=startPage-10%>">이전</a>
<%		}
		
		for(int i=startPage; i<=endPage; i++) { %>
			<a class="pageNumBtn current" href="noticelist.jsp?pageNum=<%=i%>"><%=i%></a>
<%		}
		
		if(endPage < pageCount ) { %>
			<a class="pageNumBtn" href="noticelist.jsp?pageNum=<%=startPage+10%>">다음</a>
<%		}
	}
%>	
		</span>
		</div>
  </div>
  
   <ul class="buttons">
  	<li>
		<button onclick="location.href='noticeinsert.jsp'">공지 등록</button>
	</li>
   </ul>
  
 </div>
</section>
</body>
</html>
<%} %>