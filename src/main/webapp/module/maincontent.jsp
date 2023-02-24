<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="galleryboard.GalleryDAO" %>
<%@ page import="galleryboard.GalleryVO" %>
<%@ page import="notice.NoticeDAO" %>
<%@ page import="notice.NoticeVO" %>
<%@ page import="java.util.List" %>
<%
	int count = 0; //총글수	

	List<NoticeVO> nlist= null;
	NoticeDAO ndao = NoticeDAO.getInstance();
	count = ndao.getArticleCount();
	int nstartRow = 1;
	int npageSize = 2;
	
	if(count > 0){
		nlist = ndao.getArticles(nstartRow, npageSize);
	}
	
	
	List<GalleryVO> alist = null;
	GalleryDAO gdao = GalleryDAO.getInstance();
	count = gdao.getArticleCount();
	int gstartRow = 1;
	int gpageSize = 8;

	if(count > 0) {
		alist = gdao.getArticles(gstartRow, gpageSize);
	}
	
%>
	<!--Home Sections-->
            <section id="home" class="home bg-black fix">
                <div class="overlay"></div>
                <div class="container">
                    <div class="row">
                        <div class="main_home text-center">
                            <div class="col-md-12">
                                <div class="hello_slid">
                                    <div class="slid_item">
                                        <div class="home_text ">
                                            <h2 class="text-white">부산경상대학교</h2>
                                            <h1 class="text-white"><strong>컴퓨터정보·메타버스게임과</strong></h1>
                                            <h3 class="text-white">학과 홈페이지입니다!</h3>
                                        </div>
                                    </div><!-- End off slid item -->
                                    <div class="slid_item">
                                        <div class="home_text ">
                                            <h2 class="text-white">탁월한 코딩능력과 실무 경험을 겸비한</h2>
                                            <h1 class="text-white"><strong>현장 적합형 인재로서의 성장</strong></h1>
                                            <h3 class="text-white">IT업계 취업에 강한 학과!</h3>
                                        </div>
                                    </div><!-- End off slid item -->
                                    <div class="slid_item">
                                        <div class="home_text ">
                                            <h2 class="text-white">학기 중 현장실습을 통한</h2>
                                            <h1 class="text-white"><strong>실제 프로젝트 참여</strong></h1>
                                            <h3 class="text-white">학교 기업 앱버튼 근무를 통한 개발 역량 강화</h3>
                                        </div>
                                    </div><!-- End off slid item -->
                                    <div class="slid_item">
                                        <div class="home_text ">
                                            <h2 class="text-white">경험 많은 교수님들과 함께</h2>
                                            <h1 class="text-white">전용 실습실에서 실습</h1>
                                            <h3 class="text-white">다양한 능력과 희망을 가진 인재들이 모이는 곳!</h3>
                                        </div>
                                    </div><!-- End off slid item -->
                                </div>
                            </div>
                        </div>
                    </div><!--End off row-->
                </div><!--End off container -->
            </section> <!--End off Home Sections-->

            <!--Features Section-->
            <section id="features" class="features">
                <div class="container">
                    <div class="row">
                        <div class="main_features fix roomy-60 s-title">
                            <div class="col-md-4">
                            	<a href="#">
	                                <div class="features_item sm-m-top-30">
	                                    <div class="f_item_icon"><i class="fa-regular fa-square-check"></i></div>
	                                    <div class="f_item_text">
	                                        <h3>경력사원같은 IT개발자 및<br> 메타버스 크리에이터 양성학과</h3>
	                                        <p>탁월한 코딩 능력과 실무경험을 겸비한<br>현장 적합형 인재로서의 성장</p>
	                                    </div>
	                                </div>
                                </a>
                            </div>
                            <div class="col-md-4">
                            	<a href="https://n.news.naver.com/mnews/article/009/0004889701?sid=101">
	                                <div class="features_item sm-m-top-30">
	                                    <div class="f_item_icon"><i class="fa-solid fa-users-rectangle"></i></div>
	                                    <div class="f_item_text">
	                                        <h3>시중은행 IT 개발자 파격대우</h3>
	                                        <p>금융권의 IT 개발자 수요 폭증으로 인한<br>개발자 유치 경쟁 증가</p>
	                                    </div>
	                                </div>
                                </a>
                            </div>
                            <div class="col-md-4">
                            	<a href="https://rtquiz.cafe24.com/appbutton/">
	                                <div class="features_item sm-m-top-30">
	                                    <div class="f_item_icon"><i class="fa-solid fa-laptop-code"></i></div>
	                                    <div class="f_item_text">
	                                        <h3>학기 중 현장실습을 통한<br>실제 프로젝트 참여</h3>
	                                        <p>학교 기업 앱버튼 근무를 통한 개발 역량 강화</p>
	                                    </div>
	                                </div>
                                </a>
                            </div>
                        </div>
                    </div><!-- End off row -->
                </div><!-- End off container -->
            </section><!-- End off Featured Section-->


            <!--Business Section-->
            <section id="business" class="business bg-grey roomy-70">
                <div class="container">
                    <div class="row">
                        <div class="main_business">
                            <div class="col-md-6">
                                <div class="business_slid">
                                    <div class="slid_shap bg-grey"></div>
                                    <div class="business_items text-center">
                                        <div class="business_item">
                                            <div class="business_img">
                                                <img src="../images/about-img1.jpg" alt="" />
                                            </div>
                                        </div>

                                        <div class="business_item">
                                            <div class="business_img">
                                                <img src="../images/about-img3.jpg" alt="" />
                                            </div>
                                        </div>

                                        <div class="business_item">
                                            <div class="business_img">
                                                <img src="../images/about-img2.jpg" alt="" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="business_item sm-m-top-50">
                                    <h2 class="text-uppercase"><strong>컴퓨터정보·메타버스게임과의 특징</strong></h2>
                                    <ul>
                                        <li><i class="fa fa-arrow-circle-right"></i>개설 교과강의</li>
                                    </ul>
                                    <p class="m-top-20">컴퓨터정보·메타버스게임과에서 배울 수 있는 교과로는 앱/웹 프로그래밍, 시스템프로그래밍, 정보보안프로그래밍, 빅데이터 분석, AI(인공지능), IoT(사물인터넷), 게임애니메이션, 게임(2D,3D)캐릭터 제작, 게임배경제작, 게임엔진프로그래밍, 게임 및 콘텐츠 스토리텔링, 게임미디어응용 등 IT분야의 전반전인 교육과정을 바탕으로 학년에 따라 심화과정을 배울 수 있습니다.
                                    </p>
                                    <ul>
                                        <li><i class="fa fa-arrow-circle-right"></i>졸업 후 진로</li>
                                    </ul>
                                    <p class="m-top-20">IT솔루션 개발자, 홈페이지 개발자, 어플리케이션 개발자, 데이터 분석가 등의 자격증을 취득 가능하고, 게임·메타버스콘텐츠 전공에서 게임개발프로그래머, 게임캐릭터/배경 모델러, 게임원화가, 게임애니메이터, 게임이펙터, 가상현실/증강현실 개발자, 컴퓨터 방과 후 지도사, 코딩전문강사 등 취업, 게임회사 창업, 메타버스 크리에이터, 아바타 디자이너 등 다양한 분야의 IT 전문 개발자로 거듭날 수 있습니다.
                                    </p>

                                    <!-- <div class="business_btn">
                                        <a href="" class="btn btn-default m-top-20">더 알아보기</a>
                                    </div> -->

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section><!-- End off Business section -->

            <!--Test section-->
            <section id="test" class="test roomy-60 fix">
                <div class="container">
                    <div class="row">                        
                        <div class="main_test fix">

                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <div class="head_title text-center fix">
                                    <h2 class="text-uppercase">공지사항</h2>
                                    <h5>Board</h5>
                                </div>
                            </div>
						<%
						if(nlist == null){	//게시글 개수가 0이 아닐 때
						%>
                            <div>
                            	<h5 class="text-center">등록된 공지사항이 없습니다.</h5>
                            </div>
						<%
						}else{
							for(int i=0;i<nlist.size();i++){	// 반복문
								NoticeVO article = nlist.get(i);	
							%>
                            <div class="col-md-6">
                                <div class="test_item fix">
                                    <div class="item_img">
                                    <%if(article.getThumbnail() == null){ %>
                                        <img class="img-circle" src='../images/noticeimg/nothing.jpg' alt="">
                                    <%}else{ %>
                                        <img class="img-circle" src='../images/noticeimg/<%=article.getThumbnail()%>' alt="">
                                    <%} %>                                    
                                        <a href="../notice/content.jsp?num=<%=article.getNum()%>&pageNum=1"><i class="fa fa-quote-left"></i></a>
                                    </div>

                                    <div class="item_text">
                                        <h5><%=article.getSubject()%></h5>
                                        <p>문의처 : 부산경상대학교 컴퓨터정보·메타버스게임과  </p>
                                    </div>
                                </div>
                            </div>
                        <%
							}
						}
						%>
                        </div>
                    </div>
                </div>
            </section><!-- End off test section -->

            <!--product section-->
            <section id="gallery" class="product bg-grey">
                <div class="container">
                    <div class="main_product roomy-60">
                        <div class="head_title text-center fix">
                            <h2 class="text-uppercase">학과 앨범</h2>
                            <h5>Gallery</h5>
                        </div>

                        <%if(alist == null){%>
                            <div><h5 class="text-center">등록된 사진이 없습니다.</h5></div>
                        <% }else{
                            if(alist.size() >= 8){
                            %>
                           <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                            <!-- Indicators -->
                            <ol class="carousel-indicators">
                                <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                            </ol>
                            <!-- Wrapper for slides -->
                            <div class="carousel-inner" role="listbox">
                                <div class="item active">
                                    <div class="container">
                                        <div class="row">
											<%
											for(int i=0; i<(alist.size()/2); i++) {
													GalleryVO article = alist.get(i);
											%>  
                                            <div class="col-sm-3">
                                                <div class="port_item xs-m-top-30">                               
                                                    <div class="port_img">
                                                        <div class="gall-img" style="background-image: url('../images/galleryimg/<%=article.getGimage()%>');"></div>
                                                        <div class="port_overlay text-center">
                                                            <a href="../images/galleryimg/<%=article.getGimage()%>" class="popup-img">+</a>
                                                        </div>
                                                    </div>
                                                    <div class="port_caption m-top-20">
                                                        <h5><%=article.getGtitle()%></h5>
                                                    </div>
                                                </div>
                                            </div>
                                            <% 	} %>
                                        </div>
                                    </div>
                                </div>

                                <div class="item">
                                    <div class="container">
                                        <div class="row">
                       						<%
											for(int i=gpageSize/2; i<alist.size(); i++) {
													GalleryVO article = alist.get(i);
											%>  
                                            <div class="col-sm-3">
                                                <div class="port_item xs-m-top-30">                               
                                                    <div class="port_img">
                                                        <div class="gall-img" style="background-image: url('../images/galleryimg/<%=article.getGimage()%>');"></div>
                                                        <div class="port_overlay text-center">
                                                            <a href="../images/galleryimg/<%=article.getGimage()%>" class="popup-img">+</a>
                                                        </div>
                                                    </div>
                                                    <div class="port_caption m-top-20">
                                                        <h5><%=article.getGtitle()%></h5>
                                                    </div>
                                                </div>
                                            </div>
                                            <% 	} %>
                                        </div>
                                    </div>
                                </div>
                              </div>
                            <!-- Controls -->
                            <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                                <i class="fa fa-angle-left" aria-hidden="true"></i>
                                <span class="sr-only">Previous</span>
                            </a>

                            <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                                <i class="fa fa-angle-right" aria-hidden="true"></i>
                                <span class="sr-only">Next</span>
                            </a>
                             </div> 

                                <%}else{ 
                                if(alist.size()/4 == 1){
                                %>		
                                <div class="item active">
                                    <div class="container">
                                        <div class="row">
											<%
											for(int i=0; i<4; i++) {
													GalleryVO article = alist.get(i);
											%>  
                                            <div class="col-sm-3">
                                                <div class="port_item xs-m-top-30">                               
                                                    <div class="port_img">
                                                        <div class="gall-img" style="background-image: url('../images/galleryimg/<%=article.getGimage()%>');"></div>
                                                        <div class="port_overlay text-center">
                                                            <a href="../images/galleryimg/<%=article.getGimage()%>" class="popup-img">+</a>
                                                        </div>
                                                    </div>
                                                    <div class="port_caption m-top-20">
                                                        <h5><%=article.getGtitle()%></h5>
                                                    </div>
                                                </div>
                                            </div>
                                            <% 	} %>
                                        </div>
                                    </div>
                                 </div>
                                 <% }else{ %>
                                 <div class="item">
                                    <div class="container">
                                        <div class="row">
											<%
											for(int i=0; i<alist.size(); i++) {
													GalleryVO article = alist.get(i);
											%>  
                                            <div class="col-sm-3">
                                                <div class="port_item xs-m-top-30">                               
                                                    <div class="port_img">
                                                        <div class="gall-img" style="background-image: url('../images/galleryimg/<%=article.getGimage()%>');"></div>
                                                        <div class="port_overlay text-center">
                                                            <a href="../images/galleryimg/<%=article.getGimage()%>" class="popup-img">+</a>
                                                        </div>
                                                    </div>
                                                    <div class="port_caption m-top-20">
                                                        <h5><%=article.getGtitle()%></h5>
                                                    </div>
                                                </div>
                                            </div>
                                            <% 	} %>
                                        </div>
                                    </div>
                                 </div>
                            	<% } %>
                               </div>                                  
                          	<% } %>
                          <% } %>                                  
                    </div><!-- End off row -->
                </div><!-- End off container -->
            </section><!-- End off Product section -->


            <section id="profile" class="m-top-80">
                <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13043.55388569973!2d129.0991948!3d35.1843322!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x2686b75d5ca07394!2z67aA7IKw6rK97IOB64yA7ZWZ6rWQ!5e0!3m2!1sko!2skr!4v1673264968402!5m2!1sko!2skr" width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
            </section>
            
            
           <!--Brand Section-->
           <!--<section id="brand" class="brand fix roomy-40 m-top-30">
               <div class="container">
                   <div class="row">
                       <div class="main_brand text-center">
                           <div class="col-md-3 col-sm-5 col-xs-7">
                               <div class="brand_item sm-m-top-20">
                                   <a href="https://www.bsks.ac.kr/index_new.asp"><img src="../images/2080_default_logo.png" alt="" /></a>
                               </div>
                           </div>
                           <div class="col-md-3 col-sm-5 col-xs-7">
                               <div class="brand_item sm-m-top-20">
                                   <a href="https://ais.bsks.ac.kr/"><img src="../images/bottom_banner_1.jpg" alt="" /></a>
                               </div>
                           </div>
                           <div class="col-md-3 col-sm-5 col-xs-7">
                               <div class="brand_item sm-m-top-20">
                                   <a href="https://bsgs.certpia.com/login"><img src="../images/bottom_banner_2.jpg" alt="" /></a>
                               </div>
                           </div>
                           <div class="col-md-3 col-sm-5 col-xs-7">
                               <div class="brand_item sm-m-top-20">
                                   <a href="https://rtquiz.cafe24.com/appbutton/"><img src="../images/bottom_banner_3.jpg" alt="" /></a>
                               </div>
                           </div>
                       </div>
                   </div>
               </div>
           </section>
           <!-- End off Brand section -->
           
           <!--Brand Section-->
           <section id="brand" class="brand fix m-top-30 m-bottom-30">
               <div class="container">
                   <div class="row">
                       <div class="main_brand text-center">
                           <div class="brand_align">
                               <div class="brand_item sm-m-top-20">
                                   <a href="https://www.bsks.ac.kr/index_new.asp"><img src="../images/2080_default_logo.png" alt="" /></a>
                               </div>
                           </div>
                           <div class="brand_align">
                               <div class="brand_item sm-m-top-20">
                                   <a href="https://ais.bsks.ac.kr/"><img src="../images/bottom_banner_1.jpg" alt="" /></a>
                               </div>
                           </div>
                           <div class="brand_align">
                               <div class="brand_item sm-m-top-20">
                                   <a href="https://bsgs.certpia.com/login"><img src="../images/bottom_banner_2.jpg" alt="" /></a>
                               </div>
                           </div>
                           <div class="brand_align">
                               <div class="brand_item sm-m-top-20">
                                   <a href="https://rtquiz.cafe24.com/appbutton/"><img src="../images/bottom_banner_3.jpg" alt="" /></a>
                               </div>
                           </div>
                       </div>
                   </div>
               </div>
           </section>
           <!-- End off Brand section -->
</body>
</html>