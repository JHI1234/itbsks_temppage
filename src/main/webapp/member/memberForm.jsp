<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 | 부산경상대학교 컴퓨터정보·메타버스게임과 학과</title>
<link href="../css/member.css" rel="stylesheet" type="text/css">
<script>
   function check_input()
   {
      if (!document.member_form.id.value) {
          alert("아이디를 입력하세요!");    
          document.member_form.id.focus();
          return;
      }

      if (!document.member_form.passwd.value) {
          alert("비밀번호를 입력하세요!");    
          document.member_form.passwd.focus();
          return;
      }

      if (!document.member_form.passwd_confirm.value) {
          alert("비밀번호확인을 입력하세요!");    
          document.member_form.passwd_confirm.focus();
          return;
      }

      if (!document.member_form.name.value) {
          alert("이름을 입력하세요!");    
          document.member_form.name.focus();
          return;
      }

      if (document.member_form.passwd.value != 
            document.member_form.passwd_confirm.value) {
          alert("비밀번호가 일치하지 않습니다.\n다시 입력해 주세요!");
          document.member_form.passwd.focus();
          document.member_form.passwd.select();
          return;
      }

      document.member_form.submit();
   }

   function reset_form() {
      document.member_form.id.value = "";  
      document.member_form.passwd.value = "";
      document.member_form.passwd_confirm.value = "";
      document.member_form.name.value = "";
      document.member_form.email.value = "";
      document.member_form.id.focus();
      return;
   }
   
   function check_id() {
	     window.open("memberCheckId.jsp?id=" + document.member_form.id.value,
	         		 "IDcheck",
	          		 "left=700,top=300,width=300,height=150,scrollbars=no,resizable=yes");
   }   
   
</script>
</head>
<body>
<header>
  <jsp:include page="../module/top-sub.jsp" flush="false"/>
  <jsp:include page="../module/header/signup.jsp" flush="false"/>
</header>
<section>
<div id="main_content">
   <div id="join_box">
      <form name="member_form" method="post" action="memberPro.jsp">
  		  <table>
	  		  <tr class="form id">
			     <td class="col1">아이디</td>
			     <td class="col2"><input type="text" name="id"></td>  
			     <td class="col3"><button class="join-btn" type="button" onclick="check_id()">중복확인</button></td>                 
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
	           		<input class="join-btn" type="button" style="cursor:pointer" value="가입하기" onclick="check_input()">&nbsp;
	           		<input class="join-btn" type="button" id="reset_button" style="cursor:pointer" value="취소하기" onclick="reset_form()">
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