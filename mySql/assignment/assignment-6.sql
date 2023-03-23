use mydb;

select *
	from emp;
    
-- 문제87    
select a.ename as "이름",a.job as '직책', b.ename as '상관' ,b.job as '직책'
	from emp as a
    inner join emp as b
    on a.mgr = b.empno
    where a.job = '사원';

select *
	from dept;
    
-- 문제88
select a.ename as '이름',  d.dname as '부서명'
	from emp as a
    inner join dept as d
    on a.deptno = d.deptno
    where a.ename = '이문세';

drop table if exists dept01;

-- 문제89
create table dept01(
deptno int not null primary key,
dname varchar(14) not null,
location varchar(13) not null
);   

desc dept01;  

-- 문제90
insert into dept01 values(10,"경리부","서울");
insert into dept01 values(20,"인사부","인천");

-- 문제91

drop table if exists dept02;
create table dept02(
deptno int not null,
dname varchar(14) not null,
location varchar(13) not null,
foreign key (deptno) references dept01(deptno)
);
desc dept02;

-- 문제 92

insert into dept02 values(10,"경리부","서울");
SET FOREIGN_KEY_CHECKS = 0; -- 제약 조건 외래키 잠시 죽이기 
-- ignore는 무시하고 들어간다.
insert ignore into dept02 values(30,"영업부","용인");

select *
 from dept02;
 
 select *
 from dept01;

-- 문제93
select d1.*
	from dept01 as d1
    inner join dept02 as d2
    on d1.deptno = d2.deptno;

-- 문제94
select d1.*
	from dept01 as d1
    left outer join dept02 as d2
    on d1.deptno = d2.deptno;
    
-- 문제95 
select d2.*
	from dept01 as d1
    right outer join dept02 as d2
    on d1.deptno = d2.deptno;


select *
 from dept;
 
select *
 from emp; 
 
-- 문제 96
select d.dname as '부서명', d.loc as '지역', count(e.deptno) as '사원수' , truncate(avg(e.sal),-1) as '평균 급여'
	from dept as d
    left outer join emp as e
    on d.deptno = e.deptno
    group by d.dname;

-- 문제97
select empno, ename, job, case
	when job="부장" then round(sal+sal*0.05,-1)
    when job="과장" then round(sal+sal*0.1,-1)
    when job="대리" then round(sal+sal*0.15,-1)
    when job="사원" then round(sal+sal*0.2,-1)
    end as '급여'
    from emp;
    
select *
from emp;    

-- 문제98
drop procedure if exists deptname_if_proc;
 delimiter //
create procedure deptname_if_proc() 
	begin
		declare dno int;
        declare bname varchar(10);
        
		select deptno into dno
		 from emp
		 where empno = 1001;
		 
         select dname into bname
         from dept 
         where deptno = dno;
			
         -- if dno is not null then
         select dno as '사원번호', bname as '부서';
       --   end if ; 
		end //
delimiter ;   

call deptname_if_proc();

-- 문제99
drop procedure if exists yearsal_if_else_proc;
delimiter //
create procedure yearsal_if_else_proc(in empname varchar(10))
begin
declare iname varchar(10);
declare msal int;
declare ysal int;
declare bonus int;

set iname = empname;

select comm into bonus
from emp
where ename = empname;


select sal into msal
from emp
where ename = empname;

if bonus is null then
set bonus = 0;
end if;

set ysal = (msal*12)+bonus;
select iname, ysal, msal, bonus;
end //
delimiter ;

call yearsal_if_else_proc('김사랑');

select *
 from emp;

         
-- 문제100
-- 문제 101
select *
from emp;  

drop procedure usp_emp;
delimiter //
create procedure usp_emp()  
begin

select empno as '사원번호', ename as '이름',sal as '월급', comm as '보너스', deptno as '부서번호'
 from emp
 where comm is null
 order by empno,ename,sal,comm,deptno asc;

end //
delimiter ;

call usp_emp();

    