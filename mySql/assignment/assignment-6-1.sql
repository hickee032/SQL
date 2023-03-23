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
		declare dno int; -- 부서번호
        declare bname varchar(10); -- 부서명
        declare empno int; -- 사원번호
        set empno = 1001;
        
         select dname into bname
         from dept 
         where deptno = dno;
         
         select deptno 
		 from emp
		 where empno = 1001;
			
         -- if dno is not null then
         select dno;
       --   end if ; 
		end //
delimiter ;   
call deptname_if_proc();

-- 문제99
drop procedure if exists yearsal_if_else_proc;
delimiter //
create procedure yearsal_if_else_proc(in empname varchar(10))
begin
declare iname varchar(10); -- 김사랑
declare msal int; -- 월급 sal
declare ysal int;
declare bonus int; -- comm

set iname = empname; -- 김사랑

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

-- 문제102

drop procedure if exists gradeScore;
delimiter $$
create procedure gradeScore()
begin
	declare grade varchar(10);
	declare score int;
    set score = 77;
    
    if 95 <= score and score <= 100 then
		set grade = "A+";
    elseif 90 <=score and score <= 94 then
		set grade = "A";
    elseif 85 <=score and score <= 89 then
		set grade = "B+" ;   
    elseif 80 <=score and score <= 84 then
		set grade = "B";
    elseif 75 <=score and score <= 79 then
		set grade = "C+";
	elseif 70 <=score and score <= 74 then
		set grade = "C";
    elseif 65 <=score and score <= 69 then
		set grade = "C+"  ;  
    elseif 60 <=score and score <= 64 then
		set grade = "C";
    else
		set grade = "F";
        
  end if;  
		select score,grade;
  end $$
  delimiter ;
  
  call gradeScore();
 -- 103 
drop procedure if exists gradeScoreCase;
delimiter $$
create procedure gradeScoreCase()
begin
	declare grade varchar(10);
	declare score int;
    set score = 77;
    
    case
	when 95 <= score and score <= 100 then
		set grade = "A+";
    when 90 <=score and score <= 94 then
		set grade = "A";
    when 85 <=score and score <= 89 then
		set grade = "B+" ;   
    when 80 <=score and score <= 84 then
		set grade = "B";
    when 75 <=score and score <= 79 then
		set grade = "C+";
	when 70 <=score and score <= 74 then
		set grade = "C";
    when 65 <=score and score <= 69 then
		set grade = "C+"  ;  
    when 60 <=score and score <= 64 then
		set grade = "C";
    else
		set grade = "F";
        
  end case;  
		select "취득 점수는 "+ score,grade;
  end $$
  delimiter ;
  call gradeScoreCase();
  
select *
	from emp; 
    
-- 104
drop procedure avgsal;
delimiter //
create procedure avgsal()
begin
	declare eNO int;
    declare ena varchar(10);
    declare esal int;
	declare sa1 int;
    declare de int;
    declare gw int;
    declare bu int;
    declare cha int;
    declare sa int;
    set eNo = 1000;
    
    set sa1 = 0; -- 사원
    set de = 0; -- 대리
    set gw = 0; -- 과장
    set bu = 0; -- 부장
    set cha = 0; -- 차장
    set sa = 0; -- 사장

empwhile:while (eNo < 115) do   
	set eNO = eNo + 1;
    
    select job into ena
		from emp
        where eNO = EMPNO;
    
	select sal into esal
		from emp
        where eNO = EMPNO;
     
	if (job = "사원") then
      set sa1 = sa1 + esal;
	elseif (job = "대리") then
      set de = de + esal;
	elseif (job = "차장") then
      set cha = cha + esal;      
	elseif (job = "부장") then
      set bu = bu + esal;
    elseif (job = "과장") then
      set gw = gw + esal;
    else then
      set sa = sa + esal;
    end if;
end while;
	select 
end //

delimiter ;
-- 105  
drop procedure if exists SeasonCase;
delimiter $$
create procedure SeasonCase()
begin
	declare Season varchar(10);
	declare months int;
    set months = 5;
    
    case
	when months = 12 or months = 1 or months = 2   then
		set Season = "겨울";
	when months = 3 or months = 4 or months = 5   then
		set Season = "봄";
	when months = 6 or months = 7 or months = 8   then
		set Season = "여름";
	when months = 9 or months = 10 or months = 11   then
		set Season = "가을";   

  end case;  
		select months,Season;
  end $$
  delimiter ;
  call SeasonCase();
  
  -- 문제 106
drop procedure if exists calCase;
delimiter $$
create procedure calCase()
begin
	declare cal varchar(10);
	declare x int;
    declare y int;
    declare  result int; 
		set x = 10;
		set y = 5;
		set cal = "*";
    
    case
	when cal = "*"   then
		set result = x*y;
	when cal = "-"   then
		set result = x-y;
    when cal = "+"   then
		set result = x+y;
     when cal = "/"   then
		set result = x/y;

  end case;  
		select x,cal,y,result;
  end $$
  delimiter ;
  call calCase();
  
  -- 문제107
select substring('8703201328310', 7, 1);

drop procedure if exists peopleNOCase;
delimiter $$
create procedure peopleNOCase()
begin
	declare peopleNO varchar(20);
    declare Ynum int;
    declare message varchar(20);
		set peopleNO = "8703201328310";
        select substring('8703201328310', 7, 1) into Ynum;
    case
	when Ynum = 1   then
		set message = "1999년 이전에 태어난 남성";
	when Ynum = 2   then
		set message = "1999년 이전에 태어난 여성";
    when Ynum = 3   then
		set message = "2000년 이후에 태어난 남성";
     when Ynum = 4   then
		set message = "2000년 이후에 태어난 여성";

  end case;  
		select concat(peopleNO,"는",message);
  end $$
  delimiter ;
  call peopleNOCase();
  -- 문제 108
drop procedure if exists thousand;
delimiter $$
create procedure thousand()
begin
	declare Fno int;
    declare Lno int;
    declare Tno int;
    set Tno = 0;
    set Fno = 1;
    set Lno = 1000;
    TSwhile:while (Fno<Lno) do
    set Fno = Fno +1;
    if (Fno%2 = 0) and (Fno%3 = 0) then
		set Tno = Tno;
    else    
		set Tno = Tno +Fno;
    end if;
    end while;
    select Tno;
end $$;
	delimiter ;
call thousand();  

drop procedure if exists thousand1;
delimiter $$
create procedure thousand1()
begin
	declare Fno int;
    declare Lno int;
    declare Tno int;
    set Tno = 0;
    set Fno = 1;
    set Lno = 1000;
    TSwhile:while (Fno<Lno) do
    set Fno = Fno +1;
    if (Fno%7 = 0) or (Fno%9 = 0) then
		set Tno = Tno;
    else    
		set Tno = Tno +Fno;
    end if;
    end while;
    select Tno;
end $$;
	delimiter ;
call thousand();  

-- 110

drop procedure if exists jobCase;
delimiter $$
create procedure jobCase()
begin
	declare job varchar(20);
    declare sal varchar(20);
		set job = "차장";
    case
	when job = "상무"   then
		set sal = "1000만원";
    when job = "부장"   then
		set sal = "800만원";
	when job = "차장"   then
		set sal = "600만원";
    when job = "과장 "   then
		set sal = "400만원";
	when job = "대리 "   then
		set sal = "250만원";
    else
		set sal = "180만원";
  end case;  
		select concat(job," 의 월급은 ",sal,"입니다");
  end $$
	delimiter ;
  call jobCase();

