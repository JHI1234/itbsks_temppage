<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8">
        <title>부산경상대학교 컴퓨터정보·메타버스게임과 학과 홈페이지</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--Google Font link-->
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">


        <link rel="stylesheet" href="../css/slick/slick.css"> 
        <link rel="stylesheet" href="../css/slick/slick-theme.css">
        <link rel="stylesheet" href="../css/animate.css">
        <link rel="stylesheet" href="../css/iconfont.css">
        <link rel="stylesheet" href="../css/font-awesome.min.css">
        <link rel="stylesheet" href="../css/bootstrap.css">
        <link rel="stylesheet" href="../css/magnific-popup.css">
        <link rel="stylesheet" href="../css/bootsnav.css">

        <!-- xsslider slider css -->
        <!--<link rel="stylesheet" href="../css/xsslider.css">-->

        <!--For Plugins external css-->
        <!--<link rel="stylesheet" href="../css/plugins.css" />-->

        <!--Theme custom css -->
        <link rel="stylesheet" href="../css/style.css">
        
        <!--Custom css -->        
        <link rel="stylesheet" href="../css/main.css">
        <!--<link rel="stylesheet" href="../css/colors/maron.css">-->

        <!--Theme Responsive css-->
        <link rel="stylesheet" href="../css/responsive.css" />

        <script src="../js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
        <script>history.scrollRestoration = "manual"</script><!-- 페이지 새로고침 시 상단으로 이동 -->
        <script src="https://kit.fontawesome.com/5f42398762.js" crossorigin="anonymous"></script>
    
</head>
<body data-spy="scroll" data-target=".navbar-collapse">

        <div class="culmn">
            <!--Home page style-->
            <nav class="navbar navbar-default bootsnav navbar-fixed">
                <!-- Start Top Search -->
                <div class="top-search">
                    <div class="container">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-search"></i></span>
                            <input type="text" class="form-control" placeholder="Search">
                            <span class="input-group-addon close-search"><i class="fa fa-times"></i></span>
                        </div>
                    </div>
                </div>
                <!-- End Top Search -->


                <div class="container"> 

                    <!-- Start Header Navigation -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
                            <i class="fa fa-bars"></i>
                        </button>
                        <a class="navbar-brand" href="../admin/main.jsp">
                            <img src="../images/dept_logo.png" class="logo" alt="">
                            <!--<img src="../images/footer-logo.png" class="logo logo-scrolled" alt="">-->
                        </a>

                    </div>
                    <!-- End Header Navigation -->

                    <!-- navbar menu -->
                    <div class="collapse navbar-collapse" id="navbar-menu">
                        <ul class="nav navbar-nav navbar-right">                  
							<%
								String managerId = "";
								try {
									managerId = (String) session.getAttribute("managerId");
									if (managerId==null || managerId.equals("")) { 
										response.sendRedirect("../admin/main.jsp");	
									} else {
							%>
									    <li><a href="../admin/memberlist.jsp">회원 관리</a></li>
									    <li><a href="../admin/noticelist.jsp">공지사항 관리</a></li>										        
									    <li><a href="../admin/freeboardlist.jsp">학과소식 관리</a></li>								        
									    <li><a href="../admin/qnalist.jsp">입시Q&A 관리</a></li>
									    <li><a href="../admin/gallerylist.jsp">학과앨범 관리</a></li>								    
   								        <li><a class="nopointer">|</a></li>
										<li><a><%=managerId %> 님</a></li>
										<li><a href="logoutPro.jsp">로그아웃</a></li>

		
							<%
									}
								} catch(Exception e) {
									e.printStackTrace();
								}
							%>
                        </ul>
                    </div><!-- /.navbar-collapse -->
                </div> 
            </nav>
          </div>
          
        <script src="../js/vendor/jquery-1.11.2.min.js"></script>
        <script src="../js/vendor/bootstrap.min.js"></script>

        <script src="../js/owl.carousel.min.js"></script>
        <script src="../js/jquery.magnific-popup.js"></script>
        <script src="../js/jquery.easing.1.3.js"></script>
        <script src="../css/slick/slick.js"></script>
        <script src="../css/slick/slick.min.js"></script>
        <script src="../js/jquery.collapse.js"></script>
        <script src="../js/bootsnav.js"></script>



        <script src="../js/plugins.js"></script>
        <script src="../js/main.js"></script>
</body>
</html>