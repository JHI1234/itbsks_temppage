<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="member.MemberDAO" %> 

<% request.setCharacterEncoding("utf-8");%>

<%
	String id = request.getParameter("id");
	
	MemberDAO mdao = MemberDAO.getInstance();
	int check = mdao.idCheck(id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
h3 {
   padding-left: 10px;
   border-left: solid 10px #003876;
}
#close {
   margin:20px 0 0 100px;
   cursor:pointer;
}
</style>
</head>
<body>
<h3>아이디 중복체크</h3>
<p>
<%	
if(id == "") {
%>
	<li>아이디를 입력해 주세요!</li>
<%	
} else {
	if(check == 1) {
%>
	<li>"<%=id %>" 아이디는 중복됩니다.</li>
	<li>다른 아이디를 사용해 주세요!</li>
<%
	} else {
%>
	<li>"<%=id %>" 아이디는 사용 가능합니다.</li>
<%		
	}
}
%>
</p>
<div id="close">
   <span style="background-color:#003876; padding:10px; color:#fff; border-radius:5px; font-size:.7rem;" onclick="javascript:self.close()">닫기</span>
</div>
</body>
</html>