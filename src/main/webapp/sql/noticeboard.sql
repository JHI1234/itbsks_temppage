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

insert into noticeboard(writer, subject, reg_date, content, thumbnail)
values ('관리자', 'notice test1', now(), 'notice test1','img4.jpg');

insert into noticeboard(writer, subject, reg_date, content, thumbnail)
values ('관리자', 'notice test2', now(), 'notice test2', 'img5.jpg');

insert into noticeboard(writer, subject, reg_date, content, thumbnail)
values ('관리자', 'notice test3', now(), 'notice test3', 'img6.jpg');

-- insert into noticeboard(writer, subject, reg_date, content)
-- values ('111', '제목 test4', now(), '내용 test4');  --member 테이블에는 111이라는 테이블이 없으므로 insert into가 실행 안됨

select * from noticeboard order by num desc;	--외부키로 설정되어 있기때문에 삭제 불가능

delete from noticeboard where num=1;

select * 
from noticeboard 
order by num desc
limit 0,10; --시작번호, 검색할 레코드 수 // mysql은 0부터 시작