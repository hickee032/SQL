use mydb;

drop table if exists pivot;

create table pivot(
class char(2) not null,
subject char(5) not null,
jumsu int not null
);

desc pivot;

insert into pivot values("1반","국어",95);
insert into pivot values('1반','수학',80);
insert into pivot values('1반','영어',77);
insert into pivot values('1반','과학',95);
insert into pivot values('1반','사회',87);
insert into pivot values('2반','국어',56);
insert into pivot values('2반','수학',88);
insert into pivot values('2반','영어',69);
insert into pivot values('2반','과학',100);
insert into pivot values('2반','사회',99);

insert into pivot values("1반","국어",88);
insert into pivot values('1반','수학',97);
insert into pivot values('1반','영어',66);
insert into pivot values('1반','과학',78);
insert into pivot values('1반','사회',80);
insert into pivot values('2반','국어',100);
insert into pivot values('2반','수학',99);
insert into pivot values('2반','영어',66);
insert into pivot values('2반','과학',88);
insert into pivot values('2반','사회',97);

select class,
		sum(if(subject='국어',jumsu,0)) as '국어',
        sum(if(subject='수학',jumsu,0)) as '수학',
        sum(if(subject='영어',jumsu,0)) as '영어',
        sum(if(subject='과학',jumsu,0)) as '과학',
        sum(if(subject='사회',jumsu,0)) as '사회',
        sum(jumsu) as '총합계'
from pivot
group by class;     

select *
 from emp;
 desc emp;
 
select *
	from dept;
    
-- 78    
select e.ename, e.hiredate
	from emp as e 
	inner join dept as d
    on e.deptNo = d.deptNo
    where d.deptNo = 10;
    
-- 79
select e.ename, d.dname
	from emp as e
    inner join dept as d
    on e.deptNo = d.deptNo
    where e.JOB = '과장';

-- 80
select e.ename, d.dname
	from emp as e
    inner join dept as d
    on e.deptNo=d.deptNo
    where e.job = '사원';

-- 81
select e.ename, e.sal ,e.job
		from emp as e
        inner join dept as d
        on e.deptNo = d.deptNo
        where d.loc = '인천' and e.job = '사원';

create table membertbl(
	id int not null,
    name varchar(20) not null,
    tel varchar(13) not null,
    address varchar(50) not null
);  

desc membertbl;    

insert into membertbl values(1, '김우성', '010-6298-0394', '송파구 잠실2동');
insert into membertbl values(2, '김태희', '010-9596-2048', '강동구 명일동');
insert into membertbl values(3, '하지원', '010-0859-3948', '강동구 천호동');
insert into membertbl values(4, '유재석', '010-3045-3049', '강남구 서초동');

drop table if exists worker;

create table worker(
number int not null,
irum varchar(20) not null,
hp varchar(13) not null,
location varchar(50)
);

desc worker;

insert into worker values(2, '김태희', '010-9596-2048', '강동구 명일동');
insert into worker values(3, '하지원', '010-0859-3948', '강동구 천호동');
insert into worker values(4, '유재석', '010-3045-3049', '강남구 서초동');
insert into worker values(5, '강호동', '010-2049-5069', '송파구 석촌동');
insert into worker values(10,'안성기', '010-3050-3049', '강남구 압구정동');

select *
from membertbl;

select *
from worker;

select *
	from membertbl 
    union all    
select *
	from worker 
    order by id;
-- 87 
select *
	from membertbl 
    union    
select *
	from worker 
    order by id
