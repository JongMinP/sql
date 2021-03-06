select dept_no, dept_name from departments;

select * from employees;

select first_name '성', gender '성별', last_name '이름'
from employees;

-- 문자열 연결
select concat(first_name,' ',last_name) full_name
from employees;

-- 중복제거
select distinct title from titles; 

-- employees 테이블에서 1991년 이전에 입사한 직원의 이름, 성별, 입사일을 출력
select concat(first_name,' ',last_name) fullname ,gender
from employees
where  hire_date <'1991-01-01';


-- employees 테이블에서 1989년 이전에 입사한 여직원의 이름, 입사일을 출력
select concat(first_name,' ',last_name) fullname ,hire_date
from employees
where  hire_date <'1989-01-01' and gender = 'f'
order by hire_date desc;
-- dept_emp 테이블에서 부서 번호가 d005나 d009에 속한 사원의 사번, 부서번호 출력
select emp_no,dept_no
from dept_emp
where dept_no in ('d005','d009')
order by emp_no;

-- employees 테이블에서 1989년에 입사한 직원의 이름, 입사일을 출력  
select first_name, hire_date
from employees
where hire_date LIKE '1989%';

select first_name, hire_date
from employees
where hire_date between '1989-01-01' and '1989-12-31';

-- employees 테이블 에서 직원 전체이름 ,성별, 입사일 입사일 순으로

select first_name, gender, hire_date
from employees
order by hire_date asc, gender asc, first_name asc;

-- salaries 테이블에서 2001년 월급을 가장 높은순으로 사번, 월급순으로 출력

select emp_no, salary
from salaries
where from_date like '2001%'
order by salary desc;

-- 함수
select ucase('Seoul'), upper('seoul');
select lcase('Seoul'), lower('Seoul');

SELECT SUBSTRING('Happy Day',3,2);

SELECT concat( first_name, ' ', last_name ) AS 이름,
         hire_date AS 입사일
    FROM employees
   WHERE substring( hire_date, 1, 4);
   
SELECT LPAD('hi',5,'?'), LPAD('joe',7,'*'); 

-- 인저값을 문자타입으로 형변환 해야 한다.
SELECT emp_no, LPAD( cast(salary as char), 10, '*')      
  FROM salaries     
 WHERE from_date like '2001-%'       
   AND salary < 70000;

SELECT LTRIM(' hello '), RTRIM(' hello '); 
SELECT TRIM(' hi '),TRIM(BOTH 'x' FROM 'xxxhixxx');

-- trim은 공백 제거인데 특정 문자 제거 할 경우 LEADING FROM을 사용해서 지움
SELECT emp_no, 
       TRIM( LEADING '*' FROM LPAD( cast(salary as char), 10, '*') )        FROM salaries      
 WHERE from_date like '2001-%'          
   AND salary < 70000;


SELECT ABS(2), ABS(-2); 


SELECT MOD(234,10), 253 % 7, MOD(29,9); 

SELECT GREATEST(2,0),GREATEST(4.0,3.0,5.0),GREATEST("B","A","C"); 

select curdate(), current_date;
select curtime(), current_time;

-- now를 이용해서 글쓴 날짜를 넣는다.
-- now와 sysdate의 차이점
-- now는 쿼리가 시작되는 시간이 고정이 된다.
-- sysdate는 수행시간이 더해져서 실시간으로 바뀐다.
-- 많은 쿼리를 요청하는 경우 수행시간이 길어져 sysdate는 문제가 될수 있다.
select now(),sysdate();
-- 소문자 y 뒤에 두글자 년도, 대문자 M 영어 , 대문자 D 서수
select first_name, date_format(hire_date,'%Y-%m-%d')
from employees;

select date_format(now(),'%Y-%m-%d %h:%i:%s');

-- 각 직원들에 대해 직원이름과 근무개월수 출력 
select first_name, 
	   period_diff(date_format(curdate(),'%Y%m'),  
       date_format(hire_date,'%Y%d'))
from employees;

-- 각 직원들은 입사 후 6개월이 지나면 근무평가를 한다. 각직원들에 
-- 이름, 입사일, 최초 근무평가일은 언제인지 출력

-- 달에 6달 더하기 날짜 연산
select first_name,hire_date,
	date_add(hire_date,interval 6 month)
from employees;
-- now를 문자열로 캐스팅
select concat('----',cast(now() as date), '---');
-- now는 시간까지 다 표시
-- date는 날짜만 
select cast(now() as date);

-- salaries 테이블에서 사번이 10060인 직원의 급여 평균과 총합계를 출력
select avg(salary), sum(salary)
from salaries
where emp_no = 10060;

select * from salaries where emp_no = 10060;
select * from salaries order by to_date desc;


-- 이 예제 직원의 최저 임금을 받은 시기와
-- 최대 임금을 받은 시기를 각각 출력 해보세에ㅛ.

select * from salaries
where emp_no =10060
and
salary = (select max(salary) from salaries where emp_no =10060);


select a.emp_no, a.salary , a.from_date , a.to_date
from (select max(salary) m , min(salary) n from salaries where emp_no = 10060) s , salaries a
where a.salary IN (s.m,s.n);









