<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="freeboard.FreeboardDAO" %>    

<% request.setCharacterEncoding("utf-8");%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	String id = (String) session.getAttribute("id");
	if(id==null || id.equals("")) {
		response.sendRedirect("memberBoard.jsp");	
	} else {
		FreeboardDAO fDAO = FreeboardDAO.getInstance();
		fDAO.deleteFreeboard(num);
		response.sendRedirect("memberBoard.jsp?pageNum=" + pageNum);
	}
%>