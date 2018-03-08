-- 1 from 2 where 3 group by 4 order by 5 select

-- 각 사원별로 평균연봉 출력
select avg(salary) 'avg_sal'
from salaries
group by emp_no
order by avg_sal desc;

-- 각 현재 Manager 직책 사원에 대한 평균 연봉은?


select avg(salary) 
from salaries 
where to_date = '9999-01-01' 
and emp_no IN (select emp_no
			   from dept_manager
				where to_date = '9999-01-01');
                
-- 사원별 몇 번의 직책 변경이 있었는지 조회
select max(cnt_title)
from(select emp_no, count(title) 'cnt_title'
	from titles
	group by emp_no) a;

-- 각 사원별로 평균연봉 출력하되 50,000불 이상인 직원만 출력
select emp_no, avg(salary)
from salaries
group by emp_no
having avg(salary) > 50000
order by avg(salary);

-- 현재 직책별로 평균 연봉과 인원수를 구하되 직책별로 인원이 
-- 100명 이상인 직책만 출력하세요.

select title, count(*) 
from titles
where to_date = '9999-01-01'
group by title
having count(*) > 1000;



-- employees 테이블과 titles 테이블를 join하여 직원의 이름과 직책을 모두출력 하세요.
-- 여성만 출력

-- equi join(*)
select concat(e.first_name ,' ',e.last_name) 'name' ,e.gender, t.title
from employees e , titles t
where e.emp_no = t.emp_no and t.to_date = '9999-01-01' and gender = 'F';

-- join ~ on (*)
select concat(e.first_name ,' ',e.last_name) 'name' ,e.gender, t.title
from employees e
join titles t on e.emp_no = t.emp_no
where t.to_date = '9999-01-01' and gender = 'F';

-- natural join
-- 컬럼 이름이 같으면 조인
-- 컬럼이 의도치 않게 같으면 자동 조인
select concat(e.first_name ,' ',e.last_name) 'name' ,e.gender, t.title
from employees e
natural join titles t;

-- join using
-- 같은 칼럼이 2개 이상 있을 경우 명시적으로 정해준다.
-- natural join의 단점 보완
select concat(e.first_name ,' ',e.last_name) 'name' ,e.gender, t.title
from employees e
join titles t using(emp_no);

-- 현재 회사 상황을 반영한 직원별 근무부서를  
-- 사번, 직원 전체이름, 근무부서 형태로 출력해 보세요.

select a.emp_no, concat(a.first_name,' ',a.last_name) 'name', c.dept_name
from employees a, dept_emp b, departments c
where a.emp_no = b.emp_no and b.dept_no = c.dept_no
and b.to_date = '9999-01-01';

-- 현재 회사에서 지급되고 있는 급여체계를 반영한 결과를 출력하세요.
-- 사번,  전체이름, 연봉  이런 형태로 출력하세요.    

select a.emp_no , a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no and b.to_date = '9999-01-01';

-- 현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 출력해보세요

select *
from employees a, dept_emp b
where a.emp_no = b.emp_no
and to_date = '9999-01-01'
and concat(first_name,' ', last_name) = 'Fai Bale';


select a.emp_no, a.first_name , c.dept_name
from employees a, dept_emp b, departments c
where a.emp_no = b.emp_no
and b.dept_no = c.dept_no
and b.dept_no = (select *
					from employees a, dept_emp b
					where a.emp_no = b.emp_no
					and to_date = '9999-01-01'
					and concat(first_name,' ', last_name) = 'Fai Bale');
                    

-- 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의  이름, 급여를 나타내세요.

select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no and to_date ='9999-01-01'
and b.salary < (select avg(salary)
				from salaries
				where to_date = '9999-01-01');

-- 현재 가장적은 평균 급여를 받고 있는 직책의 평균 급여를 구하세요 

select b.title, avg(a.salary) as 'avg_salary'
	from salaries a, titles b
	where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'  
	and b.to_date = '9999-01-01'
	group by b.title;

-- avg라서 소수점 차이가 나서 소수점 제거 해준다.
select b.title, round(avg(a.salary)) as 'avg_salary'
	from salaries a, titles b
	where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'  
	and b.to_date = '9999-01-01'
	group by b.title
	having avg_salary = round( (select min(avg_salary)
		from(select b.title, avg(a.salary) as 'avg_salary'
		from salaries a, titles b
		where a.emp_no = b.emp_no
		and a.to_date = '9999-01-01'  
		and b.to_date = '9999-01-01'
		group by b.title)a));

select min(avg_salary)
from(select b.title, avg(a.salary) as 'avg_salary'
	from salaries a, titles b
	where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'  
	and b.to_date = '9999-01-01'
	group by b.title)a;










