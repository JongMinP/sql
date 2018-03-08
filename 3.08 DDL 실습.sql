drop table member;

create table member(
	no integer not null primary key auto_increment,
    email varchar(200) not null,
    password varchar(20) not null,
	name varchar(25) null,
    department_name varchar(25) null
);

desc member;
-- member table 주민번호 컬럼 추가
-- after no no뒤에
-- first 맨앞에
alter table member add juminbunho char(14) not null after no;
alter table member drop juminbunho;
alter table member add join_date DATETIME not null;

-- change 키워드를 사용하면 칼럼을 새롭게 재정의 가능accessible
alter table member change password password char(64) not null;
-- member의 컬럼 deparment_name의 이름이  길어 dept_name으로 바꿀려고 합니다
alter table member change department_name dept_name varchar(25) null;
-- 테이블  member의 name 컬럼의 길이 제한을 10자로 줄이세요.
alter table member change name  name varchar(10) not null;

-- table 이름 변경
alter table member rename user;

desc user;

-- 데이터 삽입
-- password 함수를 사용함으로써 sql 바인딩 (암호화)
insert into user
values(null, '7921-1232','kickscar@gmail.com', password('12345') , '박종민', '시스템개발팀',sysdate());

select * from user;

select password('12345');


insert into user(juminbunho,email,password,name,dept_name,join_date)
values('7921-1232','kickscar@gmail.com', password('12345') , '박종민','시스템개발팀',sysdate());


insert into user(email,juminbunho,name,password,dept_name,join_date)
values('dooly@gmail.com','23132-2121', '둘리', password('둘리') , '시스템개발팀',sysdate());

-- 데이터 변경

update user 
	set name ='dooly' , password= password('123213123')
where no = 3;

delete 
from user
where no =2;







