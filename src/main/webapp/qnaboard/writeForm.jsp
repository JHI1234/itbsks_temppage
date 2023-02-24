<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입시 Q&A</title>
<link href="../css/board.css" rel="stylesheet" type="text/css">
<script>
  function check_input() {
      if (!document.board_form.subject.value)
      {
          alert("제목을 입력하세요!");
          document.board_form.subject.focus();
          return;
      }
      if (!document.board_form.content.value)
      {
          alert("내용을 입력하세요!");    
          document.board_form.content.focus();
          return;
      }
      document.board_form.submit();
   }
</script>
</head>
<body>
<% 
	String id = (String) session.getAttribute("id");
	if(id==null || id.equals("")) {
		response.sendRedirect("../main/main.jsp");	
	} else {
%>
<header>
	<jsp:include page="../module/top-sub.jsp" flush="false"/>
	<jsp:include page="../module/header/board.jsp" flush="false"/>
</header>
<section class="board-top">
  <h2>입시 Q&A</h2>
  <hr>
  <div id="board_box">
  <form id="qna-write" name="board_form" method="post" action="writePro.jsp">
   	 <ul id="board_form">
		<li>
			<span class="col1">&nbsp;&nbsp;작성자</span>
			<span class="col2"><%=id%></span>
		</li>		
   		<li>
   			<span class="col1">&nbsp;&nbsp;제&nbsp;&nbsp;목</span>
   			<span class="col2"><input name="subject" type="text"></span>
   		</li>	    	
   		<li id="text_area">	
   			<span class="col1 t-area">&nbsp;&nbsp;내&nbsp;&nbsp;용</span>
   			<span class="col2">
   				<textarea name="content"></textarea>
   			</span>
   		</li>
		<li>
			<span class="col1">패스워드</span>
			<span class="col2">
				<input type="password" size="8" maxlength="15" name="passwd">
			</span>
		</li>   		
    </ul>
    <hr>
   	<ul class="buttons center">
		<li><button type="button" onclick="check_input()">등 록</button></li>
		<li><button type="button" onclick="location.href='list.jsp'">목 록</button></li>
	</ul>
  </form>
  </div>
</section>
<footer>
	<jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
<% } %>
</body>
</html>