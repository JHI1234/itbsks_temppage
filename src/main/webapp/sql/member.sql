drop table member;

create table member(
	id varchar(20) primary key,
	passwd varchar(20) not null,
	name varchar(20) not null,
	email varchar(40),
	reg_date datetime not null
);

insert into member
     values ('admin', 'admin', '관리자','admin@it.bsks.ac.kr', now());

insert into member
     values ('aaa', 'aaa', '정혜인','jhi1234@gmail.com', now());

insert into member
     values ('bbb', 'bbb', '홍길동','bbb5678@gmail.com', now());
     
insert into member
     values ('ccc', 'ccc', '이순신','ccc8910@gmail.com', now());
     
insert into member
     values ('ddd', 'ddd', '김길동','ddd1112@gmail.com', now());
     
insert into member
     values ('eee', 'eee', '고길동','eee1314@gmail.com', now());

insert into member
     values ('fff', 'fff', '한지우','fff1516@gmail.com', now());
     
insert into member
     values ('ggg', 'ggg', '이산','ggg1718@gmail.com', now());  
      

select * from member order by reg_date;