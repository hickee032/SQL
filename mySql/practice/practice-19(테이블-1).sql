drop database if exists tabledb;
create database tabledb;
use tabledb;

CREATE TABLE userTbl -- 회원 테이블
( 
  userID     CHAR(8) NOT NULL PRIMARY KEY, -- 사용자아이디
  name       VARCHAR(10) NOT NULL, -- 이름
  birthYear INT NOT NULL,  -- 출생년도
  addr        CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  mobile1   CHAR(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등)
  mobile2   CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
  height    SMALLINT,  -- 키
  mDate       DATE  -- 회원 가입일
);

CREATE TABLE buyTbl -- 회원 구매 테이블
			 -- AUTO_INCREMENT 테이블에들어가는 순간 번호를 매긴다	
(  num       INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   userID     CHAR(8) NOT NULL, -- 아이디(FK)
   prodName    CHAR(6) NOT NULL, --  물품명
   groupName    CHAR(4)  , -- 분류
   price        INT  NOT NULL, -- 단가
   amount       SMALLINT  NOT NULL -- 수량 -- SMALLINT=short
  -- Fk가 있는 테이블이 통상 자식테이블이 되고 PK가 있는 테이블이 부모테이블이 된다
  -- 외래키가 꼭 pk와 연동되는 것이 아니고 unique key와도 연동이 된다
  -- FOREIGN KEY (userID) REFERENCES userTbl(userID) -- 웬만하면 동일하게 가져가도록하자. 헷갈린다.
  -- constraint FK_usertbl_buytbl FOREIGN KEY (userID) REFERENCES userTbl(userID)
);

-- 위에 테이블을 만들고 pk설정을 해주면 자동적으로 클러스트 index가 만들어진다 
-- pk설정시 인덱스가 만들어진다는 것을 기억하자
-- 외래키는 참조하는 테이블의 컬럼명과 동일하게 해주고 아울러 데이터 타입도 일치하게 해준다

drop table buytbl;

-- 외래키 추가방법 데이터가 많다면 오래 걸린다.
alter table buytbl 
	add constraint FK_usertbl_buytbl 
    foreign key (userid) references usertbl(userid);
    
-- 외래키 삭제방법
alter table buytbl 
	drop foreign key FK_usertbl_buytbl;
    
-- 제약조건을 확인하는 방법    
show index from buytbl;    
desc buytbl;

INSERT INTO userTbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO userTbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');

-- 각 아래 코드를 입력하고 동시에 실행을 시키면 에러가 난다 왜일까?
-- 바로 jyp에서 에러가 나는 것을 확인할 수가 있다 그 이유는 jyp를 외래키로
-- 설정을 했는데 참조하는 테이블 즉 , usertbl에는 아직 jyp만 높이 없어서 에러를
-- 치는것이다
-- 회원도 없는데 어떻게 구매를 할 수가 있나 ?
-- 항상 회원가입을 하고 구매를 할 수가 있지 않는가 ?

INSERT INTO buyTbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
-- 외래키를 잠시 죽이는 방법
set foreign_key_checks=0;
INSERT INTO buyTbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
-- 외래키를 다시 살리는 방법
set foreign_key_checks=1;

select *
from usertbl;

select *
from buytbl;
