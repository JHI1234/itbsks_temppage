drop table reply;

create table reply(
     rnum int not null primary key auto_increment,
     rwriter varchar(20) not null,     
     reply varchar(500) not null,
     rreg_date datetime not null,
     ref int not null,
     FOREIGN KEY(rwriter) REFERENCES member(id),
     FOREIGN KEY(ref) REFERENCES qnaboard(num)
);


insert into reply(rwriter, reply, rreg_date, ref)
values ('admin', '안녕하세요.
컴퓨터정보융합과입니다.

자기소개서가 필요한 전형은 비교과전형만 필요합니다.
그외 전형은 고교생활기록부가 필요합니다.

기타 문의사항이 있으시면 언제든지 홈페이지 및 학과사무실(051-850-1266)로
문의 주시면 상세하게 안내드리도록 하겠습니다.
감사합니다. ', now(), 1);

insert into reply(rwriter, reply, rreg_date, ref)
values ('admin', '안녕하세요.

컴퓨터정보융합과입니다.

면접을 불참하였다고 불합격은 아닙니다.
원하신다면 수시1차 원서접수를 하시면 좋을것 같습니다.
그리고 유선상(051-850-1226)으로 자세하게 안내드리겠습니다.
(연락가능한 연락처도 통화로 알려주시면 전화드리겠습니다.)
', now(), 2);

insert into reply(rwriter, reply, rreg_date, ref)
values ('admin', '안녕하세요.

컴퓨터정보융합과입니다.

네, 자필로 써서 제출하셔도 무방합니다.

기타 문의사항이 있으시면 언제든지 홈페이지 및 학과사무실(051-850-1266)로
문의 주시면 상세하게 안내드리도록 하겠습니다.
감사합니다. 
', now(), 3);

insert into reply(rwriter, reply, rreg_date, ref)
values ('admin', '안녕하세요.

컴퓨터정보융합과입니다.

기초생활수급자와 관계없이 일반고 전형으로 수시 원서를 내주실 경우 면접고사(30%) 성적 반영이 되므로 면접을 진행하고, 
자기소개서는 비교과 전형외에는 필요하지 않습니다.

기타 문의사항이 있으시면 언제든지 홈페이지 및 학과사무실(051-850-1266)로
문의 주시면 상세하게 안내드리도록 하겠습니다.
감사합니다.
', now(), 4);

insert into reply(rwriter, reply, rreg_date, ref)
values ('admin', '안녕하세요.

컴퓨터정보융합과입니다.

졸업생의 경우 졸업 연도만 기재부탁드리며, 
자소서 글자 수의 제한은 없으므로 한 바닥이 넘어가도 무관합니다.

기타 문의사항이 있으시면 언제든지 홈페이지 및 학과사무실(051-850-1266)로
문의 주시면 상세하게 안내드리도록 하겠습니다.
감사합니다.
', now(), 5);

insert into reply(rwriter, reply, rreg_date, ref)
values ('admin', '안녕하세요.

컴퓨터정보융합과입니다.

올해 예상면접 질문의 경우, 지원하는 학과 사무실에 문의주시면 상세하게 안내해드리겠습니다.

기타 문의사항이 있으시면 언제든지 홈페이지 및 학과사무실(051-850-1266)로
문의 주시면 상세하게 안내드리도록 하겠습니다.
감사합니다.
', now(), 6);

insert into reply(rwriter, reply, rreg_date, ref)
values ('admin', '안녕하세요.

컴퓨터정보융합과입니다.

국가유공자 장학금일 경우, 만약 저희 대학에 합격하셨을 경우에 합격증을 가지고 국가유공자장학금 신청 기간에 보훈처로 가셔서 신청하시면 장학금이 지급됩니다.

기타 문의사항이 있으시면 언제든지 홈페이지 및 학과사무실(051-850-1266)로
문의 주시면 상세하게 안내드리도록 하겠습니다.
감사합니다.
', now(), 7);


select * from reply order by ref;
select * from reply;

delete from reply where 

SET @count=0;
UPDATE reply SET rnum=@count:=@count+1;
ALTER TABLE reply AUTO_INCREMENT=0;