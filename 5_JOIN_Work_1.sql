--11/03 연습문제

--스콧 사원의 이름,부서번호, 부서이름 출력 (내부조인)
select e.ename, e.dno, d.dname
from employee e, department d
where e.dno=d.dno and e.ename = '스콧';

select e.ename, e.dno, d.dname
from employee e
inner join department d
on e.dno= d.dno
where e.ename = '스콧';

--사원명 부서명 지역명 출력

--내부 조인 표준,join~on ,join~using,equi 조인 4가지 방법
--내부 조인
select e.ename,d.dname,d.loc
from employee e inner join department d
on e.dno = d.dno;

--join~on
select e.ename, d.dname,d.loc
from employee e join department d
on e.dno = d.dno;

--join~using
select e.ename, d.dname,d.loc
from employee e join department d
using(dno);

--equi
select e.ename, d.dname,d.loc
from employee e ,department d
where e.dno = d.dno;

--이름에 A 가 들어간 모든 사원의 이름 부서명 출력 equi,natural

--equi
select e.ename, d.dname
from employee e,department d
where e.dno = d.dno and e.ename like '%스%';

select e.ename, d.dname
from employee e inner join department d
on e.dno = d.dno
where e.ename like '%스%';

select e.ename, d.dname
from employee e natural join department d
where e.ename like '%스%';

--커미션을 받는 사원명 부서명 근무지 equi,natural

select e.ename, d.dname ,d.loc
from employee e,department d
where e.dno = d.dno and e.commission is not null;

select e.ename,d.dname,d.loc
from employee e inner join department d
on e.dno = d.dno
where e.commission is not null and commission not in(0);

select e.ename, d.dname,d.loc
from employee e natural join department d
where e.commission is not null;

--뉴욕에 근무하는 모든 사원의 이름 업무 부서번호 부서명 equi,natural

select e.ename,e.job,e.dno,d.dname
from employee e,department d
where e.dno = d.dno and d.loc = '뉴욕';

select e.ename,e.job,e.dno,d.dname
from employee e inner join department d
on e.dno = d.dno
where d.loc = '뉴욕';

select e.ename,e.job,dno,d.dname
from employee e natural join department d
where d.loc = '뉴욕';
