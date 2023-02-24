<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="member.MemberDAO" %>
<%@ page import="member.MemberVO" %>

<%
	String id = (String) session.getAttribute("id");
	MemberDAO mbao = MemberDAO.getInstance();
	MemberVO article = mbao.getMember(id);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 확인 | 부산경상대학교 컴퓨터정보·메타버스게임과 학과</title>
<link href="../css/member.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" href="../images/logo.png" />  
</head>
<body>
<header>
  <jsp:include page="../module/top-sub.jsp" flush="false"/>
  <jsp:include page="../module/header/info.jsp" flush="false"/>
  <jsp:include page="../board/memberInfo.jsp" flush="false"/>
</header>
<section>
<div id="main_content">
   <div id="info_box">
      <form name="member_info" method="post">
  		  <table>
	  		  <tr class="form id">
			     <td class="col1">아이디</td>
			     <td class="col2"><%=article.getId()%></td>  
			     <td class="col3"></td>                 
	    	  </tr>
	    	  <tr class="form">
	          	<td class="col1">이름</td>
	      		<td class="col2"><%=article.getName()%></td>                 
	    	  	<td></td>
	    	  </tr>
	    	  <tr class="form">
	          	<td class="col1">e-mail</td>
	      		<td class="col2"><%=article.getEmail()%></td>                 
	    	  	<td></td>
	    	  </tr>
 	    	  <tr class="form">
	    		  <td colspan="3"><div class="bottom_line"></div></td>
			  </tr>
	    	  <tr class="buttons">
	           	<td colspan="3">
	           		<input class="join-btn" type="button" style="cursor:pointer" value="수정하기" onclick="location.href='updateForm.jsp'">&nbsp;
	           		<input class="join-btn" type="button" style="cursor:pointer" value="목록" onclick="location.href='memberPage.jsp'">
	           		
	           	</td>
	      	  </tr>
      	  </table>
     	</form>
  	</div> <!-- join_box -->
  </div> <!-- main_content -->
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>