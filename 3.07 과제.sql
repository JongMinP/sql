-- 집계 통계 문제

-- 문제 1

select max(salary) '최고임금' , min(salary) '최저임금' , max(salary) - min(salary) '최고임금 - 최저임금'
from salaries;

-- 문제 2

select date_format(max(hire_date),concat('%Y','년 ', '%m', '월 ' , '%d' , '일' ))
from employees;

-- 문제 3

select date_format(min(hire_date),concat('%Y','년 ', '%m', '월 ' , '%d' , '일' ))
from employees;


-- 문제 4
select avg(salary)
from salaries;

-- 문제 5

select max(salary) '최고', min(salary) '최저'
from salaries;

-- 문제 6
-- select period_diff(cast(now() as date),cast(min(birth_date) as date)) , min(birth_date)
-- from employees;


-- select cast(now() as date);
-- select period_diff(date_format(now(),'%Y') ,date_format(min(birth_date),'%Y'))
-- from employees;

-- select date_format(now(),'%Y') ;

select date_format(now(),'%Y') - date_format(max(birth_date),'%Y') 어린나이, 
	date_format(now(),'%Y') - date_format(min(birth_date),'%Y') 연장자  
from employees;

-- 조인 문제
-- 문제 1
select e.emp_no, concat(e.first_name,' ',e.last_name) 'name', salary
from employees e, salaries s
where e.emp_no = s.emp_no
order by salary desc;

-- 문제 2
select e.emp_no, concat(e.first_name,' ',e.last_name) 'name', t.title
from employees e, titles t
where e.emp_no = t.emp_no and t.to_date = '9999-01-01'
order by name asc;


-- 문제 3
select e.emp_no, concat(e.first_name,' ',e.last_name) 'name', d.dept_name 
from employees e, dept_emp de, departments d
where e.emp_no = de.emp_no
and de.dept_no = d.dept_no and de.to_date = '9999-01-01'
order by name asc;

-- 문제 4

select e.emp_no , concat(e.first_name,' ',e.last_name) 'name' , salary, t.title, d.dept_name 
from employees e, salaries s, titles t, dept_emp de , departments d
where e.emp_no = s.emp_no 
and e.emp_no = t.emp_no and e.emp_no = de.emp_no and de.dept_no = d.dept_no
and de.to_date = '9999-01-01'
order by name asc;

-- 문제 5

select e.emp_no , concat(e.first_name,' ',e.last_name) 'name'
from employees e, titles t
where e.emp_no = t.emp_no 
and t.from_date <> '9999-01-01' and t.title = 'Technique Leader';
 
-- 문제 6
select e.last_name , d.dept_name, t.title
from employees e, dept_emp de, departments d, titles t
where e.emp_no = de.emp_no
and de.dept_no = d.dept_no
and e.emp_no = t.emp_no
and e.last_name LIKE 'S%';


-- 문제 7
select distinct concat(e.first_name,' ',e.last_name) 'name', s.salary, t.to_date
from employees e, titles t , salaries s
where e.emp_no = t.emp_no
and e.emp_no = s.emp_no
and t.title = 'Engineer'
and s.salary >= 40000 and s.to_date = '9999-01-01'
order by salary desc;

-- 문제 8
select t.title , max(salary) sal
from employees e, titles t , salaries s
where e.emp_no = t.emp_no 
and e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and s.salary > 50000
group by t.title
order by sal desc;

-- 문제 9
select d.dept_no , d.dept_name , avg(s.salary) 'avg_sal'
from departments d , dept_emp de , employees e, salaries s
where d.dept_no = de.dept_no and de.emp_no = e.emp_no
and e.emp_no = s.emp_no and s.to_date = '9999-01-01'
group by d.dept_no
order by avg_sal desc;

-- 문제 10

select t.title ,avg(s.salary) 'avg_sal'
from employees e, titles t, salaries s
where e.emp_no = t.emp_no 
and e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
group by t.title
order by avg_sal desc;

-- 서브 쿼리

-- 문제 1

select count(*)
from employees e , salaries s
where e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and s.salary > (select avg(s.salary)
from salaries s where s.to_date = '9999-01-01');


-- 문제 2 
select d.dept_no,max(s.salary) 'sal'
from employees e, salaries s , dept_emp d
where e.emp_no = s.emp_no
and e.emp_no = d.emp_no
and s.to_date = '9999-01-01'
group by d.dept_no
order by sal desc;



-- 문제 3

select e.emp_no , concat(e.first_name,' ',e.last_name) 'name'  , s.salary
from (select d.dept_no 'dno' , avg(s.salary) 'sal'
from employees e, salaries s, dept_emp d
where e.emp_no = s.emp_no
and e.emp_no = d.emp_no
and s.to_date = '9999-01-01'
group by d.dept_no) a , employees e , salaries s, dept_emp d
where a.dno = d.dept_no 
and e.emp_no = d.emp_no
and e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and s.salary >a.sal;





-- 문제 4

select a.eno , a.name, b.managername, a.title , a.dno
from (select e.emp_no 'eno', concat(e.first_name,' ',e.last_name) 'name' ,t.title 'title', d.dept_no 'dno'
from employees e, dept_emp de , departments d, titles t
where e.emp_no = de.emp_no
and de.dept_no = d.dept_no
and de.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
and e.emp_no =t.emp_no) a, (select d.dept_no 'mdno', concat(e.first_name,' ',e.last_name) 'managername'
from employees e,titles t, dept_manager d
where e.emp_no = t.emp_no
and d.emp_no = t.emp_no
and d.to_date = '9999-01-01'
and t.title = 'Manager'
and t.to_date = '9999-01-01') b 
where a.dno = b.mdno;




-- 5

select e.emp_no, concat(e.first_name,' ',e.last_name) 'name',t.title ,s.salary
from dept_emp d , employees e, salaries s, titles t
where d.emp_no = e.emp_no
and e.emp_no = t.emp_no
and e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
and d.dept_no = (select de.dept_no
from employees e, dept_emp de , salaries s
where e.emp_no = de.emp_no
and e.emp_no = s.emp_no 
group by de.dept_no
having (round(avg(s.salary))) 
= (select round(max(a.sal))
from (select de.dept_no 'dno', avg(s.salary) 'sal'
from employees e, dept_emp de , salaries s
where e.emp_no = de.emp_no
and e.emp_no = s.emp_no
group by de.dept_no) a))
order by s.salary desc;




-- 6 //
select de.dept_no
from employees e, dept_emp de , salaries s
where e.emp_no = de.emp_no
and e.emp_no = s.emp_no 
group by de.dept_no
having (round(avg(s.salary))) 
= (select round(max(a.sal))
from (select de.dept_no 'dno', avg(s.salary) 'sal'
from employees e, dept_emp de , salaries s
where e.emp_no = de.emp_no
and e.emp_no = s.emp_no
group by de.dept_no) a);


-- 7 
select t.title
from employees e, salaries s, titles t
where e.emp_no = t.emp_no
and e.emp_no = s.emp_no 
group by t.title
having (round(avg(s.salary))) 
= (select round(max(a.sal))
from (select avg(s.salary) 'sal'
from employees e, titles t , salaries s
where e.emp_no = t.emp_no
and e.emp_no = s.emp_no
group by t.title) a);

-- 8  

select a.dname , a.name , b.mname, b.msal
from (select e.emp_no, d.dept_no 'dno', concat(e.first_name,' ',e.last_name) 'name', s.salary 'sal', ds.dept_name 'dname'
from employees e , salaries s , dept_emp d , departments ds
where e.emp_no = s.emp_no
and e.emp_no = d.emp_no
and ds.dept_no = d.dept_no
and s.to_date ='9999-01-01'
and d.to_date ='9999-01-01') a,
(select d.dept_no 'mdno', s.salary 'msal', concat(e.first_name,' ',e.last_name) 'mname'
from employees e,titles t, dept_manager d , salaries s
where e.emp_no = t.emp_no
and d.emp_no = t.emp_no
and e.emp_no = s.emp_no
and t.title = 'Manager'
and d.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
and s.to_date = '9999-01-01') b
where a.dno = b.mdno
and a.sal > b.msal;






