<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="galleryboard.GalleryDAO" %>
<%@ page import="galleryboard.GalleryVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
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
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	

	List<GalleryVO> aList = null;
	int count = 0; //총 글수
	int number = 0; //현재 페이지의 시작 번호

	GalleryDAO gdao = GalleryDAO.getInstance();
	count = gdao.getArticleCount();
	
	if (count > 0) {
		aList = gdao.getArticles(startRow, pageSize);
	}
	
	number = count - (currentPage - 1) * pageSize; //14-(1-1)*10=14 / 14-(2-1)*10=4
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학과앨범 관리 | 관리자 페이지</title>
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/admin.css" rel="stylesheet" type="text/css">
<script>
  function check(gnum) {
	  var ret = confirm("삭제하시겠습니까??");
	  if(ret == true) { 
		  document.location.href="gallerydelete.jsp?gnum=" + gnum + "&pageNum=<%=currentPage%>";
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
  <div id="gallery_box">
    <h2>학과앨범 관리</h2><hr>
  <ul id="gallery_list">
	<li>		
		<span class="col1"><b>번호</b></span>
		<span class="col2"><b>제목</b></span>
		<span class="col3"><b>등록일</b></span>
		<span class="col4"><b>이미지</b></span>
		<span class="col5"><b>수정</b></span>
		<span class="col6"><b>삭제</b></span>
	</li>

<%
if(count == 0){	
%>

	<div class="text-center roomy-60"><h5>게시판에 등록된 글이 없습니다.</h5></div>

<%
}else{ //게시글 개수가 0이 아닐 때
for(int i=0; i<aList.size(); i++) {
	GalleryVO article = aList.get(i);
%> 
	<li>
		<span class="col1"><%=number--%></span>
		<span class="col2 t-left"><%=article.getGtitle()%></span>
		<span class="col3"><%=sdf.format(article.getGreg_date())%></span>
		<span class="col4"><a href="filedownload.jsp?gimage=<%=article.getGimage()%>"><%=article.getGimage()%></a></span>
		<span class="col5"><button type="button" onclick="location.href='galleryupdate.jsp?gnum=<%=article.getGnum()%>&pageNum=<%=currentPage%>'">수정</button></span>
		<span class="col6"><button type="button" onclick="check(<%=article.getGnum()%>)">삭제</button></span>
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
			<a class="pageNumBtn"  href="gallerylist.jsp?pageNum=<%=startPage-10%>">이전</a>
<%		}
		
		for(int i=startPage; i<=endPage; i++) { %>
			<a class="pageNumBtn current"  href="gallerylist.jsp?pageNum=<%=i%>"><%=i%></a>
<%		}
		
		if(endPage < pageCount ) { %>
			<a class="pageNumBtn"  href="gallerylist.jsp?pageNum=<%=startPage+10%>">다음</a>
<%		}
	}
%>
	</span>
	</div>
  </div>

  <ul class="buttons">
  	<li>
		<button onclick="location.href='galleryinsert.jsp'">사진 등록</button>
	</li>
  </ul>
 
 </div>
</section>
</body>
</html>
<%} %>