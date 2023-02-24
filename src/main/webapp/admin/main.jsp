<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지 | 부산경상대학교 컴퓨터정보메타버스게임과</title>
</head>
<body>
<section>
<%
	String managerId = "";
	try {
		managerId = (String) session.getAttribute("managerId");
		if (managerId==null || managerId.equals("")) {  %>
			<jsp:include page="loginForm.jsp" flush="false"/>
<%		} else { %>
			<jsp:include page="memberlist.jsp" flush="false"/>
<%
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
%>  
</section>
</body>
</html>