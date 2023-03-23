-- 대용량 데이터를 쉽게 가져오는 방법
-- 아래와 같이 테이블을 먼저 만든다.
select *
from employees.employees;

desc employees.employees;
use sqldb;

create table testtbl4(
id int,
fname varchar(14),
lname varchar(16)
);
-- employees DB에 있는 employees테이블의 대용량 삽입을 한다
insert into testtbl4
	select emp_no,first_name,last_name
    from employees.employees;
    
select*
from testtbl4;  

desc testtbl4;
-- 테이블을 만들면서 바로 select를 이용하는 방법
create table testtbl5 (
	select emp_no,first_name,last_name
	from employees.employees
);

select*
from testtbl5; 

-- updatet 수정문
-- update set where  where조건절이 없으면 전부다 변경한다. 반드시 조심하자

select *
	from testtbl4
    where fname = 'kyoichi';
    
-- update 테이블명 set 바꿀것 where 조건    
update testtbl4
	set lname = '없음'
	where  fname = 'kyoichi';   
    
-- 하지만 간혹가다가 전체를 대상으로 update를 하는경우도 있다. 
-- 제품의 단가가 올랐던지 아니면 월급이 5%씩 인상되었던지 등등 이런경우는 
-- where절을 써주지 않아도 되는 것이다.
-- 아래는 단가를 일괄적으로 1.5배 올리는 쿼리문이다.
-- 먼저 조회를 해본후에 update를 하도록하자

select*
	from buytbl;

update buytbl
	set price = price*1.5;
-- delete문에서도 where가 없다면 모든 테이터를 삭제하는 것이다.
-- where조건절이 반드시 들어가는 것이 좋다
delete from testtbl4
	where fname = 'Aamer';

create table bigtbl1(select*
						from employees.employees);
create table bigtbl2(select*
						from employees.employees);
create table bigtbl3(select*
						from employees.employees);
 
-- drop은 테이블 흔적 까지 다 없애는 것이다. 절대 쓸일없다
drop table bigtbl1;
delete from bigtbl2 ;  
truncate table bigtbl3;  
desc bigtbl1;  

drop table if exists membertbl;
create table membertbl(
		select userid,name,addr
        from usertbl
        limit 3
        );
select *
 from membertbl;  
 
-- 테이블을 위와 같이 만들면 제약조건은 따로 복사가 안된다. 
-- 하여 아래와 같이 직접 제약조건을 설정해준다
desc membertbl; 
-- PK를 userid로 추가해주자
alter table membertbl
	  add constraint pk_membertbl primary key(userid);
-- 제약조건을 날리는 방법
alter table membertbl
	  drop primary key;

insert into membertbl values('BBK','비비코','미국');    
insert into membertbl values('SKJ','신미나','서울');
insert into membertbl values('CHUNLI','춘리','상해');

-- BBK를 제외하고 두개만 삽입하고 싶다. insert ignore into
insert ignore into membertbl values('BBK','비비코','미국');    
insert ignore into membertbl values('SKJ','신미나','서울');
insert ignore into membertbl values('CHUNLI','춘리','상해');

select *
 from membertbl;  
 
--  허나 duplicate key update문을 사용하면 pk의 내용을 덮어쓰게된다
--  절대로 현업에서는 사용하지 않는다 
 insert into membertbl values('BBK','비비코','미국')
	on duplicate key update name = '비비코',addr = '미국';