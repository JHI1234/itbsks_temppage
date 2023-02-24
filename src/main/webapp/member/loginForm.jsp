<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/login.css" rel="stylesheet" type="text/css">
<script>
function check_input()
{
    if (!document.login_form.id.value)
    {
        alert("아이디를 입력하세요");    
        document.login_form.id.focus();
        return;
    }

    if (!document.login_form.passwd.value)
    {
        alert("비밀번호를 입력하세요");    
        document.login_form.passwd.focus();
        return;
    }
    
    document.login_form.submit();
}
</script>
</head>
<body>
<header>
  <jsp:include page="../module/top-sub.jsp" flush="false"/>
  <jsp:include page="../module/header/login.jsp" flush="false"/>
</header>
<section>
   <div id="main_content">
 	  <div id="login_box">
     	  <form name="login_form" method="post" action="loginPro.jsp">	
     	  	 <div class="form id"><input type="text" name="id" placeholder="아이디" ></div>
    	  	 <div class="clear"></div>
     	     <div class="form"><input type="password" id="passwd" name="passwd" placeholder="비밀번호" ></div>
             <div id="login_btn">
              	<a href="#"><span onclick="check_input()">로그인</span></a>
             </div>		    	
      	  </form>
	</div> <!-- login_box -->
   </div> <!-- main_content -->
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>