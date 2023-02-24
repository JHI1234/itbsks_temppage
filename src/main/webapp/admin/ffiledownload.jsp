<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.io.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>

<%

	request.setCharacterEncoding("utf-8");

	String gimage = request.getParameter("thumbnail");
	String saveFolder = "C:/WS-JSP/departJSP/src/main/webapp/images/freeboardimg"; 
	//String saveFolder = "C:/WS-JSPMySQL/departJSP/src/main/webapp/images/freeboardimg"; 
	
	// 파일 연결 통로
	InputStream in = null;
	OutputStream os = null;
	File file = null;
	boolean skip = false;
	
	try {
		// 파일을 읽어 스트림에 담기
		try {
			
			file = new File(saveFolder, gimage);
			in = new FileInputStream(file);
			
		} catch(FileNotFoundException fe) {
			skip = true;
		}
		
		if(!skip) {
			//파일명에 한글이 있는 경우, 한글 처리
			gimage = new String(gimage.getBytes("utf-8"), "iso-8859-1");
		
			//파일 다운로드 헤더 지정
			response.reset();
			response.setHeader("Content-Disposition", "attachment; filename=\"" + gimage + "\"");
			response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");		
			response.setHeader("Content-Length", ""+file.length());
			
			os = response.getOutputStream();
			byte b[] = new byte[(int)file.length()];
			int leng = 0;
			
			//파일 다운로드
			while((leng=in.read(b)) > 0 ) {
				os.write(b, 0, leng);
			}
		
		} else {
			response.setContentType("text/html;charset=utf-8");
			out.println("<script language='javascript'>alert('파일을 찾을 수 없습니다.');history.back();</script>");
		}
		
		in.close();
		os.close();
		
	} catch(Exception e) {
		e.getStackTrace();
	}	

%>