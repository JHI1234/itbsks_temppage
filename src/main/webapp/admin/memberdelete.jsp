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

<% request.setCharacterEncoding("utf-8");%>

<%
	String id = request.getParameter("id");
	int mpageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
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
		
		MemberDAO mDAO = MemberDAO.getInstance();
		mDAO.deleteMember(id);
		
		out.println("<script>alert('삭제되었습니다.');</script>");
		out.println("<script>document.location.href='memberlist.jsp?pageNum=" + mpageNum + "';</script>");
	}
%>
