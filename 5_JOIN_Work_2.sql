--11/04

--JOIN 연습
--사원이름과 해당사원을 관리하는 관리차 출력 NULL값은 출력하지 않기
select e.ename,e1.ename
from employee e , employee e1
where e.manager = e1.eno;

select e.ename , e1.ename
from employee e inner join employee e1
on e.dno = e1.dno
where e.manager = e1.eno;

--ward 사원보다 입사일이 늦은 사원명 입사일 출력 - 입사일 기준 오름차순
select e.ename, e.hiredate
from employee e
where e.hiredate < (select hiredate from employee where ename = '워드')
order by hiredate desc;

select e.ename,e.hiredate
from employee e,employee e1
where e.hiredate < e1.hiredate and e1.ename = '워드'
order by hiredate;

--사원 이름과 해당 사원을 관리하는 관리자를 출력 null 포함
select e.ename , e1.ename
from employee e left outer join employee e1
on e.manager = e1.eno;

--사번 사원명 담당 업무 관리자 번호 부서번호 부서명
select e.eno, e.ename ,e.job,e.manager,e.dno,d.dname
from employee e left outer join department d
on e.dno = d.dno
order by dno;

select e.eno, e.ename ,e.job,e.manager,e.dno,d.dname
from department d left outer join employee e
on e.dno = d.dno
order by dno;

select e.eno, e.ename ,e.job,e.manager,e.dno,d.dname
from employee e right outer join department d
on e.dno = d.dno
order by dno;

select e.eno, e.ename ,e.job,e.manager,e.dno,d.dname
from department d right outer join employee e
on e.dno = d.dno
order by dno;

select e.eno, e.ename ,e.job,e.manager,e.dno,d.dname
from employee e inner join department d
on e.dno = d.dno
order by dno;

select e.eno, e.ename ,e.job,e.manager,e.dno,d.dname
from department d inner join employee e
on e.dno = d.dno
order by dno;


select e.eno, e.ename ,e.job,e.manager,e.dno,d.dname
from employee e left outer join department d
on e.dno = d.dno
order by dno;