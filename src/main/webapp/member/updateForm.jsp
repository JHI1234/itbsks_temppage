<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link href="../css/member.css" rel="stylesheet" type="text/css">
<script>
function check_input()
{
   if (!document.update_form.passwd.value) {
       alert("비밀번호를 입력하세요!");    
       document.update_form.passwd.focus();
       return;
   }

   if (!document.update_form.passwd_confirm.value) {
       alert("비밀번호확인을 입력하세요!");    
       document.update_form.passwd_confirm.focus();
       return;
   }

   if (!document.update_form.name.value) {
       alert("이름을 입력하세요!");    
       document.update_form.name.focus();
       return;
   }

   if (document.update_form.passwd.value != 
         document.update_form.passwd_confirm.value) {
       alert("비밀번호가 일치하지 않습니다.\n다시 입력해 주세요!");
       document.member_form.passwd.focus();
       document.member_form.passwd.select();
       return;
   }

   document.update_form.submit();
}

function reset_form() { 
   document.update_form.passwd.value = "";
   document.update_form.passwd_confirm.value = "";
   document.update_form.name.value = "";
   document.update_form.email.value = "";
   document.update_form.passwd.focus();
   return;
}

</script>
</head>
<body>
<header>
  <jsp:include page="../module/top-sub.jsp" flush="false"/>
  <jsp:include page="../module/header/info.jsp" flush="false"/>
  <jsp:include page="../board/memberInfo.jsp" flush="false"/>
</header>
<section>
<div id="main_content">
   <div id="join_box">
      <form name="update_form" method="post" action="updatePro.jsp">
  		  <table>
	  		  <tr class="form id">
		  		  <%
			  		String id1 = "";
		  		  	id1 = (String) session.getAttribute("id");
		  		  %>
			     <td class="col1">아이디</td>
			     <td class="col2"><%= id1 %></td>  
			     <td class="col3"></td>                 
	    	  </tr>
	     	  <tr class="form">
	      		<td class="col1">비밀번호</td>
	      		<td class="col2"><input type="password" name="passwd"></td>
	      		<td></td>               
	    	  </tr>
	    	  <tr class="form">
	      		<td class="col1">비밀번호 확인</td>
	      		<td class="col2"><input type="password" name="passwd_confirm"></td>                 
	    	  	<td></td>
	    	  </tr>
	    	  <tr class="form">
	          	<td class="col1">이름</td>
	      		<td class="col2"><input type="text" name="name"></td>                 
	    	  	<td></td>
	    	  </tr>
	    	  <tr class="form">
	          	<td class="col1">e-mail</td>
	      		<td class="col2"><input type="text" name="email"></td>                 
	    	  	<td></td>
	    	  </tr>
 	    	  <tr class="form">
	    		  <td colspan="3"><div class="bottom_line"></div></td>
			  </tr>
	    	  <tr class="buttons">
	           	<td colspan="3">
	           		<input class="join-btn" type="button" style="cursor:pointer" value="수정하기" onclick="check_input()">&nbsp;
	           		<input class="join-btn" type="button" id="reset_button" style="cursor:pointer" value="취소하기" onclick="reset_form()">&nbsp;
	           		<input class="join-btn" type="button" style="cursor:pointer" value="목록" onclick="location.href='memberPage.jsp'">
	           	</td>
	      	  </tr>
      	  </table>
     	</form>
  	</div> <!-- join_box -->
  </div> <!-- main_content -->
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>