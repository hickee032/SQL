--11/03
--개인 연습

--밀러 보다 월급이 많은 사람 수 부서별로
select dno,count(*)
from employee
where salary > (select salary from employee where ename = '밀러')
group by dno
order by dno asc;

--클라크 보다 먼저 입사한 사람
select ename 
from employee
where hiredate <= (select hiredate from employee where ename = '클라크');

-- 부서번호,부서 이름, 지역명,사원수, 부서 부서내의 모든사원의 평균 급여출력 inner join
select d.dno 부서번호,d.dname 부서명 ,d.loc 근무지, count(*) 사원수 ,round(avg(salary)) "부서내 급여 평균"
from employee e
inner join department d
on e.dno = d.dno
group by d.dno,d.dname,d.loc;

---------------------------------------------------------------------------

--group by 연습문제

--각 부서에 대해서 부서 번호, 사원수, 부서내의 모든사원의 평균 급여를 부서별로 오름차 순으로 평균 급여는 반올림

select dno 부서번호 ,count(*) 사원수 ,round(avg(salary)) "평균 급여"
from employee
group by dno
order by dno;

--각 부서에 대해 부서번호,부서 이름 지역명,사원수, 부서 부서내의 모든사원의 평균 급여출력- 평균 급여 반올림 decode case
select dno 부서번호,
case when dno=10 then '회계'
     when dno=20 then '연구'
     when dno=30 then '판매'
     when dno=40 then '관리'
else '대기중'
end as 부서명,
case when dno=10 then '뉴욕'
     when dno=20 then '달라스'
     when dno=30 then '시카고'
     when dno=40 then '보스턴'
else '대기중'
end as 근무지,
count(*) 사원수 , round(avg(salary)) 평균급여
from employee
group by dno
order by dno;

--부서 번호,사원명, 사원수 부서별 인원의 소 합계, 모든 부서 인원 , 급여 총 합계 출력 rollup
select dno 부서번호 ,ename 사원명 ,count(*) 사원수 ,sum(salary) "급여 총 합계"
from employee
group by rollup(dno,ename) ;

--위 문제를 cube 사용
select dno,ename,count(*),sum(salary)
from employee
group by cube(dno,ename);

------------------------------------------------------------------------------------------------












