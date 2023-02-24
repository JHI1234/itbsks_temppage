<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="member.MemberDAO" %> 
<%@ page import="member.MemberVO" %>
<%@ page import="freeboard.FreeboardDAO" %>
<%@ page import="freeboard.FreeboardVO" %>
<%@ page import="qnaboard.QnaboardDAO" %>
<%@ page import="qnaboard.QnaboardVO" %>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="reply.ReplyVO" %>
<%@ page import="java.util.List" %>

<%
    request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String passwd = request.getParameter("passwd");

	String id = (String) session.getAttribute("id");
	if(id==null || id.equals("")) {
		response.sendRedirect("../main/main.jsp");	
	} else {
		FreeboardDAO fdao = FreeboardDAO.getInstance();
		fdao.deleteMemberFreeboard(id);
		
	
		ReplyDAO rdao = ReplyDAO.getInstance();
		rdao.deleteMemberreply(id);
		
		//페이지처리
		int pageSize = 20;
		String pageNum = null;

		pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		}
		
		int currentPage = Integer.parseInt(pageNum);    // 1			/2 
		int startRow = (currentPage - 1) * pageSize + 1;//(1-1)*10+1=1	/(2-1)*10+1=11
		int endRow = currentPage * pageSize;			//1*10=10		/(2*10)=20
		
		List<QnaboardVO> qlist = null;
		
		QnaboardDAO qdao = QnaboardDAO.getInstance();
		qlist = qdao.getMemberArticles(id, startRow, pageSize);
		
		if(qlist != null){
			int[] ref;
			ref = new int[qlist.size()];
			
	       for (int i = 0; i < qlist.size(); i++) {
	       	QnaboardVO qnareply = qlist.get(i);
	       	ref[i] = qnareply.getNum();
	       }
		
	       for (int i = 0; i < qlist.size(); i++) {
	   		qdao.deleteqnaboard(ref[i]);
	       }
		}
		
		MemberDAO mdao = MemberDAO.getInstance();
		int check = mdao.deleteMember(id, passwd);
		if (check == 1){
			session.invalidate();
			out.println("<script>alert('회원 탈퇴되었습니다.');</script>");
			out.println("<script>document.location.href='../main/main.jsp';</script>");
		}
		else{
	%>
		<script type="text/javascript">
			alert("비밀번호가 맞지 않습니다.");
			history.go(-1);
			document.delete_form.passwd.focus();
		</script>
<%
		}
	}
%>	

</body>
</html>
