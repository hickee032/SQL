--11/04
--서브쿼리 연습문제

--사원번호가 7788인 사원과 담당업무가 같은사원 출력 - 사원명 담당 업무
select ename ,job
from employee
where job = (select job from employee where eno = 7788);

--사원번호가 7499 보다 급여가 많은 사원의 사원명 담당업무 급여
select ename ,job,salary
from employee
where salary > (select salary from employee where eno = 7499);

--최소, 최대 급여를 받는 사원명 급여 부서번호
select ename,salary,dno
from employee
where salary = ((select min(salary) from employee)) or (salary = (select max(salary) from employee));
--각 부서의 최소 급여를 받는 사원명 급여 부서번호
--각 부서의 최소 급여를 받는 사원명 급여 부서번호 부서명 근무지
select e.ename, e.salary, d.dno,d.dname,d.loc
from employee e inner join department d
on e.dno = d.dno
where salary = any(select min(salary) from employee group by dno);

--담당 업무가 분석원인 사원보다 급여가 적으면서 분석원이 아닌 사원의  사번 사원명 담당업무 급여
select eno,ename,job,salary
from employee
where salary < any(select salary from employee where job = '분석원') and job != '분석원';

--직속상관이 없는 직원을 출력
select ename
from employee
where eno = (select eno from employee where manager is null);

--직속상관이 없는 직원 부서명 근무지 출력
select e.ename,d.dname,d.loc
from employee e inner join department d
on e.dno = d.dno
where e.eno = (select eno from employee where manager is null);

-- 스콧과 동인한 부서에서 근무하는 사원 명 부서번호 
select ename, dno
from employee
where dno in (select dno from employee where ename = '스콧');


-- 스콧과 동일한 부서에서 근무하는 사원 명 부서번호 부서명 근무지역 
--equi
select e.ename, d.dno, d.dname,d.loc
from employee e , department d
where e.dno = d.dno and e.dno in (select dno from employee where ename = '스콧');

--inner join
select e.ename, d.dno,d.dname, d.loc
from employee e inner join department d
on e.dno = d.dno
where e.dno in (select dno from employee where ename in('스콧'));

--JOIN using 
select e.ename,dno,d.dname,d.loc
from employee e join department d
using(dno)
where dno in (select dno from employee where ename in('스콧'));

--NATUAL JOIN
select e.ename,dno,d.dname,d.loc
from employee e NATURAL join department d
where dno in (select dno from employee where ename in('스콧'));























