<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="qnaboard.QnaboardDAO" %>	<!-- java sql package의 모든 것을 불러옴 -->


<% request.setCharacterEncoding("utf-8"); %>

<%
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="article" class="qnaboard.QnaboardVO">
		<jsp:setProperty name="article" property="*"/>	<!-- * : 전체 가져오기 -->
	</jsp:useBean>
<%
	QnaboardDAO qdao = QnaboardDAO.getInstance();
	int check = qdao.updateqnaboard(article);
	if (check == 1){
		out.println("<script>alert('수정되었습니다.');</script>");
		out.println("<script>document.location.href='qna.jsp?pageNum=" + pageNum + "';</script>");

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