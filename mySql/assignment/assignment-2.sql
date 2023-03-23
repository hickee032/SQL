use mydb;

create table emp(
deptNo int not null primary key,
deptName varchar(10) not null,
job varchar(5) not null,
sal int not null
);

-- 확인
describe emp;

insert into emp values(10,'인사팀','사원',250);
insert into emp values(20,'재무팀','대리',300);
insert into emp values(30,'법무팀','과장',350);
insert into emp values(40,'영업팀','사원',250);
insert into emp values(50,'설계팀','부장',500);

-- 확인
select *
	from emp;
    
-- 문제5
update emp
	set sal=180
    where job='사원';
-- 문제6
delete
	from emp
    where deptName='법무팀';
