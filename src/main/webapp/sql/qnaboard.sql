drop table qnaboard;

create table qnaboard(
     num int not null primary key auto_increment,
     writer varchar(20) not null,     
     subject varchar(50) not null,
     passwd varchar(15) not null,
     reg_date datetime not null,
     readcount int default 0,
     content text not null,
     FOREIGN KEY(writer) REFERENCES member(id)	
);

--게시판 글은 member 테이블에 id가 있는 회원만 가능하도록 설정


insert into qnaboard(writer, subject, passwd, reg_date, content)
values ('aaa', '면접 관련 질문','1', now(), '모든  전형에서 자기소개서가 필수인가요??

입학 홈페이지에서는 신분증만 있으면 된다고 했습니다.');

insert into qnaboard(writer, subject, passwd, reg_date, content)
values ('bbb', '원서접수 문의','1', now(), '2022년 2월14일 전역예정인 현역 군인입니다.

혹시 2022년 수시 1차 넣고싶은데 원서접수는 인터넷접수로 가능하니 되는데 면접을 갈 수 없을거같은데 다른 방법은 없을까요?');

insert into qnaboard(writer, subject, passwd, reg_date, content)
values ('ccc', '자기소개서 작성 관련 질문','1', now(), '자기소개서를 전부 다 자필로 써도 괜찮을까요?');

insert into qnaboard(writer, subject, passwd, reg_date, content)
values ('ddd', '수시 원서 접수','1', now(), '검정고시 합격자로 일반고 전형으로 수시를 쓰려고 합니다.
근데 제가 기초생활수급자인데 일반고 전형으로 수시원서를 내면 면접을 보나요? 

그리고 자기소개서도 필요한지 궁금합니다!');

insert into qnaboard(writer, subject, passwd, reg_date, content)
values ('eee', '자기소개서 글자 수 제한','1', now(), '자기소개서에 고등학교와 학년 반을 적으라고 써져있는데 졸업생은 어떻게 적어야 할까요?  

또 글자 수 제한이 없다고 하는데 한바닥 넘어가도 되나요?');

insert into qnaboard(writer, subject, passwd, reg_date, content)
values ('fff', '면접 예상 질문','1', now(), '올해 예상면접 질문은 안나오나요? 

면접 준비해야되는데 질문을 못찾겠습니다.');

insert into qnaboard(writer, subject, passwd, reg_date, content)
values ('ggg', '장학금 관련','1', now(), '국가 유공자 장학금 대상이 본인 및 손, 자녀라고 되어있는데 저희 할아버지가 국가유공자(6.25 전사자는 아니시고 참전용사) 이십니다.

정말로 국가유공자 "손자"도 장학금 혜택을 받을 수 있는건지 궁금합니다.');

-- insert into qnaboard(writer, subject, reg_date, content)
-- values ('111', '제목 test4', now(), '내용 test4');  --member 테이블에는 111이라는 테이블이 없으므로 insert into가 실행 안됨

select * from qnaboard order by num desc;	--외부키로 설정되어 있기때문에 삭제 불가능

delete from qnaboard where num=13;

select * 
from qnaboard 
order by num desc
limit 0,10; --시작번호, 검색할 레코드 수 // mysql은 0부터 시작

SET @count=0;
UPDATE qnaboard SET num=@count:=@count+1;
ALTER TABLE qnaboard AUTO_INCREMENT=0;