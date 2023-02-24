<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="galleryboard.GalleryDAO" %> 
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.*" %>

<% request.setCharacterEncoding("utf-8");%>

<%
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
		//파일이 업로드되는 폴더를 지정한다.
		//String saveFolder = "C:/WS-JSPMySQL/departJSP/src/main/webapp/images/galleryimg/";
		String saveFolder = "C:/WS-JSP/departJSP/src/main/webapp/images/galleryimg/";
		//String saveFolder = "../bookimg"; //상대경로 X
		String encType = "utf-8"; //엔코딩타입
		int maxSize = 5*1024*1024;  //최대 업로될 파일크기 5Mb
		MultipartRequest multi = null;
		String filename = "";
		
		try{
		   multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());
		   out.println("업로드 성공");
		   
		   filename = multi.getFilesystemName("gimage"); //서버에 저장된 파일 이름

		}catch(Exception e){
		 	System.out.println(e);
		}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 
	<jsp:useBean id="article" class="galleryboard.GalleryVO">
		<!--<jsp:setProperty name="article" property="*" /> multipart/form-data 방식이기 때문에 동작하지 않음-->
	</jsp:useBean>
<%
	article.setGtitle(multi.getParameter("gtitle"));
	article.setGreg_date(new Timestamp(Date.valueOf(multi.getParameter("greg_date")).getTime()));
	article.setGimage(filename);	
	
	GalleryDAO gdao = GalleryDAO.getInstance();
	gdao.insertBoard(article);
	
	response.sendRedirect("gallerylist.jsp");
%>	
</body>
</html>
<%} %>