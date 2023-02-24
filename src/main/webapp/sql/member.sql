drop table member;

create table member(
	id varchar(20) primary key,
	passwd varchar(20) not null,
	name varchar(20) not null,
	email varchar(40),
	reg_date datetime not null
);

insert into member
     values ('aaa', 'aaa', '홍길동','abc123@gmail.com', now());

insert into member
     values ('bbb', 'bbb', '이순신','def567@gmail.com', now());
     
insert into member
     values ('ccc', 'ccc', '강감찬','ghi8910@gmail.com', now());
      

select * from member order by reg_date;