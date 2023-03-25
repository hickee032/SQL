--11/02_2

/*
데이터 그룹 GROUP BY
그룹의 결과 제한 HAVING 절

그룹함수 (그룹에 관련된 함수)

SUM 그룹의 누적합계
AVG 그룹의 평균
COUNT 그룹의 초 개수
MAX 그룹의 최대값
MIN 그룹의 최소값
*/

select sum(salary) as 급여총액,
    avg(salary) as 급여평균,
    max(salary) as 최대급여,
    min(salary) as 최소급여
from employee;

--소수점 처리
select sum(salary) as 급여총액,
    round(avg(salary)) as 급여평균, 
    max(salary) as 최대급여,
    min(salary) as 최소급여
from employee;

select sum(commission) as "커미션 총액"
from employee;

--count (여기서는 총 정보의 수)
select count(*) as "사원의 수"
from employee;

--distinct 중복방지 업무의 수
select count(distinct job) as "업무의 수"
from employee;

--오류발생
select ename, max(salary)
from employee;

select ename, max(salary)
from employee
group by ename;

--group by  : select dno 와 group by dno 일치

select dno "부서 번호" ,avg(salary) "급여 평균"
from employee
group by dno;

select dno "부서 번호" ,round(avg(salary)) "급여 평균"
from employee
group by dno;

--다중 컬럼을 사용해 그룹별로 검색
select dno, job,count(*),sum(salary)
from employee
group by dno,job
order by dno,job; --오름차순

--group by문에 조건
select dno, max(salary)
from employee
group by dno
having max(salary)>=3000;

---------------------------------------------------------
--연습
--group by

--부서인원이 4명보다 많은 부서의 부서번호, 인원수,급여의 합
select dno, count(*), sum(salary)
from employee
group by dno
having count(*) > 4
order by dno;

--모든 사원의 급여 최고액,최저액,총액,평균 급여 출력 (평균 값은 소수점 반올림 처리)
select ename ,max(salary),min(salary),sum(salary),round(avg(salary))
from employee
group by ename;

select max(salary),min(salary),sum(salary),round(avg(salary))
from employee;

select max(salary),min(salary),sum(salary),round(avg(salary))
from employee
group by dno;

--count 조건 

select count(case when job ='매니저' then 1 end) as "매니저의 수"
from employee;

select count(case when job ='사원' then 1 end) as "사원의 수"
from employee;

select count(case when 2000 < salary and salary <=3000  then 1 end) as "직원의 수"
from employee;

select job 직책, count(*) 부서별직원수 , sum(salary) 월급총합
from employee
group by rollup(job);
