/*
   통상 sql은 아래와 같은 분류로 나뉜다.
   1. DML(Data Manipulation Language) : 데이터 조작어 ex)select, insert, delete, update 
      DML은 얼마든지 취소가능하다. rollback이란 키워드로 말이다.
   2. DDL(Data Definition Language)데이터 정의 언어 ex)CREATE, DROP, ALTER, TRUNCATE 
      취소불가 실행하면 바로 적용됨.
   3. DCL(Data Control Language)데이터 제어 언어 ex)GRANT, REVOKE, DENY
      사용자에게 어떤 권한을 부여하거나 빼앗을 때 주로 사용하는 구문
*/
use sqldb;

drop table if exists testtbl1;

create table testtbl1(
id int,
username varchar(5),
age int);
-- testtbl1테이블 만들고 insert into로 삽입
insert into testtbl1 values(1,'홍길동',25);

select*
from testtbl1;
-- insert할때 사용자가 원하는 필드만 넣어주고 싶을때
insert into testtbl1(id,username) values(2,'김연아');
-- 필드를 사용자 마음대로 설정해서 넣어줄수도 있다.
insert into testtbl1(username,age,id) values('초아',29,3);

-- auto_increment를사용하면 id가 int 형태로 자동증가 insert시 그필드 null을 넣어줘도 무방
drop table if exists testtbl2;
create table testtbl2(
id int auto_increment primary key,
username varchar(5),
age int 
);

insert into testtbl2 values(null,'지민',29);
insert into testtbl2 values(null,'강민',22);
insert into testtbl2 values(null,'은수',11);

select*
from testtbl2;
-- 직접 id값을 넣어주게되면 auto_increment는 적용 안된다
insert into testtbl2 values(9,'연수',11);

delete from testtbl2
	where id = 10;
    
-- auto_increment한 필드가 마지막으로 삽입된것을 조회할때는 last_insert_id()함수를 이용하면 편리하다.   
select last_insert_id();   

-- alter DDL 수정하다 - 테이블을 수정하고자 할때는 alter키워드를 사용하자
-- auto_increment 100씩 증가
alter table testtbl2 auto_increment =100; 
insert into testtbl2 values(null,'민수',21);

select*
from testtbl2;

drop table if exists testtbl3;
create table testtbl3(
id int auto_increment primary key,
username varchar(5),
age int 
);

-- 1000번째부터 auto_increment적용
alter table testtbl3 auto_increment = 1000;

insert into testtbl3 values(null,'지민',29);
insert into testtbl3 values(null,'강민',22);
insert into testtbl3 values(null,'은수',11);

select *
from testtbl3;

delete from testtbl3;

-- set @@는 서버변수라고 생각하자 
-- 이건 자동증가를 3씩 하게 설정하는 것이다 
set @@auto_increment_increment = 3;
insert into testtbl3 values(null,'지민',29);
insert into testtbl3 values(null,'강민',22);
insert into testtbl3 values(null,'은수',11);
