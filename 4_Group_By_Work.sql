--11/02
--연습문제

--select

--관리자가 없는 사원의 이름과 담당 업무 출력
select *
from employee
where manager is null;

--커미션을 받을수있는 사원의 이름과 급여 커미션 출력 --급여 커미션 내림차순
select ename , salary , commission
from employee
where commission is null or commission = 0
order by salary,commission;

--이름의 3번째 문자가 '스' 인 모든 사원명
select ename
from employee
where ename like '__스';

--이름에 '스'와 '아'를 모두 포함하는 사원
select ename
from employee
where ename like '%스%' and ename like '%아%';

--담당업무가 사무원 또는 영업사원 이면서 급여가 1600,950 1300이 아닌 사원의 이름 담당업무 급여
select ename ,job,salary
from employee
where (job ='사원' or job = '판매원') and salary not in(1600,950,1300);

--group by

--업무별로 급여 최고액 최저액 총액 평균액 출력 평균액 반올림
select max(salary), min(salary), sum(salary), round(avg(salary))
from employee
group by job;

--담당업무가 동일한 사원수 출력
select count(*)
from employee
group by job;

--직급별 사원의 최저 급여 출력 관리자를 알수없는 사원 및 최저급여가 2000 미만인 그룹은 제외 급여 내림차순

select job, min(salary) as 최저급여
from employee
where manager is not null
group by job
having min(salary) > 2000
order by 최저급여 desc;


select job, min(salary) as 최저급여
from employee
group by job, manager
having min(salary) > 2000 and manager is not null
order by 최저급여 desc;
