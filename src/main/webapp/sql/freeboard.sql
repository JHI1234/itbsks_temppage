drop table freeboard;

create table freeboard(
     num int not null primary key auto_increment,
     writer varchar(20) not null,     
     subject varchar(50) not null,
     passwd varchar(15) not null,
     reg_date datetime not null,
     readcount int default 0,
     content text not null,
     thumbnail varchar(100) default 'nothing.jpg',
     FOREIGN KEY(writer) REFERENCES member(id)	
);

--게시판 글은 member 테이블에 id가 있는 회원만 가능하도록 설정

insert into freeboard(writer, subject, passwd, reg_date, content)
values ('admin', 'WebVR관련자료 링크모음 V0.8', '1', '2019-05-19 00:00:00', 'Tutorials







[1] A webVR with threeJS Tutorial



http://elevr.com/a-webvr-with-threejs-tutorial/







[2] Sketchfab



https://blog.sketchfab.com/virtual-reality-mobile-vr-webvr/







[3] 4 Steps to Start Experimenting with WebVR in 10 Minutes



http://www.roadtovr.com/4-steps-to-start-experimenting-with-webvr-in-10-minutes/







[4] WebVR ? Virtual Reality for the Web



https://developer.mozilla.org/en-US/docs/Games/Techniques/3D_on_the_web/WebVR







[5] A-Frame WebVR Programming Tutorials



http://www.sonarlearning.co.uk/questions.php?question-topic=505







[6] Create interactive WebVR pages with Mozilla’s A-Frame



https://www.gadgetdaily.xyz/create-interactive-webvr-pages-with-mozillas-a-frame/







[7] How to WebVR - how to setup a WebVR compatible environement and use WebVR on your ForgeJS projects.



http://forgejs.org/tutorials/basics/how-to-webvr







[8] Reactive Audio WebVR



https://css-tricks.com/reactive-audio-webvr/







[9] Html5+js with game engine cocos2d-html5 분석



https://www.slideshare.net/ChanhoSong/html5js-with-game-engine-cocos2dhtml5







[10] HTML5 게임엔진



https://www.slideshare.net/senxation/



https://html5gameengine.com/



http://phaser.io/ : Desktop and Mobile HTML5 game framework







------------------------------------------------------------------------------------







YouTube - 동영상







[1] Introduction to WebVR 1.0 (Brandon Jones) (15분)



https://youtu.be/d3MXuuQRqjs







[2] WebVR: How to create virtual worlds with JavaScript (30분)



https://youtu.be/fNJj90gGX6A







[3] Why you should care about the VR Web - and how to build it! (30분)



https://youtu.be/skxeCo7xJx8







[4] Build the Virtual Reality Web with A-Frame - Forward 4 Web Summit (35분 )



https://youtu.be/f2pu-oMspLs







------------------------------------------------------------------------------------



Games : HTML5+WEBGL







[1] 3D -레이싱게임(소스공개) : http://hexgl.bkcore.com/play/



[2] Three.js와 사용가능한 물리엔진 라이브러리







° Ammo.js - 다소 복잡함 : https://github.com/kripken/ammo.js/ .



° Cannon.js - 작고 단순함 : https://github.com/schteppe/cannon.js .



° Physi.js - https://github.com/chandlerprall/ Physijs .











------------------------------------------------------------------------------------







A-Frame



https://aframe.io/docs/guide/getting-started.html



https://aframe.io/blog/



http://drawvr.com/welcome/



http://infiverse.com/







WebVR:



WebVR은 사용자가 보유한 VR 헤드셋를 사용하여



브라우저에서 완전 몰입형 3D 경험을 제공하는 자바스크립트 API







https://developers.google.com/web/fundamentals/vr/ (*****)



https://webvr.info/



https://webvr.info/samples/ :demonstrating how to use various aspects of the WebVR API.



https://github.com/toji/webvr.info/blob/master/samples/00-hello-webvr.html : Hello WebVR



https://webvr.info/samples/03-vr-presentation.html?polyfill=1 : VR Presentation



https://developer.mozilla.org/en-US/docs/Web/API/WebVR_API



https://github.com/borismus/webvr-boilerplate



https://w3c.github.io/webvr/spec/1.1/



http://drawvr.com/











Three.js



http://threejs.org/docs/index.html#Manual/Introduction/Creating_a_scene



http://threejs.org/examples/



https://threejs.org/examples/webvr_cubes.html



http://stemkoski.github.io/Three.js/index.html : 80여개의 견본 프로그램



-The goal of this collection is to provide a set of basic and instructive examples that introduce the various features in Three.js.



The source code for each page contains detailed comments. (*****)











WebGL



WebGL은 OpenGL ES 2.0을 기반으로 하고 3차원 그래픽을 사용하기 위한 프로그래밍



인터페이스를 제공한다. WebGL은 HTML5 캔버스 요소를 사용하고 DOM모델



인터페이스를 사용해서 액세스할 수 있다.



자바스크립트 언어의 일부로서 자동 메모리 관리자가 제공된다.







https://www.khronos.org/webgl/



http://learningwebgl.com/lessons/ : WebGL Lessons



http://www.webgl3d.co.kr/demo/');

insert into freeboard(writer, subject, passwd, reg_date, content)
values ('aaa', 'gameScreen.lua', '1', now(), '
 

-----------------------------------------------------------------------------------------

--

-- gameScreen.lua

--

-----------------------------------------------------------------------------------------

 

local composer = require( "composer" )

local scene = composer.newScene()

 

 

-- Called when the scene's view does not exist:

function scene:create( event )

 local group = self.view

 

     

end

 

 

-- Called immediately after scene has moved onscreen:

function scene:show( event )

 local group = self.view 

 

 local phase = event.phase

 

    if ( phase == "will" ) then

      -- Called when the scene is on screen (but is about to go off screen).

      -- Insert code here to "pause" the scene.

      -- Example: stop timers, stop animation, stop audio, etc.

    elseif ( phase == "did" ) then

 

end

 

 

-- Called when scene is about to move offscreen:

function scene:hide( event )

 local group = self.view 

 

    if ( phase == "will" ) then

      -- Called when the scene is on screen (but is about to go off screen).

      -- Insert code here to "pause" the scene.

      -- Example: stop timers, stop animation, stop audio, etc.

      composer.removeScene( true )

      

    elseif ( phase == "did" ) then

 

    end

    

end

 

 

 

-- Called prior to the removal of scene's "view" (display group)

function scene:destroy( event )

 local group = self.view 

 

end

 

 

---------------------------------------------------------------------------------

-- END OF YOUR IMPLEMENTATION

---------------------------------------------------------------------------------

 

scene:addEventListener( "create", scene )

scene:addEventListener( "show", scene )

scene:addEventListener( "hide", scene )

scene:addEventListener( "destroy", scene )

 

return scene'');

insert into freeboard(writer, subject, passwd, reg_date, content)
values ('bbb', 'NodeMCU로 시작하는 사물인터넷 DIY', '1', now(), '2019학년도 2학기 "C언어 프로그래밍 실무"과목에서



사물인터넷 구현에 관한 내용으로



강의를 시작했습니다.');

insert into freeboard(writer, subject, passwd, reg_date, content)
values ('bbb', '내일을 잡아라 신직업 사물인터넷', '1', now(), 'https://www.youtube.com/watch?v=slwNcMJ1Wi8');

insert into freeboard(writer, subject, passwd, reg_date, content)
values ('bbb', '4축 모션시뮬레이터 제작 후기', '1', now(), '4축 모션시뮬레이터 제작 후기입니다.



보다 자세한 제작과정은 아래 네이버 블로그와



유튜브 동영상을 참고하세요.');

-- insert into freeboard(writer, subject, reg_date, content)
-- values ('111', '제목 test4', now(), '내용 test4');  --member 테이블에는 111이라는 테이블이 없으므로 insert into가 실행 안됨

select * from freeboard order by num desc;	--외부키로 설정되어 있기때문에 삭제 불가능

delete from freeboard where num=3;

select * 
from freeboard 
order by num desc
limit 0,10; --시작번호, 검색할 레코드 수 // mysql은 0부터 시작

SET @count=0;
UPDATE freeboard SET num=@count:=@count+1;
ALTER TABLE freeboard AUTO_INCREMENT=0;