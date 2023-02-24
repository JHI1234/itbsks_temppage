<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="qnaboard.QnaboardDAO" %>    

<% request.setCharacterEncoding("utf-8");%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
		QnaboardDAO qDAO = QnaboardDAO.getInstance();
		qDAO.deleteqnaboard(num);
		response.sendRedirect("qnalist.jsp?pageNum=" + pageNum);
	}
%>