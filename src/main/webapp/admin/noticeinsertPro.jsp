<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="notice.NoticeDAO" %> 
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<%
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
		//파일이 업로드되는 폴더를 지정한다.
		//String saveFolder = "C://WS-JSP/BookSite/src/main/webapp/img/bookimg";
		String saveFolder = "C:/WS-JSP/departJSP/src/main/webapp/images/noticeimg/";
		//String saveFolder = "../bookimg"; //상대경로 X
		String encType = "utf-8"; //엔코딩타입
		int maxSize = 5*1024*1024;  //최대 업로될 파일크기 5Mb
		MultipartRequest multi = null;
		String filename = "";
		
		try{
		   multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());
		   out.println("업로드 성공");
		   
		   filename = multi.getFilesystemName("thumbnail"); //서버에 저장된 파일 이름

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
 
	<jsp:useBean id="article" class="notice.NoticeVO">
		<!--<jsp:setProperty name="article" property="*" /> multipart/form-data 방식이기 때문에 동작하지 않음-->
	</jsp:useBean>
<%
	article.setWriter(multi.getParameter("writer"));
	article.setSubject(multi.getParameter("subject"));
	article.setReg_date(new Timestamp(Date.valueOf(multi.getParameter("reg_date")).getTime()));
	article.setContent(multi.getParameter("content"));
	article.setThumbnail(filename);	
	
	NoticeDAO ndao = NoticeDAO.getInstance();
	ndao.insertnotice(article);
	
	response.sendRedirect("noticelist.jsp");
%>	
</body>
</html>
<%} %>