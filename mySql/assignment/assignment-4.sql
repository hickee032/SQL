use mydb;
drop table if exists emp;

-- 문제15
create table emp (
EMPNO int not null primary key,
ENAME varchar(20) not null,
JOB varchar(8) not null,
MGR varchar(10),
HIREDATE date not null,
SAL int not null,
COMM int ,
DEPTNO int not null,
foreign key(DEPTNO) references dept(deptNO)
);

insert into emp values(1001, '김사랑', '사원', 1013, '2007-03-01', 300,NULL, 20 );
insert into emp values(1002, '한예슬', '대리', 1005, '2008-10-01', 250,  80, 30);
insert into emp values(1003, '오지호', '과장', 1005,'2005-02-10', 500,  100, 30);
insert into emp values(1004, '이병헌', '부장', 1008, '2003-09-02', 600, NULL, 20);
insert into emp values(1005, '신동협', '과장', 1005, '2010-02-09', 450,  200, 30);
insert into emp values(1006, '장동건', '부장', 1008, '2003-10-09', 480, NULL, 30);
insert into emp values(1007, '이문세', '부장', 1008, '2004-01-08', 520, NULL, 10);
insert into emp values(1008, '감우성', '차장', 1003, '2004-03-08', 500,  0, 30);
insert into emp values(1009, '안성기', '사장', NULL, '1996-10-04', 1000, NULL, 20);
insert into emp values(1010, '이병헌', '과장', 1003, '2005-04-07', 500, NULL, 10);
insert into emp values(1011, '조향기', '사원', 1007, '2007-03-01', 280, NULL, 30);
insert into emp values(1012, '강혜정', '사원', 1006, '2007-08-09', 300, NULL, 20);
insert into emp values(1013, '박중훈', '부장', 1003, '2002-10-09', 560, NULL, 20);
insert into emp values(1014, '조인성', '사원', 1006, '2007-11-09', 250, NULL, 10);

desc emp;
select *
   from emp;
    
-- 문제16
create table salgrade(
GRADE int not null primary key auto_increment,
LOSAL int not null,
HIsal int not null
);

insert into salgrade values(null,700,1200);
insert into salgrade values(null,1200,1400);
insert into salgrade values(null,1700,2000);
insert into salgrade values(null,2000,3000);
insert into salgrade values(null,3000,9999);

describe salgrade;
select*
   from salgrade;
 
 select*
   from dept;

-- 문제19
select ENAME,SAL,HIREDATE
   from emp
      where DEPTNO = any(select deptNO
                        from dept);
                                
-- 문제20
 select deptNo as '부서번호',dName as '부서명'
         from dept;                                

-- 문제21
select distinct JOB
   from emp;

-- 문제22
select *
   from emp
      where SAL <= 300;
        
-- 문제23    
select EMPNO, ENAME ,SAL
   from emp
      where ENAME="오지호";
        
-- 문제24
select*
   from emp
      where SAL in(500,300,250);
select*
   from emp
      where SAL=500 or SAl=300 or SAL=250;         
        
-- 문제25
select*
   from emp
      where SAL not in(500,300,250);    
select*
   from emp
      where SAL!=500 and SAl!=300 and SAL!=250;          

-- 문제26
select EMPNO, ENAME
   from emp
      where ENAME like '%기%' or ENAME like '김%';
        
-- 문제27        
select *
   from emp
      where MGR is NULL;

-- 문제28
select *
   from emp 
      where SAL >500 and deptno = any(select DEPTNO from emp where SAL >500);
        
-- 문제29      
-- 1.건수 확인
select count(*)
   from emp;
-- 2.copy Table
create table emp_copy (
EMPNO int not null primary key,
ENAME varchar(20) not null,
JOB varchar(8) not null,
MGR varchar(10),
HIREDATE date not null,
SAL int not null,
COMM int ,
DEPTNO int not null,
foreign key(DEPTNO) references dept(deptNO)
);

select*
   from emp_copy;

insert into emp_copy (select * from emp);

drop table if exists emp_copy;

select count(*)
   from emp_copy;

-- 문제30
select ENAME, SAL, JOB
   from emp_copy
      where SAL>(select min(SAL) from emp_copy where  JOB='과장') and JOB!='과장'; 

select *
 from emp_copy;
-- 문제31
update emp_copy
   set sal=sal+100
      where deptno=(select deptno from dept where loc='인천');
        
-- 문제32        
delete
   from emp_copy
      where deptno=(select deptno from dept where dname='경리부');
-- 문제33
select *
   from emp_copy
      where JOB=(select JOB from emp_copy where ename='이문세');

-- 문제34
select ENAME,SAL
   from emp_copy
      where SAL >=(select SAL from emp_copy where ename= '이문세');
        
-- 문제35
select ENAME,DEPTNO
   from emp_copy
      where deptno=(select deptno from dept where loc='인천');
        
-- 문제36
select ENAME,SAL,DEPTNO 
   from emp_copy
      where deptno=any(select distinct deptno from emp_copy where sal >500);

-- 문제37
select ENAME,SAL
   from emp_copy
       where SAL >(select max(sal) from emp_copy where deptno=30);
-- 문제38
select ENAME,SAL
   from emp_copy
      where SAL>(select min(sal) from emp_copy where deptno=30);
-- 문제39
select  max(sal), min(sal),sum(sal),avg(sal)
   from emp_copy;
-- 문제40  
select max(sal), min(sal),sum(sal),avg(sal)
   from emp_copy
    group by deptno;
    
-- 문제41
select count(*)    
   from emp_copy
    group by deptno;
    
-- 문제42
select count(*)
   from emp_copy
      where JOB='과장';
-- 문제43
select max(sal)-min(sal)
   from emp_copy;
-- 문제44
select JOB,min(sal)
   from emp_copy
      group by JOB
         order by sal;
-- 문제45
select deptno,JOB,count(*), avg(sal)
   from emp_copy
    group by JOB;
-- 문제46
select deptno, max(sal),min(sal)
      from emp_copy
        group by deptno;
-- 문제47
select deptno,count(*),count(Comm)
 from emp_copy
 group by deptno , comm is not null;
 
 -- 문제48
 select deptno, avg(sal)
   from emp_copy
    where deptno=(select deptno from emp_copy group by deptno having avg(sal)>500)
    group by deptno;
    
-- 문제49
 select deptno, max(sal),min(sal)
  from emp_copy
  where deptno=any(select deptno from emp_copy group by deptno having max(sal)>500)
  group by deptno;
 
 -- 문제50
 select deptno,empno,sum(sal)
   from emp_copy
   group by deptno,empno
   with rollup;

-- 문제51
 select deptno,JOB,sum(sal)
   from emp_copy
   group by deptno,JOB
   with rollup;
   
   select*
    from dept;
-- 문제52
select ename, hiredate
	from emp_copy
	where substring(hiredate,6,2)=09;
    
-- 문제53
select ENAME,hiredate
	from emp_copy
    where substring(hiredate,1,4)=2003; 
    
-- 문제54
select ENAME 
		from emp_copy
        where substring(ename,3,1) = '기';
        
-- 문제55   
select abs(-44);
select abs(-77);
select abs(-100); 

-- 문제56
select cast('2015-09-01 11:22:44:777' as date);
-- 문제57
select cast('2015-09-01 11:22:44:777' as time);
-- 문제58
select floor(34.5678);
-- 문제59
select cast(27.8987 as signed integer);
select ceiling(27.8987);
-- 문제60
select round(19.6678,1);
-- 문제61
select round(24.4535,-1);
-- 문제62
select mod(78,3);
-- 문제63
select pow(15,4);
select sqrt(81);
-- 문제64
select floor(1+rand()*45-1);
-- 문제65
select truncate(34.667788,2);
-- 문제66
select lcase('Welcome to MySQL');
select ucase('Welcome to MySQL');
-- 문제67
select adddate('2017-10-5',30);
-- 문제68
select subdate('2017-10-5',30);
-- 문제69
select datediff(now(),'1987-03-20');
-- 문제70
select curdate();
select dayofyear(curdate());
-- 문제71
select last_day('2021-02-01');
-- 문제72
select time_to_sec('9:45');
-- 문제73
select  sleep(5) "열심히 하자";
-- 문제74
select now();
select quarter(now());
