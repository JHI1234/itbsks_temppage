drop table freeboard;

create table freeboard(
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

insert into freeboard(writer, subject, passwd, reg_date, content)
values ('aaa', 'freebrd test1', '1234', now(), 'freebrd test1');

insert into freeboard(writer, subject, passwd, reg_date, content)
values ('aaa', 'freebrd test2', '1234', now(), 'freebrd test2');

insert into freeboard(writer, subject, passwd, reg_date, content)
values ('bbb', 'freebrd test3', '1234', now(), 'freebrd test3');

-- insert into freeboard(writer, subject, reg_date, content)
-- values ('111', '제목 test4', now(), '내용 test4');  --member 테이블에는 111이라는 테이블이 없으므로 insert into가 실행 안됨

select * from freeboard order by num desc;	--외부키로 설정되어 있기때문에 삭제 불가능

delete from freeboard where num=3;

select * 
from freeboard 
order by num desc
limit 0,10; --시작번호, 검색할 레코드 수 // mysql은 0부터 시작