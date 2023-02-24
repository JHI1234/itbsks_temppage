<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="galleryboard.GalleryDAO" %>
<%@ page import="galleryboard.GalleryVO" %>
<%@ page import="java.io.File" %>     

<%
    request.setCharacterEncoding("utf-8");
    %>

<%
	int gnum = Integer.parseInt(request.getParameter("gnum"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
		// 레코드 삭제
		GalleryDAO gDAO = GalleryDAO.getInstance();
		GalleryVO gallery = gDAO.getArticle(gnum);		
		gDAO.deleteGallery(gnum);				
		
		
		//저장되어 있는 이미지 파일 삭제
		//new File("C://WS-JSP/BookSite/src/main/webapp/img/bookimg" + gallery.getGimage()).delete();
		new File("C:/WS-JSPMySQL/departJSP/src/main/webapp/images/galleryimg" + gallery.getGimage()).delete(); 

		response.sendRedirect("gallerylist.jsp?pageNum=" + pageNum);
	}
%>