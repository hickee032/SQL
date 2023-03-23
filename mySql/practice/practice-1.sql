-- shop 데이터 베이스를 생성하겠다
-- cotrol shift enter 한줄만 실행

create database shopdb; -- 테이블 생성
-- drop database shopdb; 테이블 삭제
-- use 명령어는 ~를 사용하겠다.
use shopdb;

-- not null 널값을 허용하지 않겠다
-- char = 고정형 char(8) 8byte 3byte를 쓰더라도 8byte를 차지한다.
-- varchar = 비고정형 char(50) 50byte 10byte를 쓰더라도 10byte만 차지하고 나머지는 사라진다.

create table membertbl(
	memberID char(8) not null,
    memberName char(5) not null,
    memberAddress char(20),
    primary key(memberID)
);

insert into membertbl values ('shin','신동욱','');
insert into membertbl values('Dang','당탕이','경기도 부천시 중동');
insert into membertbl values('Jee','지운이','서울시 은평구 중산동');
insert into membertbl values('Han','한주연','인천 남구 주안동');
insert into membertbl values('Sang','상길이','경기 성남시 분당구');

select *
from membertbl;

create table producttbl(
	productName char(4) not null,
    cost int not null,
    makeDate date,
    company char(5) not null,
    amount int not null,
    primary key(productName)
);

-- 테이블의 상태 확인 
describe producttbl;
desc producttbl;

insert into producttbl values('컴퓨터',10,'2013-1-1','삼성',17);
insert into producttbl values('세탁기',20,'20140901','LG',3);
insert into producttbl values('냉장고',5,'2015-2-1','대우',22);

select *
 from producttbl;
 
 -- where 조건
 
--  select*
-- 	from 테이블 이름
--     where 조건
 
 -- membertbl 중 memberName이 지운이 인것만 들고와라
 select *
  from membertbl
  where memberName = '지운이';
  
  -- producttbl에서 amount가 10 초과 되는 것을 가져와라
  select*
  from producttbl
  where amount >10;