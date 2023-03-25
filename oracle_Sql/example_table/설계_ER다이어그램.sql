--11/14
-- 데이터 베이스 설계
--데이터베이스의 스키마 내에 테이블, 인덱스, 뷰 등의 데이터베이스 객체를 정의하는 것.
--주된 내용은 테이블의 이름이나 열, 자료형을 결정하는 것.
--테이블 간의 관계를 생각하며 여러 테이블을 정의 하고 작성하는 것.

--스키마
--데이터베이스의 구조와 제약조건에 관해 전반적으로 기술한 것

-- ER다이어그램
-- ERD (Entity Relationship Diagram)

-- 1.요구사항 분석 (개념적 모델링)
-- 기능을 추려내는 과정

-- 2.논리적 모델링
-- ER모델링 과정
-- 엔티티,관계,속성,식별자 
-- 테이블, 칼럼, 관계 

-- 3.물리적 모델링
-- 테이블 명세서
-- 엔티티,관계,속성,식별자를 테이블, 칼럼, 관계로 변환

-- 4.구현
-- 툴을 사용하여 논리적 모델링,물리적 모델링을 섞어 표현하기도 한다.

--ER다이어그램을 참고하여 테이블 생성

--교수,학생,과목 테이블

--교수 테이블
drop table professor_t;

create table professor_t (
pf_num varchar2(10) primary key,
pf_name varchar2(10),
pf_major varchar2(20)
);

--학생테이블
create table stu_t (
st_num varchar2(10) PRIMARY key,
st_name varchar2(10),
st_major varchar2(10),
st_pf_num varchar2(10)  REFERENCES professor_t
);

drop table major_t;
--과목테이블
create table major_t(
major_num varchar2(10) PRIMARY key,
major_name varchar2(20),
major_score number,
major_pf_num varchar2(10) REFERENCES professor_t
);

drop table stu_t;
--학생테이블
create table stu_t (
st_num varchar2(10) PRIMARY key,
st_name varchar2(10),
st_major varchar2(20),
st_pf_num varchar2(10)  REFERENCES professor_t
);

--수강테이블
drop table sign_t;


create table sign_t (
st_num varchar2(10) REFERENCES stu_t,
major_num varchar2(10) REFERENCES major_t,
PRIMARY key(st_num,major_num)
);

insert into professor_t VALUES ('P001','홍길동','컴퓨터학과');
insert into stu_t VALUES ('S001','이가가','컴퓨터학과','P001');
insert into major_t VALUES ('B001','컴퓨터학과',3,'P001');
insert into sign_t VALUES ('S001','B001');
