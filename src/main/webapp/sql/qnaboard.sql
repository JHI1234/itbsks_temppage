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
values ('aaa', 'qna test1','1234', now(), '내용 test1');

insert into qnaboard(writer, subject, passwd, reg_date, content)
values ('aaa', 'qna test2','1234', now(), '내용 test2');

insert into qnaboard(writer, subject, passwd, reg_date, content)
values ('bbb', 'qna test3','1234', now(), '내용 test3');

-- insert into qnaboard(writer, subject, reg_date, content)
-- values ('111', '제목 test4', now(), '내용 test4');  --member 테이블에는 111이라는 테이블이 없으므로 insert into가 실행 안됨

select * from qnaboard order by num desc;	--외부키로 설정되어 있기때문에 삭제 불가능

delete from qnaboard where num=13;

select * 
from qnaboard 
order by num desc
limit 0,10; --시작번호, 검색할 레코드 수 // mysql은 0부터 시작