
--유저 테이블 생성
CREATE TABLE userTBL (
    userID CHAR(8) NOT NULL PRIMARY KEY, --사용자 아이디
    userName NVARCHAR2(10) NOT NULL, --이름
    birthYear NUMBER(4) NOT NULL, --출생연도
    addr NCHAR(2) NOT NULL, --주소
    mobile1 CHAR(3), --휴대폰 국번
    mobile2 CHAR(8), --휴대폰 나머지 번호
    height NUMBER(3),--키
    mDate DATE --회원 가입일
    );

--회원 구매 테이블    
CREATE TABLE buyTBL (
    idNum NUMBER(8) NOT NULL PRIMARY KEY,--순번PK
    userID CHAR(8) NOT NULL, --아이디(FK)
    prodName NCHAR(6) NOT NULL, --물품명
    groupName NCHAR(4), --분류
    price NUMBER(8) NOT NULL, --단가
    amount NUMBER(3) NOT NULL,--수량
    FOREIGN KEY(userID) REFERENCES userTBL(userID)
    );    


INSERT INTO usertbl VALUES('LSG','이승기',1987,'서울','011','11111111',182,'2008-8-8');
INSERT INTO usertbl VALUES('KBS','김범수',1979,'경남','011','22222222',173,'2012-4-4');
INSERT INTO usertbl VALUES('KKH','김경호',1971,'전남','019','33333333',177,'2007-7-7');
INSERT INTO usertbl VALUES('JYP','조용필',1950,'경기','011','44444444',166,'2009-4-4');
INSERT INTO usertbl VALUES('SSK','성시경',1979,'서울',NULL,NULL,186,'2013-12-12');
INSERT INTO usertbl VALUES('LJB','임재범',1963,'서울','016','66666666',182,'2009-9-9');
INSERT INTO usertbl VALUES('YJS','윤종신',1969,'경남',NULL,NULL,170,'2005-5-5');
INSERT INTO usertbl VALUES('EJW','은지원',1972,'경북','011','88888888',174,'2014-3-3');
INSERT INTO usertbl VALUES('JKW','조관우',1965,'경기','018','99999999',172,'2010-10-10');
INSERT INTO usertbl VALUES('BBK','바비킴',1973,'서울','010','00000000',176,'2013-5-5');

CREATE SEQUENCE idSEQ; --순차번호 입력을 위해 시퀀스 생성
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'KBS','운동화',NULL,30,2);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'KBS','노트북','전자',1000,1);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'JYP','모니터','전자',200,1);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'BBK','모니터','전자',200,5);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'KBS','청바지','의류',50,3);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'BBK','메모리','전자',80,10);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'SSK','책','서적',15,5);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'EJW','책','서적',15,2);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'EJW','청바지','의류',50,1);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'BBK','운동화',NULL,30,2);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'EJW','책','서적',15,1);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'BBK','운동화',NULL,30,2);

select *
from usertbl;

select *
from buytbl;

SELECT *FROM usertbl WHERE username = '김경호';

select userid,username from usertbl where birthyear >= 1970 and height >=182; 
select userid,username from usertbl where birthyear >= 1970 or height >=182; 

select username,height from usertbl where height >=180 and height <=183;
select username, height from usertbl where height between 180 and 183;

select username from usertbl where addr in('경남','전남','경북');

--서브쿼리

select username,height from usertbl
where height >(select height from usertbl where username = '김경호');

--오류 서브쿼리의 반환 값이 2개
select username, height from usertbl 
where height>(select height from usertbl where addr = '경남');

--any 서브쿼리의 결과중 하나만 만족해도 됨
select username, height from usertbl 
where height>=any(select height from usertbl where addr = '경남');

--all 서브쿼리의 결과를 모두 만족해야 됨
select username, height from usertbl 
where height>=all(select height from usertbl where addr = '경남');

