drop table manager;


create table manager(
	id varchar(20) not null primary key,
	passwd varchar(20) not null
);

insert into manager
     values ('admin', 'admin');


select * from manager;