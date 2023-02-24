<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="freeboard.FreeboardDAO" %>
<%@ page import="freeboard.FreeboardVO" %>
<%@ page import="java.io.File" %>   

<% request.setCharacterEncoding("utf-8");%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
		FreeboardDAO fDAO = FreeboardDAO.getInstance();
		FreeboardVO article = fDAO.getArticle(num);	
		fDAO.deleteFreeboard(num);
		
		//저장되어 있는 이미지 파일 삭제
		new File("C:/WS-JSP/departJSP/src/main/webapp/images/freeboardimg/" + article.getThumbnail()).delete(); 
		//new File("C:/WS-JSPMySQL/departJSP/src/main/webapp/images/freeboardimg/" + article.getThumbnail()).delete(); 
			
		out.println("<script>alert('삭제되었습니다.');</script>");
		out.println("<script>document.location.href='freeboardlist.jsp?pageNum=" + pageNum + "';</script>");

	}
%>