<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>	<!-- java sql package의 모든 것을 불러옴 -->
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<% request.setCharacterEncoding("utf-8"); %>	<!-- 인코딩 : 한글 처리 -->

<%
	String id = (String) session.getAttribute("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
%>

<%
	Connection conn = null;			//데이터베이스 연결할 객체
	PreparedStatement pstmt = null;	//query 실행 객체
	ResultSet rs = null;			//select문 실행 결과를 저장하는 객체
	
	// 필요할 때 사용하고 사용이 끝나면 close로 종료함
	try{
		/*
		String jdbcURL = "jdbc:mysql://localhost:3306/basicjsp";
		String dbID = "jspid";
		String dbPW = "jsppass";
		
		Class.forName("com.mysql.jdbc.Driver");	// 1.jdbc 드라이버 로딩하기
		conn = DriverManager.getConnection(jdbcURL,dbID,dbPW);	// 2.db 서버 접속하기
		*/
		
		// DataSource를 이용한 커넥션 풀(conncection pools) 설정
		InitialContext  ic = new InitialContext();		// JNDI 서버 객체 생성자 메서드
		DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/depart");	//connection 객체 찾기, ~/env/까지는 고정값이고 그 다음부터 설정가능
		conn = ds.getConnection(); //connection 객체를 할당 받음
		
		String sql = "select id, passwd from member where id=?";	// 쿼리 구문
		pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();	// 4. sql query 실행
		
		// ↓ result set의 next가 존재할 경우
		if(rs.next()){
			String rid = rs.getString("id");	//테이블의 컬럼명으로 값을 가져옴
												// resultset으로 가져온 값을 다시 변수로 저장
			if(id.equals(rid)){
				// name 수정하기
				sql = "update member set passwd=?, name=?, email=? where id=?";	
				pstmt  = conn.prepareStatement(sql);	// 3. sql을 실행하기 위한 객체 생성하기
				pstmt.setString(1, passwd);
				pstmt.setString(2, name);
				pstmt.setString(3, email);
				pstmt.setString(4, id);
				pstmt.executeUpdate();	// 4. sql query 실행
				
				out.println("<script>alert('회원정보가 수정되었습니다.');</script>");
				out.println("<script>document.location.href='memberInfo.jsp';</script>"); // 쿼리가 다 완료되면 페이지 이동
				
			}else{	//아이디는 맞지만 패스워드가 틀린경우
				out.println("패스워드가 틀렸습니다. 다시 확인해주세요!");
			}
		}else{
			out.println("아이디가 틀렸습니다. 다시 확인해주세요!");
		}
				
		
				
	}catch(Exception e){
		e.printStackTrace();
	}finally{	// 5. 자원 해제
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();	//연결 해제
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	
</body>
</html>