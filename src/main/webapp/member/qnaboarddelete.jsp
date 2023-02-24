<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="qnaboard.QnaboardDAO" %>    

<% request.setCharacterEncoding("utf-8");%>

<%
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	int qpageNum = Integer.parseInt(request.getParameter("qpageNum"));
	
	String id = (String) session.getAttribute("id");
	if(id==null || id.equals("")) {
		response.sendRedirect("memberBoard.jsp");	
	} else {
		QnaboardDAO qDAO = QnaboardDAO.getInstance();
		qDAO.deleteqnaboard(qnum);
		response.sendRedirect("memberBoard.jsp?qpageNum=" + qpageNum);
	}
%>