<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="galleryboard.GalleryDAO" %>
<%@ page import="galleryboard.GalleryVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	
	int count = 0; //총글수	

	List<GalleryVO> alist = null;
	GalleryDAO gdao = GalleryDAO.getInstance();
	count = gdao.getArticleCount();
	
	//------------------ 페이지 처리
	int pageSize = 9;
	int number = 0; //현재 페이지의 시작 번호
	String pageNum = null;
	
	pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);   //1			 //2
	int startRow = (currentPage - 1)* pageSize + 1;//(1-1)*10+1=1, (2-1)*10+1=11 
	int endRow = currentPage * pageSize;		   //1*10=10,      2*20=20
	
	//number = count - (currentPage - 1) * pageSize; //12-(1-1)*10=12, 12-(2-1)*10=2
	//------------------
	
	String sword = request.getParameter("sword");
	   if (sword==null || sword.equals("")) {
	      count = gdao.getArticleCount();   
	      if(count > 0) {		// 게시글 수가 0이 아닐 때 - 게시글이 존재할 때	
	         alist = gdao.getArticles(startRow, pageSize);

	      }
	   } else {
	      count = gdao.getArticleCount("%"+sword+"%");   
	      if(count > 0) {
	         alist = gdao.getArticles(startRow, pageSize, "%"+sword+"%");
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
<title>학과 앨범 | 학과 게시판</title>
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/gallery.css" rel="stylesheet" type="text/css">
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
<section class="board-top">

    <div id="board_box">
      <h2 id="gallery">학과 앨범</h2>
      <div class="search_box">
		  <form name="search_form" method="get" action="list.jsp">
		    <input type="text" name="sword" placeholder="제목 입력" />&nbsp;
		    <a href="#" class="searchbtn"><span onclick="search_input()">검색</span></a>
		  </form>
  	  </div>
      <hr>
      <div class="container">
<%
for(int i=0; i<alist.size(); i++) {
		GalleryVO article = alist.get(i);
%>  
	<article>
		<a class="content" href="gallerycontent.jsp?gnum=<%=article.getGnum()%>&pageNum=<%=currentPage%>">
			<div class="photo"
	        	style="background-image: url('../images/galleryimg/<%=article.getGimage()%>');">
	        </div>
			<div class="text">
				<h6><%=sdf.format(article.getGreg_date())%></h6>
				<h5><%=article.getGtitle()%></h5>
			</div>
		</a>
    </article>

<% 	} %>
	</div>
	<br>
	<div class="page">
<%
//------------------페이지 번호 목록
	if(count > 0) {
		int pageCount = count / pageSize + (count%pageSize==0 ? 0 : 1); //12/10+1=2
		int startPage = 1;
		if(currentPage%10 != 0) {
			startPage = (int)(currentPage/10) * 10 + 1;
		} else {
			startPage = ((int)(currentPage/10)-1) * 10 + 1;
		}
		
		int pageBlock = 10;
		
		int endPage = startPage + pageBlock - 1; //1+10-1=10
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		if(startPage > 10) {
%>
			<a class="pageNumBtn" href="gallery.jsp?pageNum=<%=startPage-10%>">[이전]</a>
<%			
		}
		for(int i = startPage; i<=endPage; i++){
			if(currentPage == i){
%>
				<a class="pageNumBtn current" href="gallery.jsp?pageNum=<%=i%>"><%= i %></a>
<%
			}else{
%>
				<a class="pageNumBtn" href="gallery.jsp?pageNum=<%=i%>"><%= i %></a>
<%
			}
		}
		if(endPage < pageCount) {
%>
			<a class="pageNumBtn" href="gallery.jsp?pageNum=<%=startPage+10%>">[다음]</a>
<%			
		}		
	}
//------------------
%>
	</div>
	</div>
</section>
</body>
</html>