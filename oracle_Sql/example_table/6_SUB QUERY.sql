--11/04
--서브쿼리
--쿼리문은 일반 적으로 select문 만을 지칭한다
--쿼리문(서브쿼리) 대체적으로 해석은 서브쿼리 먼저 한다
--서브쿼리 위치는 select 다음에 또는 from 다음에 위치하기도 하고 일반적으로는 where 문에 사용

/* 문법
select select_list
from table
where ex_operator > (select select_list from table --서브쿼리
                        where ex_operator); */

--메인쿼리
select ename, salary
from employee
where salary > (select salary from employee --서브쿼리
                where ename = '스콧');

/*
단일행 서브쿼리
서브쿼리의 결과가 하나
단일행 서브쿼리 - 비교연산자 (=,>,<,>=,<=,<>)
*/

--스콧과 동일한 부서의 사원
select ename, dno
from employee
where dno = (select dno from employee 
                where ename = '스콧');
                
/*
다중행 서브쿼리
서브쿼리의 결과가 여러개
다중행 비교 연산자 반드시 사용 (in,any, some, all, exists)

in 하나라도 일치 메인 쿼리의 비교조건이 '='로 비교할 경우
any , some 하나이상이 일치
all 모두 일치
exists 하나라도 존재하면 참
*/

--부서별로 최소급여를 받는 사원의 사원번호, 이름을 출력
select eno,ename
from employee
where salary in( select min(salary) from employee group by dno);

--equi
select e.eno,e.ename,d.dname,d.loc
from employee e,department d
where e.dno = d.dno and salary in( select min(salary) from employee group by dno);

--inner join
select e.eno,e.ename,d.dname,d.loc
from employee e inner join department d
on e.dno = d.dno
where salary in( select min(salary) from employee group by dno);

--join using
select e.eno,e.ename,d.dname,d.loc
from employee e join department d
using(dno)
where salary in( select min(salary) from employee group by dno);

/* any */
--하나 이상만 일치하면 참
-- '> any' 는 찾아진 값에대해서 하나라도 크면 참
--찾아진 값중 가장 작은 값 최소값보다 크면 참

--직급이 판매원이 아니면서 급여가 임의의 판매원보다 낮은사원
select eno,ename,job,salary
from employee
where salary < any(select salary from employee where job = '판매원') 
and job != '판매원';

/* ALL */
--메인 쿼리의 비교조건이 서브쿼리의 검색결과와 모든값이 일치하면 참
--'>ALL'은 모든 비교값보다 크냐 라고 묻는 것 최대값보다 크면 참

--직급이 판매원이 아니면서 직급이 판매원보다 급여가 적은 모든 판매원
select eno,ename,job,salary
from employee
where salary < all(select salary from employee where job = '판매원') 
and job != '판매원'

                

