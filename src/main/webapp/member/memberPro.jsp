<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>	<!-- java sql package의 모든 것을 불러옴 -->
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
%>

<%
	Connection conn = null;			//데이터베이스 연결할 객체
	PreparedStatement pstmt = null;	//query 실행 객체
	String str = "";
	
	// 필요할 때 사용하고 사용이 끝나면 close로 종료함
	try{		
		// DataSource를 이용한 커넥션 풀(conncection pools) 설정
		InitialContext  ic = new InitialContext();		// JNDI 서버 객체 생성자 메서드
		DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/depart");	//connection 객체 찾기, ~/env/까지는 고정값이고 그 다음부터 설정가능
		conn = ds.getConnection(); //connection 객체를 할당 받음
		
		String sql = "insert into member values (?, ?, ?, ?, now())";	// 쿼리 구문
		pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
		pstmt.setString(1, id);
		pstmt.setString(2, passwd);
		pstmt.setString(3, name);
		pstmt.setString(4, email);
		pstmt.executeUpdate();	// 4. sql query 실행
		
		str = "member 테이블에 새로운 레코드를 추가했습니다.";
		out.println("<script>alert('회원가입을 환영합니다.');</script>");
		out.println("<script>document.location.href='../main/main.jsp';</script>");
		
		//response.sendRedirect("../main/main.jsp");	//페이지 이동
		
		
				
	}catch(Exception e){
		e.printStackTrace();
	}finally{	// 5. 자원 해제
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();	//연결 해제
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
</body>
</html>