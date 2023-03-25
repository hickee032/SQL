--11/03

--조인 join
--다른 테이블의 정보를 불러오고자 할떄
--여러개의 테이블에 저장된 데이터를 한꺼번에 조회할 필요성이 있을 경우
--교차 곱의 형태로 불러오게됨 (카디시안 곱)

--equi join (이퀴 조인 (내부조인) : 표준은 아님 오라클에서만)

select *from employee, department; -- 테이블이 하나로 합쳐진 형태(실제로 합쳐지진 않는다)

/* 문법
select table1.column,table2.column
from table1,table2
where table1.column1=table2.column2
*/

select *
from employee,department
where employee.dno = department.dno;

select employee.eno,employee.ename,department.dname,employee.dno
from employee,department
where employee.dno = department.dno and employee.eno =7788;

--테이블명에 별칭 사용할수도 있다
select e.eno,e.ename,d.dname,e.dno
from employee e,department d
where e.dno = d.dno and e.eno =7788;

--natural join
--중복된 값이 있으면 자동으로 걸러준다(중복 제거)
--중복된 값이 없으면 오류

/*
select table1.column,table2.column
from table1 natural join table2
*/

select e.eno,e.ename,d.dname,dno --마지막 칼럼이 만약 e.dno 를 쓰면 오류
from employee e natural join department d
where e.eno =7788;

--using 절에 조인이 되는 대상이 되는 컬럼을 지정

/*
select table1.column,table2.column
from table1 join table2
using(column);
*/

select e.eno,e.ename,d.dname,dno
from employee e join department d
using(dno)
where e.eno =7788;

--on : 임의의 조건을 지정하거나 조인할 칼럼을 지정

/*
select table1.column,table2.column
from table1 join table2
on table1.column1 = table2.column2;
*/

select e.eno,e.ename,d.dname,e.dno
from employee e join department d
on e.dno = d.dno
where e.eno =7788;

--non-equi join
--두 개의 테이블 간에 칼럼 값들이 서로 정확하게 일치하지 않는 경우
--where 절에 < , between A and B( = 조건이 아님) -> 연산자를 사용
select ename, salary ,grade
from employee,salgrade
where salary between losal  and hisal;

--3개의 테이블을 조인

select e.ename,d.dname,e.salary,s.grade
from employee e,department d ,salgrade s
where e.dno = d.dno
and salary between losal  and hisal;

--self join
--자신의 테이블과의 조인
--하나의 테이블에 있는 칼럼 끼리 연결해야하는 조인이 푤요한경우

select employees.ename as "사원이름",manager.ename as "상관이름"
from employee employees, employee manager
where employees.manager = manager.eno;

--outer join
--양측의 칼럼 값중의 하나가 NULL이지만 조인 결과로 출력 할 필요가 있을 경우

/*
select table1.column,table2.column
from table1, table2
where table1.column(+) = table2.column
또는
where table1.column = table2.column(+)
*/

select employees.ename ||'의 상관은 '||manager.ename
from employee employees join employee manager
on employees.manager = manager.eno(+);

--ANSI (표준)

--null 위치에 따라 왼쪽은 LEFT 오른쪽 ROGHT 
/*
select table1.column,table2.column
from table1 [LEFT,RIGHT,FULL] table2
on table1.column1 = table2.column2;
*/

--left outer join
select employees.ename ||'의 직속상관은 '||manager.ename
from employee employees left outer join employee manager
on employees.manager = manager.eno;





