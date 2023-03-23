use sqldb;
-- 앞에서 했던 sqldb에 usertbl을 drop을 하고 아무 제약조건을 주지않고 
-- 새로 생성해보자.
-- 하지만, 분명 외래키 제약조건때문에 drop을 안될 것이다.
-- 하여, buytbl을 먼저 제거하고 usertbl을 제거를 해야한다.
drop table if exists buytbl;
CREATE TABLE buytbl (
  num int AUTO_INCREMENT primary key,   -- 제약조건 PK하나 들어갔다.
  userID char(8),
  prodName char(6),
  groupName char(4),
  price int,
  amount smallint  
);

-- 외래키 제약 조건이 없으니 당연 drop이 잘 될 것이다. 그리고 새로 만든 테이블에는
-- 어떤 제약조건도 주지 않았다.
drop table if exists usertbl;
CREATE TABLE usertbl(
  userID char(8),
  name varchar(10),
  birthYear int,
  addr char(2),
  mobile1 char(3),
  mobile2 char(8),
  height smallint,
  mDate date,
  nation varchar(10) not null default 'KOREA'   -- default제약조건 추가
);
-- 데이터 삽입을 해보자.
-- 그런데, 잘못 삽입을 했다. 김범수는 생년월일을 몰라서 null로 추가했고, 
-- 김경호는 오타로 1871로 입력을 해버렸다.
-- 일단 삽입해보자. 잘 입력이 될것이다. 왜 ? 제약조건이 없으니깐.
INSERT INTO userTbl VALUES('LSG', '이승기', 1998, '서울', '011', '1111111', 182, '2008-8-8','USA');
INSERT INTO userTbl VALUES('KBS', '김범수', 1967, '경남', '011', '2222222', 173, '2012-4-4', default);
INSERT INTO userTbl VALUES('KKH', '김경호', 1871, default, '019', '3333333', 177, '2007-7-7', default);
INSERT INTO userTbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');

select *
  from usertbl;

truncate usertbl;

-- alter table을 이용한 default 제약조건 추가  
alter table usertbl
   alter column addr set default "서울";


INSERT INTO buyTbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
-- 현재 usertbl에는 아무런 제약조건이 없다. 하여 alter table쿼리로 
-- 기본키를 추가해보자. 그렇다고 not null은 추가할 필요가 없다.
-- PK를 추가하면 자동 not null이 따라붙는다.
alter table usertbl
   add constraint PK_usertbl_userid
    primary key (userid);

delete from buytbl
 where userid = "BBK";
 
alter table buytbl
   add constraint FK_usertbl_buytbl
    foreign key(userid) references usertbl(userid);
    
-- nation컬럼 삭제
alter table usertbl
   drop column nation;
    
show index from usertbl;

select * 
  from usertbl;

-- 자 근데, 먼저 buytbl에 외래키 설정을 해놓코도 아래와 같이 데이터를 삽입하고 싶다면
-- foreign key기능을 off시키는 방법이 있다.
-- off를 시키지 않으면 usertbl에 userid가 없는 것들은 데이터가 삽입이 안된다.
-- 하여 아래와 같은 방법으로 삽입을 한다.
-- 하지만, 아래와 같은 방법은 절대 권장하지 않는다.
-- 먼저 회원을 가입시켜야 그 회원이 물건을 사게 만들어야지 아무나 물건을 사면 이상하잖아 절차가 
-- 맞지 않는다는 것이다. 하여, usertbl에 먼저 회원 정보를 입력한 후 buytbl에 데이터를 넣는것이
-- 당연한 절차이다.
set foreign_key_checks = 0;   -- 외래키 체크기능 off
INSERT INTO buyTbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buyTbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buyTbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
set foreign_key_checks = 1;  -- 외래키 체크기능 다시 on, 이후 데이터 삽입시에 외래키 체크한다.
-- 다시 usertbl에 남은 데이터를 삽입한다.
INSERT INTO userTbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO userTbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO userTbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO userTbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO userTbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO userTbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');
-- 자, 아래 제약조건 추가는 ckeck제약조건이다. 즉, 1900이후의 값을 입력받으란 것이다.
-- 원래 오라클이나 mssql에는 check제약조건이 있다. 하지만, mysql에는 이러한 기능이 없다.
-- 하지만 이런 ckeck기능은 trigger로써 해결할 수 있으니 별문제가 없다.
-- 그냥 알아두기만 하자.
-- 5.7버전까지는 아래 기능이 추가가 되었지만 8.0버전에서는 아래 기능이 추가가 
-- 되지 않습니다.
-- alter table usertbl
-- add constraint CK_birthyear
-- check ( birthyear >= 1900 and birthyear <=  year(curdate()));

-- 아래 쿼리는 아시다시피 BBK를 VVK로 수정하라는 쿼리문이다.
-- 실행해보면 에러가 난다. 왜 외래키 제약 조건이 걸려있는 것이다.
update usertbl
   set userid = "VVK"
 where userid = "BBK"; 
 
-- 하지만 억지로 바꾸고 싶다면 위에서 배운 외래키체크를 해제하고 하면 된다.
set foreign_key_checks = 0;
update usertbl
   set userid = 'VVK'
  where userid = 'BBK';
set foreign_key_checks = 1;

-- 두 테이블을 조인하여 아래와 같이 결과를 도출하였다
-- 근데 분명히 buytbl은 데이터가 12건이 있었는데도 불구하고,
-- 8건이 조회가 되었다. 왜? BBK가 VVK로 바뀌었으니 당연히 결과 값이 안나올것이다.
select count(*)
  from buytbl;
select count(*)
  from usertbl;

select U.userid, U.name, B.prodname, U.addr, U.mobile1 + U.mobile2 as "연락처"
  from buytbl B
  inner join usertbl U
          on U.userid = B.userid;

select U.userid, U.name, B.prodname, U.addr, U.mobile1 + U.mobile2 as "연락처"
  from buytbl B
  left outer join usertbl U
          on U.userid = B.userid;

-- 원복을 시켜보자
set foreign_key_checks = 0;
update usertbl
   set userid = 'BBK'
  where userid = 'VVK';
set foreign_key_checks = 1;

alter table buytbl
   drop foreign key FK_usertbl_buytbl;

alter table buytbl
   add constraint fk_usertbl_buytbl
    foreign key(userid) references usertbl(userid)
    -- 이구문이 들어감으로써 usertbl의 PK가 변경되면 따라서 
    -- buytbl의 FK인 userid도 따라 바뀐다.
    on update cascade;
    
-- 확인해보면 잘 바꿔있는 것을 볼 수가 있다.
-- 하지만, 현업에서는 PK를 바뀌는 건 권장사항이 아니다.
-- 이 예제에서도 머 개명을 했다면 몰라도 말이다.     
update usertbl
   set userid = 'VVK'
  where userid = 'BBK';

select * 
  from usertbl;
select * 
  from buytbl;

delete from usertbl
 where userid = "VVK";
 
-- 먼저 buytbl에 설정되어있는 외래키를 제거하고 다시 추가하자.
alter table buytbl
   drop foreign key fk_usertbl_buytbl; 

alter table buytbl
   add constraint fk_usertbl_buytbl
    foreign key(userid) references usertbl(userid)
   on update cascade   -- 부모테이블 수정시 자식테이블도 따라서 수정
    on delete cascade;   -- 부모테이블 삭제시 자식테이블도 따라서 삭제
    
delete from usertbl
 where userid = "VVK";
 
-- 컬럼 삭제
alter table usertbl
   drop column birthyear;
    
-- 컬럼 추가(맨처음 컬럼으로 추가)
alter table usertbl
   add column birthyear int first;
 
-- 컬럼 추가(맨 끝으로 컬럼 추가)
alter table usertbl
   add column birthyear int;

alter table usertbl
   add column birthyear int after userid; 
 
select * 
  from usertbl;
  
select * 
  from buytbl;
 
 