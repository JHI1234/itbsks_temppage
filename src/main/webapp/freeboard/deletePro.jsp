<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="freeboard.FreeboardDAO" %>    

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
		FreeboardDAO ndao = FreeboardDAO.getInstance();
		ndao.deleteFreeboard(num);
		out.println("<script>alert('삭제되었습니다.');</script>");
		out.println("<script>document.location.href='freeboard.jsp?pageNum=" + pn + "';</script>");
	}
%>	
