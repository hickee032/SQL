create database mydb;

use mydb;

create table dept(
	deptNo int not null,
    dName varchar(14) not null,
    loc varchar(30),
    primary key(deptNo)
);

insert into dept values(10,"경리부","서울");
insert into dept values(20,"인사부","인천");
insert into dept values(30,"영업부","용인");
insert into dept values(40,"전산부","수원");

select*
from dept;

select*
from dept
where loc="수원";

describe dept;
desc dept;



