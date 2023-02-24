drop table noticeboard;

create table noticeboard(
     num int not null primary key auto_increment,
     writer varchar(20) not null,     
     subject varchar(50) not null,
     reg_date datetime not null,
     readcount int default 0,
     content text not null,
     thumbnail varchar(100) default 'nothing.jpg'
);

--게시판 글은 member 테이블에 id가 있는 회원만 가능하도록 설정

insert into noticeboard(writer, subject, reg_date, content)
values ('관리자', '학교적응력검사 및 진로적성검사 실시', '2022-03-14 00:00:00', '
학생진로심리상담센터에서 2022학년도 1학년 신입생을 대상으로 학교적응력검사 및 진로적성검사를 실시하고자 합니다.

학생들에게 안내 꼭 부탁드립니다. 세부내용은 아래와 같습니다.



1. 학교적응력검사

 - 우리 대학 신입생들의 학교 적응도 파악 및 정신건강 위험군 선별에 매우 중요한 검사이므로, 검사와 추후 조치과정이 원활하게 진행되도록 학과 교수님과 조교 선생님의 협조 부탁드립니다.

  - 검사결과를 바탕으로 학교적응 또는 정신건강 위험군 학생을 선별하고, 학과에 자료를 전달하여 학생지도를 위한 정보를 제공해드릴 예정입니다. 또한, 위험군 학생들을 대상으로 본 센터 객원상담원과 함께 전문 심리상담과 집단상담을 진행할 예정입니다.

 * 학교적응력검사는 학생들의 학교 적응 및 정신건강 위험군 선별에 매우 중요한 검사이므로, 참여율을 높이기 위해 검사를 실시한 학생들 중 '10번째, 20번째, 30번째,· · · '로 실시한 학생들에게 스타벅스 기프티콘, '50번째, 100번째, 150번째,· · · '로 실시한 학생들에게 치킨 기프티콘을 증정할 예정입니다. 


2. 진로적성검사

  * 진로적성검사는 1학년 신입생의 효과적인 진로지도에 매우 중요한 검사이므로, 참여율을 높이기 위해 검사를 실시한 학생들 중 '10번째, 20번째, 30번째,· · · '로 실시한 학생들에게 베스킨라빈스 기프티콘, '50번째, 100번째, 150번째,· · · '로 실시한 학생들에게 피자 기프티콘을 증정할 예정입니다. 




엄현정 상담연구원
학생진로심리상담센터

부산시 연제구 고분로 170 부산경상대학교 창조관 1층 학생진로심리상담센터
Tel. 051.850.1373  E-mail. counsel@bsks.ac.kr

');

insert into noticeboard(writer, subject, reg_date, content, thumbnail)
values ('관리자', '부산경상대학교 제2회 메타버스 플랫폼을 활용한 랜드마크 콘텐츠 공모전', '2022-07-13 00:00:00', '제2회 메타버스 플랫폼을 활용한 랜드마크 콘텐츠 공모전

 
가. 공모주제 : 메타버스 플랫폼을 활용하여 대한민국을 소개할 수 있는 국내 지역 랜드마크 제작

※플랫폼 예시 : 로블록스, 제페토, 디토랜드 등

나. 응모자격 : 대한민국 중고생 및 대학생


다. 제출형식 : 메타버스 플랫폼을 활용하여 제작 후 화면 캡쳐 또는 녹화한 영상 파일

     ※영상 : 확장자 avi, wmv, mp4 등(1280*720 픽셀 이상, 3분 이내, 500MB 미만)

​라. 심사기준 : 주제적합성(20점), 표현력(30점), 작품설명(20점), 완성도(30점)


​마. 접수기간 및 발표

 

    - 접수기간 : 2022. 07. 11 ~ 2022. 08. 19

    - 수상작 발표 : 2022. 8. 31

※부산경상대학교 홈페이지 발표 및 수상자 개별 연락

  
바. 문의처 : 부산경상대학교 학교기업 앱버튼 / 컴퓨터정보메타버스게임과  

              jwchang@bsks.ac.kr/ 051-850-1287  / 051-850-1360


사. 시상내역

   - 금상(1명) : 아이패드 미니

   - 은상(2명) : 갤럭시탭S6

   - 동상(4명) : 갤럭시 와치4

* 접수인원 및 심사 결과에 따라 수상 인원 조정 가능함', 'metaverse.jpg');

insert into noticeboard(writer, subject, reg_date, content)
values ('관리자', 'notice test3', now(), 'notice test3');

-- insert into noticeboard(writer, subject, reg_date, content)
-- values ('111', '제목 test4', now(), '내용 test4');  --member 테이블에는 111이라는 테이블이 없으므로 insert into가 실행 안됨

select * from noticeboard order by num desc;	--외부키로 설정되어 있기때문에 삭제 불가능

delete from noticeboard where num=1;

select * 
from noticeboard 
order by num desc
limit 0,10; --시작번호, 검색할 레코드 수 // mysql은 0부터 시작

SET @count=0;
UPDATE noticeboard SET num=@count:=@count+1;
ALTER TABLE noticeboard AUTO_INCREMENT=0;