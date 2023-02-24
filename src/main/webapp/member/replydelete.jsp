<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="reply.ReplyDAO" %>    

<% request.setCharacterEncoding("utf-8");%>

<%
	int rnum = Integer.parseInt(request.getParameter("rnum"));
	int rpageNum = Integer.parseInt(request.getParameter("rpageNum"));
	
	String id = (String) session.getAttribute("id");
	if(id==null || id.equals("")) {
		response.sendRedirect("memberBoard.jsp");	
	} else {
		ReplyDAO rDAO = ReplyDAO.getInstance();
		rDAO.deletereply(rnum);
		response.sendRedirect("memberBoard.jsp?rpageNum=" + rpageNum);
	}
%>