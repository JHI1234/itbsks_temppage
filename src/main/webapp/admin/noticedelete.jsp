<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="notice.NoticeDAO" %>
<%@ page import="notice.NoticeVO" %>
<%@ page import="java.io.File" %>    

<% request.setCharacterEncoding("utf-8");%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
		NoticeDAO nDAO = NoticeDAO.getInstance();
		NoticeVO image = nDAO.getArticle(num);	
		nDAO.deletenotice(num);
		
		//저장되어 있는 이미지 파일 삭제
		//new File("C:/WS-JSPMySQL/departJSP/src/main/webapp/images/noticeimg" + image.getThumbnail()).delete();
		new File("C:/WS-JSP/departJSP/src/main/webapp/images/noticeimg/" + image.getThumbnail()).delete();
		
		out.println("<script>alert('삭제되었습니다.');</script>");
		out.println("<script>document.location.href='noticelist.jsp?pageNum=" + pageNum + "';</script>");
	}
%>