<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="faqboard.FaqboardDAO" %> 

<% request.setCharacterEncoding("utf-8");%>

<%
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 
	<jsp:useBean id="article" class="faqboard.FaqboardVO">
		<jsp:setProperty name="article" property="*" /> <!--multipart/form-data 방식이기 때문에 동작하지 않음-->
	</jsp:useBean>
<%
	
	FaqboardDAO fadao = FaqboardDAO.getInstance();
	fadao.insertfaqboard(article);
	
	response.sendRedirect("faqlist.jsp");
%>	
</body>
</html>
<%} %>