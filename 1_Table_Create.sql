--1 DBMS(RDBMS) 선정 -> (오라클) 
--2 테이블 생성 -> 데이터를 넣기 위한 틀이라고 생각하면 됨
--  실제 데이터가 저장되는 곳 (2차원 배열의 형태 >> 행row과 열column의 형태)
--  column 에는 속성(번호,이름,주소 등)이 존재한다 (C 구조체 형태 비슷)
--3 SQL을 사용하여 데이터를 사용
--  CRUD : C -> insert, R ->read, U->update, D->delete
--4 설계 단계 (구조화)


/*
--테이블 생성 (영어 대 소문자 상관없음 -> 가독성을 위해 소문자면 소문자로 대문자면 대문자로)

CREATE TABLE customer_t (
    NAME VARCHAR2(20),
    age NUMBER,
    gender CHAR(1),
    rdate DATE DEFAULT sysdate
);

--데이터 추가
--insert into 테이블명 values 컬럼 데이터

INSERT INTO customer_t (name,age,gender,rdate) 
VALUES ('홍길동',100,'M',sysdate);

--컬럼 명시 개수와 데이터의 개수가 일치해야함 오류 : ORA-00913
--반대의 경우도 오류 발생
INSERT INTO customer_t (name,age,gender) 
VALUES ('홍길동',100,'M',sysdate);

--생략할경우 모든정보를 넣어줘야함
insert into customer_t
values ('김길동',50,'M',sysdate);

--데이터 보기 oracle 기준으로 ctrl+enter 실행과 f5 실행이 약간 다름
--select 컬럼명 from 테이블명;

--name 데이터만 봄
select name from customer_t;
--age, gender 데이터를 봄
select age,gender from customer_t;
--모든 데이터를 봄
select * from customer_t;

*/


--데이터 타입
--VARCHAR2 가변길이 문자열 권장 "홍길동",'홍길동'
--char 고정길이 문자열
--number 숫자 가변
--int 숫자 고정
--date 날짜
--clob 대용량 문자열
--blob 이미지 동영상 사운드



--테이블 생성 연습 01
--학생 테이블 학번 이름 나이 주소 전화번호 이메일 카톡ID
--학번 나이 숫자 나머지 문자열
--10개의 데이터 insert
--select 데이터 출력

CREATE table student_t(
st_no number,
name VARCHAR2(20),
age number,
addr VARCHAR2(40),
phone VARCHAR2(20),
e_mail VARCHAR2(20),
k_id VARCHAR2(20)
);

insert into student_t
values ('001','가나다',22,'대구','010-1234-1234','AAA@mail','AAA');
insert into student_t
values ('002','다라마',24,'서울','010-3278-1234','BBB@mail','A135');
insert into student_t
values ('003','바사아',21,'대전','010-1784-1234','CCC@mail','C89');
insert into student_t
values ('004','아자차',25,'부산','010-1369-1234','DDD@mail','A56');
insert into student_t
values ('005','카타하',21,'서울','010-1258-1234','EEE@mail','E12');
insert into student_t
values ('006','AAA',22,'대구','010-4637-1234','FFF@mail','FFF');
insert into student_t
values ('007','BBB',20,'부산','010-5678-1234','GGG@mail','GGG');
insert into student_t
values ('008','CCC',21,'대전','010-1234-1234','HHH@mail','HHH');
insert into student_t
values ('009','DDD',22,'서울','010-0000-1234','UUU@mail','UUU');
insert into student_t
values ('010','EEE',23,'대구','010-7896-1234','QQQ@mail','QQQ');

--여러개 한꺼번에 넣기
INSERT INTO student_t
SELECT '001','EEE',23,'대구','010-7896-1234','QQQ@mail','QQQ' FROM DUAL
union all
SELECT '002','가가가',23,'대전','010-6731-1234','aaa@mail','a11' FROM DUAL
union all
SELECT '003','나나나',24,'서울','010-7891-1614','bbb@mail','bb2' FROM DUAL;

select* from student_t;

select ST_NO,NAME,ADDR from student_t;

select ST_NO,NAME,PHONE from student_t;

select name, age from student_t
where age >21;

--테이블 수정
--컬럼 추가 name2
alter table student_t add(name2 varchar2(40));
--컬럼 사이즈 수정 40->20
alter table student_t modify(name2 varchar2(20));


--조건 검색 select from where
select st_no, name, phone from student_t;

--이름이 '가가가'
select st_no, name, phone from student_t
where name = '가가가';

select st_no, name, phone from student_t
where st_no = 001;

select * from student_t
where st_no = 001;

--조건 검색 and, or
select * from student_t
where addr = '대구' or addr = '부산' ;

delete from student_t;

-- not null에 NULL 값을 넣을 경우 오류 : ORA-01400
INSERT INTO cus_t
VALUES (NULL,'010-1234-1234',40,sysdate);










