drop table gallery;

create table gallery(
     gnum int not null primary key auto_increment,
     gtitle varchar(100) not null,
     greg_date datetime not null,
     gimage varchar(100) default 'nothing.jpg'
);

insert into gallery(gtitle, greg_date, gimage)
values ('VR체험학습', '2020-06-12 14:04:00', 'img9.jpg');

insert into gallery(gtitle, greg_date, gimage)
values ('2020학년 하계방학 현장실습 안전교육', '2020-09-09 10:14:00', 'img10.jpg');

insert into gallery(gtitle, greg_date, gimage)
values ('베러먼데이코리아 주식회사 산학협력 협약식', '2021-08-23 15:49:00', 'img8.jpg');

insert into gallery(gtitle, greg_date, gimage)
values ('2021학년도 하계 앱버튼 현장실습 발표회', '2021-09-14 10:30:00', 'img7.jpg');

insert into gallery(gtitle, greg_date, gimage)
values ('DIY 4축 모션시뮬레이터','2021-09-29 00:20:00','img1.jpeg');

insert into gallery(gtitle, greg_date, gimage)
values ('일학습병행제 발표회', '2021-11-03 11:56:00', 'img2.jpg');

insert into gallery(gtitle, greg_date, gimage)
values ('메타버스 크리에이터 양성학과','2022-05-20 15:17:00', 'img3.jpg');

insert into gallery(gtitle, greg_date, gimage)
values ('제2회 메타버스 플랫폼을 활용한 랜드마크 콘텐츠 공모전', '2022-07-13 20:37:00', 'img4.jpg');

insert into gallery(gtitle, greg_date, gimage)
values ('컴퓨터정보융합과 졸업작품전시회 개최', '2022-12-08 19:21:00', 'img5.jpg');

insert into gallery(gtitle, greg_date, gimage)
values ('2023학번 신입생대상 전공체험 학습', '2023-01-02 15:46:00', 'img6.jpg');

select * from gallery;	