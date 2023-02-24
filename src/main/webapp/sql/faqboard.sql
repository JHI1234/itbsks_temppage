drop table faqboard;

create table faqboard(
     num int not null primary key auto_increment,
     writer varchar(20) not null,     
     subject varchar(50) not null,
     reg_date datetime not null,
     readcount int default 0,
     content text not null,
     FOREIGN KEY(writer) REFERENCES member(id)	
);

--게시판 글은 member 테이블에 id가 있는 회원만 가능하도록 설정

insert into faqboard(writer, subject, reg_date, content)
values ('admin', '컴퓨터정보융합과 입시Q&A 입니다.', '2022-01-30 00:00:00', '입학·입시와 관련없는 내용이 기재될 경우



사전에 통보없이 삭제 될 수 있음을 알려드립니다.



작성자분들은 주민번호 등 개인정보 노출에 주의하여 주십시오.



감사합니다.');

insert into faqboard(writer, subject, reg_date, content)
values ('admin', '[FAQ] 1. 원서접수 어디서 하나요?', '2022-01-30 00:00:00', '1. 원서접수 어디서 하나요?







A. 인터넷접수는 아래와 같습니다.



- 대학 자체 원서접수 및 방문접수 가능



- 대학 자체 홈페이지 (http://www.bsks.ac.kr/iphak/index.asp)



- 또는, 진학어플라이(http://www.jinhakapply.com)



- 또는, 유웨이어플라이(http://www.uwayapply.com)');

insert into faqboard(writer, subject, reg_date, content)
values ('admin', '[FAQ] 2. 원서접수 몇장까지 가능한가요?', '2022-01-30 00:00:00', '2. 원서접수 몇장까지 가능한가요?







A. 정원내 전형 최대 2장까지 쓰실 수 있습니다.



(정원외전형은 지원 자격만 충족되면 학과별, 전형별로 횟수제한 없이 복수지원 가능합니다.)');

insert into faqboard(writer, subject, reg_date, content)
values ('admin', '[FAQ] 3. 접수한 원서는 수정 가능한가요?', '2022-01-30 00:00:00', '3. 접수한 원서는 수정 가능한가요?







A. 원서접수 기간 중에는 가능하지만 원서접수 종료 후에는 불가합니다.



(학생직접수정 불가, 입시홍보실 별도문의:051-850-1004)');

insert into faqboard(writer, subject, reg_date, content)
values ('admin', '[FAQ] 4. 제출서류는 언제까지 내야하나요?', '2022-01-30 00:00:00', '4. 제출서류는 언제까지 내야하나요?





A. 원서접수 시 제출하시기 바라며, 원서접수 마감일이 제출서류 마감일입니다.');

insert into faqboard(writer, subject, reg_date, content)
values ('admin', '[FAQ] 5. 모집 기간은 언제인가요?', '2022-01-30 00:00:00', '5. 모집 기간은 언제인가요?





A. 각 전형별 모집요강 및 입학안내 페이지의 ☞전형일정을 확인해주시기 바랍니다. 변동이 있는 경우 입학 및 대학 홈페이지에 공지로 안내드립니다.

');

insert into faqboard(writer, subject, reg_date, content)
values ('admin', '[FAQ] 6. 고교졸업을 예전에 했는데도 지원가능한가요?', '2022-01-30 00:00:00', '6. 고교졸업을 예전에 했는데도 지원가능한가요?







A. 네, 가능합니다. 고교졸업을 예전에 하셔도 지원가능합니다.');

insert into faqboard(writer, subject, reg_date, content)
values ('admin', '[FAQ] 7. 원서접수 - 수능성적이 없는데 지원이 가능한가요?', '2022-01-30 00:00:00', '7. 원서접수 - 수능성적이 없는데 지원이 가능한가요?







A. 수능전형에는 지원할 수 없지만 내신(면접)만 반영하는 인문계전형, 전문계전형, 특기자전형에는 지원 가능합니다.



단, 수능전형은 2021학년도 수능응시자만 가능합니다.');


-- insert into qnaboard(writer, subject, reg_date, content)
-- values ('111', '제목 test4', now(), '내용 test4');  --member 테이블에는 111이라는 테이블이 없으므로 insert into가 실행 안됨

select * from faqboard order by num desc;	--외부키로 설정되어 있기때문에 삭제 불가능

delete from faqboard where num=13;

select * 
from faqboard 
order by num desc
limit 0,10; --시작번호, 검색할 레코드 수 // mysql은 0부터 시작

SET @count=0;
UPDATE faqboard SET num=@count:=@count+1;
ALTER TABLE faqboard AUTO_INCREMENT=0;