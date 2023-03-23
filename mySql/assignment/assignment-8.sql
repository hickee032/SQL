drop database if exists mydb3;
create database mydb3;
use mydb3;


drop table if exists emp03;
create table emp03 (
	empno int,
    ename varchar(20) not null,
    job varchar(20),
    deptno int
);

-- 128 emp03테이블에 empno컬럼에 제약조건 unique를 추가 하시오
alter table emp03 add constraint empunique  unique key(empno);
desc emp03;
-- 129 아래 데이터를 emp03에 삽입하시오
insert into emp03 values(1000 ,"김주화", "사원", 30);
insert into emp03 values(1000 ,"이길동", "사원", 30);

-- 그러나 이길동을 입력할때 에러가 난다.
-- 에러 이유 : unique키는 null과 null의 중복을 허용하지만 다른 값의 중복은 허용하지 않는 다.
-- 해결방법은 2가지이다.
-- 첫번째 해결방법 : unique key의 값을 바꿔주는 방법
-- 두번째 해결방법 : alter 를 이용해 제약조건을 제거하는 방법

-- 130 첫번째 해결방법을 삽입쿼리로 해결하여 작성하시오
	insert into emp03 values(1001 ,"이길동", "사원", 30);	
-- 131 두번째 해결방법도 역시 alter table을 이용하여 해결하여 작성하시오
	drop index empunique on emp03;
    insert into emp03 values(1000 ,"이길동", "사원", 30);	
    select *
		from emp03;
    desc emp03;
-- 132 emp03테이블에 아래 컬럼을 추가하고 default 제약조건을 걸어 입력값이 없으면 서울로 나타내게 하시오    
	alter table emp03 add column location varchar(13) default "서울";
-- 133 아래 데이터를 emp03에 삽입하고 조회를 하여 location이 서울로 나오는지 직접 확인하시오.
	insert into emp03 values(1003, '신은비', '사원', 30);

-- 134 emp테이블의 데이터를 가지고 emp_copy 테이블로 복사를 하되 empno, ename, deptno컬럼들만으로 구성된 테이블을 만들어보자
	drop table if exists emp_copy;
    create table emp_copy(
		select empno, ename, deptno
			from emp
    );
    select *
		from emp_copy;
-- 135 뷰를 만드는데 emp_copy를 이용하자. 뷰이름은 emp_view30으로 한다
-- 만드는 조건은 부서번호가 30인 데이터만 가지는 뷰를 만들어보자. 또한 만든 뷰를 이용해서 데이터를 조회하여 보자
create or replace view emp_view30
as 
	select empno,ename,deptno 
	from emp_copy
	where deptno = 30;

select *
 from emp_view30;
 -- 136 emp_copy에 데이터를 저장을 emp_view30을 통해 추가해보자. 추가한후 뷰와 원래테이블의 데이터를 조회해보자
 insert into emp_view30 values(1111,'aaaa', 30);
 select *
 from emp_view30;
 select *
 from emp_copy;
 
  select *
 from dept;
 select *
 from emp_copy;
 -- 137 emp_copy테이블과 dept테이블을 inner join을 하는 emp_view_dept를 만들어보시오. 또한 그 뷰를 통해 조회를 해보시오
 create or replace view emp_view_dept
 as
	select e.deptno,e.empno,e.ename,d.dname,d.loc
    from emp_copy as e
    inner join dept as d
		on e.deptno = d.deptno;
select *
 from 	emp_view_dept;
 
 -- 138 뷰의 사용의 장점은 보안에 유리하다고 했습니다. 그럼 emp테이블에서 공개되지 말아야할 내용이 있습니다. 당연히 급여와 보너스가 되겠지요.
 -- 이 컬럼을 제외하는 emp_view를 만들어보세요
 desc emp;
 create or replace view emp_view
 as
	select empno,ename,job,mgr,hiredate,deptno
		from emp;
 select *
	from emp_view;
-- 139 문제135번에서 만든 emp_view30을 수정해보자. 기존의 뷰에 급여컬럼과 보너스컬럼을 추가해 emp_view30을 만드시오.
alter view emp_view30
as 
	select empno,ename,deptno,sal,comm 
	from emp
	where deptno = 30;	
select*
from  emp_view30;   
-- 140 emp_view30 뷰를 이용하여 급여가 600이상인 사람에 대해서 부서번호를 20으로 변경해보시오
update emp_view30
set deptno = 20
where sal >= 600;
select*
from  emp; 
-- 141 부서별 최대급여와 최소급여를 출력하는 sal_max_min_view를 emp,dept테이블을 이용하여 만들어보시오.
select *
	from dept;
create or replace view sal_max_min_view
as 
	select d.dname ,max(sal), min(sal)
     from emp as e
		inner join dept as d
			on e.deptno = d.deptNo
			group by d.dname; 

select *
from  sal_max_min_view; 

-- 테이블과 뷰 목록 불러오는 방법  
SHOW FULL TABLES IN mydb;        
-- 뷰 목록 불러오는 방법
SHOW FULL TABLES IN mydb WHERE TABLE_TYPE LIKE 'VIEW';
-- 뷰 삭제
drop view emp_view;
drop view emp_view30;
drop view emp_view_dept;
drop view sal_max_min_view;

     
