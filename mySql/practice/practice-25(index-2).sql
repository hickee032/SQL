-- index2
# 존재하지않으면 만들어라
create database if not exists testdb; 
use testdb;

drop table if exists mixedtbl;
create table mixedtbl(
userid char(8) not null,
name varchar(10) not null,
addr char(2)
);
insert into mixedtbl values ('LSG', '이승기', '서울');
insert into mixedtbl values ('KBS', '김범수', '경남');
insert into mixedtbl values ('KKH', '김경호', '전남');
insert into mixedtbl values ('JYP', '조용필', '경기');
insert into mixedtbl values ('SSK', '성시경', '서울');
insert into mixedtbl values ('LJB', '임재범', '서울');
insert into mixedtbl values ('YJS', '윤종신', '경남');
insert into mixedtbl values ('EJW', '은지원', '경북');
insert into mixedtbl values ('JKW', '조관우', '경기');
insert into mixedtbl values ('BBK', '바비킴', '서울');
# 위의 mixedtbl테이블에는 제약조건이 없다.
# 입력한 순서대로 출력 즉 인덱스가 없다

alter table mixedtbl
	add constraint PK_mixedtbl primary key (userid);
desc mixedtbl;
select*
from mixedtbl;   

alter table mixedtbl
	add constraint UK_mixedtbl_name unique(name);
    
show index from mixedtbl;

use sqldb;
select*
	from usertbl;
show index from usertbl;
show table status like 'usertbl';
show table status like 'buytbl';

# 보조인덱스를 생성 - 제약조건으로 보조인덱스를 잡으면 바로나온다. 하지만 create index로 하면 analyze table 를 해줘야 한다.
create index idx_usertbl_addr 
		on usertbl(addr);

analyze table usertbl;        
