<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="reply.ReplyDAO" %>    

<% request.setCharacterEncoding("utf-8");%>

<%
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	int rnum = Integer.parseInt(request.getParameter("rnum"));
	
	String id = (String) session.getAttribute("id");
	if(id==null || id.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
		ReplyDAO rDAO = ReplyDAO.getInstance();
		rDAO.deletereply(rnum);
		
		out.println("<script>alert('삭제되었습니다.');</script>");
		out.println("<script>document.location.href='list.jsp?pageNum=" + pageNum + "';</script>");
	}
%>