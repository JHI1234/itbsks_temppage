<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="qnaboard.QnaboardDAO" %>    

<%
    request.setCharacterEncoding("utf-8");
    %>

<%
int pageNum = Integer.parseInt(request.getParameter("pageNum"));
String pn = Integer.toString(pageNum);
int num = Integer.parseInt(request.getParameter("num"));

	String id = (String) session.getAttribute("id");
	if(id==null || id.equals("")) {
		response.sendRedirect("../main/main.jsp");	
	} else {
		QnaboardDAO qdao = QnaboardDAO.getInstance();
		qdao.deleteqnaboard(num);			
		
		out.println("<script>alert('삭제되었습니다.');</script>");
		out.println("<script>document.location.href='list.jsp?pageNum=" + pn + "';</script>");
	}
%>	
