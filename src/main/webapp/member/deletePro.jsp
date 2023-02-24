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

<%
	String passwd = request.getParameter("passwd");

	String id = (String) session.getAttribute("id");
	if(id==null || id.equals("")) {
		response.sendRedirect("../main/main.jsp");	
	} else {
		
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
		
		List<ReplyVO> rlist = null;
		int rcount = 0; //총 댓글수	
		
		ReplyDAO rdao = ReplyDAO.getInstance();
		rcount = rdao.getArticleCount();
		rdao.deleteMemberreply(id);
		
		rlist = rdao.getMemberArticles(id, startRow, pageSize);
		
		int[] ref;
		ref = new int[rlist.size()];
		
        for (int i = 0; i < rlist.size(); i++) {
    		ReplyVO reply = rlist.get(i);
        	ref[i] = reply.getRef();
        }
		
		
		
		QnaboardDAO qdao = QnaboardDAO.getInstance();
        for (int i = 0; i < rlist.size(); i++) {
    		qdao.deleteqnaboard(ref[i]);
        }
		
		MemberDAO mdao = MemberDAO.getInstance();
		mdao.deleteMember(id, passwd);			
		
		session.invalidate();
		out.println("<script>alert('회원 탈퇴되었습니다.');</script>");
		out.println("<script>document.location.href='../main/main.jsp';</script>");
	}
%>	
