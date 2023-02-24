<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="freeboard.FreeboardDAO" %>

<%
    request.setCharacterEncoding("utf-8");
    %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String id = (String) session.getAttribute("id");
	if(id==null || id.equals("")) {
		response.sendRedirect("../main/main.jsp");	
	} else {
%>
	<jsp:useBean id="article" class="freeboard.FreeboardVO">
		<jsp:setProperty name="article" property="*" />
	</jsp:useBean>
<%
	FreeboardDAO ndao = FreeboardDAO.getInstance();
	ndao.insertFreeboard(article);
	
	response.sendRedirect("freeboard.jsp");
	
	}
%>	
</body>
</html>