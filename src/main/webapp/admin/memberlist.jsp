<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="member.MemberDAO" %>
<%@ page import="member.MemberVO" %>
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

	List<MemberVO> articleList = null;
	int count = 0; //총 글수
	int number = 0; //현재 페이지의 시작 번호

	MemberDAO mDAO = MemberDAO.getInstance();
	count = mDAO.getMemberCount();
	
	number = count - (currentPage - 1) * pageSize; //14-(1-1)*10=14 / 14-(2-1)*10=4

	String sword = request.getParameter("sword");
	   if (sword==null || sword.equals("")) {
	      count = mDAO.getMemberCount();   
	      if(count > 0) {		// 게시글 수가 0이 아닐 때 - 게시글이 존재할 때	
	    	  articleList = mDAO.getMembers(startRow, pageSize);

	      }
	   } else {
	      count = mDAO.getMemberCount("%"+sword+"%");   
	      if(count > 0) {
	    	  articleList = mDAO.getMembers(startRow, pageSize, "%"+sword+"%");
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
<title>회원관리 | 관리자 페이지</title>
<link href="../css/admin.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" href="../images/logo.png" />  
<script>
function check(id) {
	  var ret = confirm("삭제하시겠습니까??");
	  if(ret == true) { 
		  document.location.href="memberdelete.jsp?id=" + id + "&pageNum=<%=currentPage%>";
      } else {
  	      return;
      }      
 }
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
  <jsp:include page="../module/top-manager.jsp" flush="false"/>
  <jsp:include page="../module/header/manager.jsp" flush="false"/>
</header>
<section>
  <div id="member_box">
    <h2>회원 관리</h2><hr>
  <div class="search_box">
	  <form name="search_form" method="get" action="memberlist.jsp">
	    <input type="text" name="sword" placeholder="아이디 검색" />&nbsp;
	    <a href="#" class="searchbtn"><span onclick="search_input()">검색</span></a>
	  </form>
  </div>
  <ul id="member_list">
	<li>
		<span class="col1"><b>번호</b></span>
		<span class="col2"><b>아이디</b></span>
		<span class="col3"><b>패스워드</b></span>
		<span class="col4"><b>이름</b></span>
		<span class="col5"><b>이메일</b></span>
		<span class="col6"><b>가입일</b></span>		
		<span class="col7"><b>삭제</b></span>
	</li>

<%
if(count == 0){	
%>

	<div class="text-center roomy-60"><h5>등록된 회원이 없습니다.</h5></div>

<%
}else{ //게시글 개수가 0이 아닐 때
for(int i=0; i<articleList.size(); i++) {
  		MemberVO article = articleList.get(i);
%> 
	<li>
		<span class="col1"><%=number--%></span>
		<span class="col2"><%=article.getId()%></span>
		<span class="col3"><%=article.getPasswd()%></span>		
		<span class="col4"><%=article.getName()%></span>
		<span class="col5"><%=article.getEmail()%></span>
		<span class="col6"><%=sdf.format(article.getReg_date())%></span>
		<span class="col7"><button type="button" onclick="check('<%=article.getId()%>')">삭제</button></span>
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
%>		<div class="pagebutton">
		<span>
<%
		if(startPage > 10 ) { %>
			<a class="pageNumBtn" href="memberlist.jsp?pageNum=<%=startPage-10%>">이전</a>
<%		}
		
		for(int i=startPage; i<=endPage; i++) { %>
			<a class="pageNumBtn current" href="memberlist.jsp?pageNum=<%=i%>"><%=i%></a>
<%		}
		
		if(endPage < pageCount ) { %>
			<a class="pageNumBtn" href="memberlist.jsp?pageNum=<%=startPage+10%>">다음</a>
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