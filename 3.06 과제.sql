-- 1

select concat(first_name, ' ', last_name) '이름'
from employees
where emp_no = 10944;

-- 2

select concat(first_name, ' ', last_name) '이름',
gender '성별', hire_date '입사일'
from employees
order by hire_date asc; 

-- 3

select gender, (gender) '여직원 남직원 수'
from employees
group by gender;

-- 4

select count(*)
from salaries
where to_date >= now();

-- 5
select count(dept_no)
from departments;

-- 6
select count(*)
from dept_manager
where to_date >= now();


-- 7
select dept_name
from departments
order by length(dept_name) desc;


-- 8 
select count(*) '120000 이상받는사원'
from salaries
where salary >= 120000 and to_date >= now();

-- 9
select distinct title
from titles
order by length(title) desc;

-- 10
select count(*)
from titles
where title = 'Engineer' and to_date >= now();

-- 11
select title
from titles
where emp_no = 13250
order by to_date asc;


