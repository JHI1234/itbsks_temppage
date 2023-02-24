<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="freeboard.FreeboardDAO" %>	<!-- java sql package의 모든 것을 불러옴 -->
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.io.File" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
	String id = (String) session.getAttribute("id");
	if(id==null || id.equals("")) {
		response.sendRedirect("../main/main.jsp");	
	} else {
		//파일이 업로드되는 폴더를 지정한다.
		//String saveFolder = "C:/WS-JSPMySQL/departJSP/src/main/webapp/images/freeboardimg/";		
		String saveFolder = "C:/WS-JSP/departJSP/src/main/webapp/images/freeboardimg/";
		//String saveFolder = "../bookimg"; //상대경로 X
		String encType = "utf-8"; //엔코딩타입
		int maxSize = 5*1024*1024;  //최대 업로될 파일크기 5Mb
		MultipartRequest multi = null;
		String filename = "";

		try{
		   multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());
		   System.out.println("업로드 성공");
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
	<jsp:useBean id="article" class="freeboard.FreeboardVO">
		<!--<jsp:setProperty name="article" property="*"/>	<!-- * : 전체 가져오기 -->
	</jsp:useBean>
<%
	String beforeImg = multi.getParameter("exist_thumbnail");
	String deleteImgName = saveFolder + beforeImg;
	
	File deleteImg = new File (deleteImgName);
	
	if (deleteImg.exists() && deleteImg.isFile()){
		    deleteImg.delete();// 사진 삭제
		    System.out.println("삭제된 이전 사진 : "+ beforeImg);
	}

	article.setWriter(multi.getParameter("writer"));
	article.setSubject(multi.getParameter("subject"));
	article.setReg_date(new Timestamp(Date.valueOf(multi.getParameter("reg_date")).getTime()));
	article.setContent(multi.getParameter("content"));
	article.setThumbnail(filename);
	article.setPasswd(multi.getParameter("passwd"));
	article.setNum(Integer.parseInt(multi.getParameter("num")));

	FreeboardDAO fdao = FreeboardDAO.getInstance();
	int check = fdao.updateFreeboard(article);
	if (check == 1){
		out.println("<script>alert('수정되었습니다.');</script>");
		out.println("<script>document.location.href='list.jsp?pageNum=" + multi.getParameter("pageNum") + "';</script>");

		//response.sendRedirect("qna.jsp?pageNum=" + pageNum);	// 게시글 list 페이지 이동
	}
	else{
%>
		<script type="text/javascript">
			alert("비밀번호가 맞지 않습니다.");
			history.go(-1);
		</script>
<%
	}
%>

	
</body>
</html>
<%}%>