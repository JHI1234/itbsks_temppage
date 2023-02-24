<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="faqboard.FaqboardDAO" %>    

<% request.setCharacterEncoding("utf-8");%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
		FaqboardDAO faDAO = FaqboardDAO.getInstance();
		faDAO.deletefaqboard(num);
		
		out.println("<script>alert('삭제되었습니다.');</script>");
		out.println("<script>document.location.href='faqlist.jsp?pageNum=" + pageNum + "';</script>");
	}
%>