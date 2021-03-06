SELECT * FROM dev.pet;

desc student;
desc major;

insert into major
value(null,'컴퓨터공학과','');


insert into major
value(null,'토목공학과','');

insert into major
value(null,'철학과','');



select * from major;

desc student;

insert 
into student
values (null, '박종민','12-76024152',1);

insert 
into student
values (null, '총기번호','424602',2);


update student set major_no  = null
where no = 2;

select * 
from student;

-- inner join 조건에 맞는 애듣만 가져온다(교집합)
select a.name, a.sno , b.name
	from student a, major b
where a.major_no = b.no;

-- outer join
select * from major;
select * from student;
-- left join (왼쪽에 널인 값까지 출력), inner join 에서 빠진것을 포함
-- ifnull(컬럼,값) 널일시 값 출력
select a.name, a.sno, ifnull(b.name, '퇴학')
from student a
left join major b on a.major_no = b.no;

select (select count(*) major), (select count(*) student);
 






