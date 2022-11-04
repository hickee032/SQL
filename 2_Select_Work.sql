--select 문제

--급여가 2000이 넘는 사원의 이름과 급여를 급여가 많은 순으로 출력
select ename 사원명, salary 급여 from employee
where salary >2000
order by salary desc;

--모든 사원에 대해 급여 300을 인상하여 계산후 사원의 이름 급여 인상된 급여 출력
select ename 사원명, salary 급여, salary+300 인상급여
from employee;

--사원의 이름 급여 연간 총수입을 총수입이 많은 순으로 출력 +100
select ename 사원명, salary 급여, (salary*12)+100 연간총수입
from employee
order by 연간총수입 desc;

--사원의 이름 급여 연간 총수입을 총수입이 많은 순으로 출력
select ename 사원명, salary 급여, (salary*12) + NVL(COMMISSION,0) 연간총수입
from employee
order by salary desc;

--급여가 2000~3000사이에 포함되지 않는 사원
select * from employee
where salary not between 2000 and 3000;

--급여가 2000~3000사이에 포함되는 사원 2가지

select * from employee
where salary between 2000 and 3000;

select * from employee
where salary>2000 and salary<3000;

--1981/2/20~ 1982/5/1 입사한 사원의 이름 담당업무 입사일
select ename 사원명,job 담당업무, hiredate 입사일 from employee
where hiredate between '1981/2/20' and '1982/5/1';

--부서번호가 20~30에 속한 사원의 이름과 부서번호 이름기준 내림차순
select ename 사원명, dno 부서번호 from employee
where dno between 20 and 30
order by ename desc;

select ename 사원명, dno 부서번호 from employee
where dno in(20,30)
order by ename desc;

--사원의 급여가 2000~3000 사이에 포함되고 부서번호가 20 또는 30인 사원의 이름 급여 부서번호 이름기준 오름차순
select ename 사원명, salary 급여,dno 부서번호 from employee
where salary between 2000 and 3000 and dno between 20 and 30
order by ename;

select ename 사원명, salary 급여,dno 부서번호 from employee
where salary between 2000 and 3000 and (dno = 20 or dno = 30)
order by ename;

select ename 사원명, salary 급여,dno 부서번호 from employee
where (salary > 2000 and salary < 3000 )and (dno = 20 or dno = 30)
order by ename;

select ename 사원명, salary 급여,dno 부서번호 from employee
where salary between 2000 and 3000 and dno in(20,30)
order by ename;

--1981연도에 입사한 사원의 이름 입사일 like
select ename 사원명, hiredate 입사일 from employee
where hiredate >= '1981/01/01' and hiredate <= '1981/12/31';

select ename 사원명, hiredate 입사일 from employee
where hiredate like '%81%';

------------------------------------------------------------

select e.ename 사원명, d.dname 부서명 from employee e
inner join department d
on e.dno = d.dno
where salary between 2000 and 3000;

select *
from employee e
left join department d
on e.dno = d.dno
order by e.dno asc;

select e.ename 사원명,d.dname 부서명 ,d.loc 근무지,e.job 담당업무
from employee e
right join department d
on e.dno = d.dno
order by d.dname;

select *
from employee e
full join department d
on e.dno = d.dno;
