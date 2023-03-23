drop database if exists mydb2;
create database mydb2;
use mydb2;

-- 111

drop table if exists employee;
create table employee (
	emp_no int, 
    emp_name varchar(20),
    salary int,
    birthday date
);

drop table if exists project;
create table project(
pro_no int,
pro_content varchar(20),
start_date date,
finish_date date
);

drop table if exists specialty;
create table specialty(
emp_no int,
specialty varchar(20)
);

drop table if exists assign;
create table assign(
emp_no int,
pro_no int
);

-- 112
alter table employee add constraint employee_pk primary key (emp_no);
show index from employee;
desc employee;
-- 113
alter table project add constraint project_pk primary key (pro_no);
show index from project;
desc project;
-- 114
alter table specialty add constraint specialty_pk primary key (emp_no,specialty);
show index from specialty;
desc specialty;
-- 115
alter table assign add constraint assign_pk primary key (emp_no);
show index from assign;
desc assign;
-- 116
alter table specialty add constraint specialty_fk foreign key (emp_no) references employee(emp_no);
show index from specialty;
desc specialty;
-- 117
alter table assign add constraint assing_project_fk foreign key (pro_no) references project(pro_no);
show index from assign;
desc assign;

-- 118
-- assign테이블에 외래키를 추가하고 확인해보시오.(emp_no를 외래키 설정)
alter table assign add constraint assing_employee_fk foreign key (emp_no) references employee(emp_no);
show index from assign;
desc assign;

-- 119
-- dept01 테이블을 생성하시오. 그리고 데이터를 삽입하시오
drop table if exists dept01;
create table dept01(
deptno int primary key,
dname varchar(14),
loc varchar(13)
);

insert into dept01 values(10, '경리부', '서울');
insert into dept01 values(20, '인사부', '인천');

-- 120
-- emp01테이블을 생성하시오. 그리고 데이터를 삽입하시오
drop table if exists emp01;
create table emp01(
empno int primary key,
ename varchar(10),
job varchar(13),
deptno int,
unique key Njob (job),
foreign key (deptno) references dept01(deptno)
);

desc emp01;

-- 1010데이터를 삽입할때 분명 에러가 발생한다.
-- 에러 발생 이유가 무엇인가? 해결 방법은 2가지이다.
-- > 외래키는 부모 테이블의 기본키와 같아야한다 하지만 여기서는 다르다 또한
-- > 유니크 키또한 중복이 된다 유니크 키는 널값은 허용하지만 중복허용하지 않는 키다.
-- 1번째 해결방법 : 제약 조건을 삭제하는 방법
-- 2번째 해결방법 : 삽입 데이터를 변경하는 방법

insert into emp01 values(1000, '허준', '사원', 10);
insert into emp01 values(1010, '홍길동', '사원', 50);
-- 121 첫번째 방법
alter table emp01 
	drop foreign key emp01_ibfk_1;
alter table emp01
	drop index Njob;
-- 122 두번째 방법  
SET UNIQUE_CHECKS = 0;
SET FOREIGN_KEY_CHECKS=0;
insert into emp01 values(1010, '홍길동', 'null', 50);
SET UNIQUE_CHECKS = 1;
SET FOREIGN_KEY_CHECKS=1;
-- 123
-- dept01테이블을 제거하시오
-- 분명 에러가 발생한다.
-- 에러 이유 : 자식 테이블이 참조하고 있는(외래키) 부모 테이블은 삭제가 불가능하다
-- 해결방법 :
-- 1.외래키를 죽이고 삭제하는 방법
-- 2.제약 조건을 삭제후 삭제
-- 해결방법 2가지가 있습니다.

-- 124
SET FOREIGN_KEY_CHECKS=0;
truncate dept01;
SET FOREIGN_KEY_CHECKS=1;

-- 125
alter table dept01 
	drop foreign key emp01_ibfk_1;
truncate dept01;
drop table emp01;
drop table dept01;

select*
	from dept01;    
select*
	from emp01;
