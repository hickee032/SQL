--11/07 연습문제

--학생 테이블 STUDENT_T
--ID 문자열 5 기본키 ,NAME 문자열 10, NULL 아님
--나이 숫자 NULL 아님, 성별 문자열 5 NULL 아님
--학년 문자열 10 NULL 아님 주소 문자열 50 NULL아님
-- 아이디 (기본키) 나이 (19세 이상)  성별 (남, 여) 학년 (1학년,2학년,3학년,4학년)
DROP TABLE STUDENT_T;

CREATE TABLE student_t(
ID VARCHAR2(5) PRIMARY KEY,
NAME VARCHAR2(10) NOT NULL,
age NUMBER NOT NULL CHECK(age >= 19),
gender VARCHAR2(5) NOT NULL CHECK(gender IN ('남','여')),
grade VARCHAR2(10) NOT NULL CHECK (grade IN ('1학년','2학년','3학년','4학년')),
addr VARCHAR2(50) NOT NULL
);

INSERT INTO student_t VALUES ('kkk','김가가',21,'남','3학년','대구시');
--기본키 중복 오류 : ORA-00001: 무결성 제약 조건
INSERT INTO student_t VALUES ('kkk','김구구',20,'여','2학년','대구시');
--CHECK AGE 오류 : ORA-02290: 체크 제약조건
INSERT INTO student_t VALUES ('kHH','김하하',18,'여','1학년','서울시');
--CHECK GENDER 오류 : ORA-02290: 체크 제약조건
INSERT INTO student_t VALUES ('kSS','김수수',22,'?','2학년','인천시');
--CHECK GRADE 오류 : ORA-02290: 체크 제약조건
INSERT INTO student_t VALUES ('kMM','김미미',19,'남','5학년','부산시');

--ALTER 사용

DROP TABLE STUDENT_T2;

CREATE TABLE STUDENT_T2(
ID VARCHAR2(5),
NAME VARCHAR2(10),
AGE NUMBER,
GENDER VARCHAR2(5),
GRADE VARCHAR2(10),
ADDR VARCHAR2(50));

ALTER TABLE STUDENT_T2 ADD(PRIMARY KEY(ID));
ALTER TABLE STUDENT_T2 MODIFY NAME NOT NULL;
ALTER TABLE STUDENT_T2 MODIFY AGE NOT NULL;
ALTER TABLE STUDENT_T2 ADD(CHECK(AGE >=19));
ALTER TABLE STUDENT_T2 MODIFY GENDER NOT NULL ADD(CHECK(GENDER IN ('남','여')));
ALTER TABLE STUDENT_T2 MODIFY GRADE NOT NULL ADD(CHECK(GRADE IN ('1학년','2학년','3학년','4학년')));
ALTER TABLE STUDENT_T2 MODIFY ADDR NOT NULL;

INSERT INTO student_t2 VALUES ('kkk','김가가',21,'남','3학년','대구시');
--기본키 중복 오류 : ORA-00001: 무결성 제약 조건
INSERT INTO student_t2 VALUES ('kkk','김구구',20,'여','2학년','대구시');
--CHECK AGE 오류 : ORA-02290: 체크 제약조건
INSERT INTO student_t2 VALUES ('kHH','김하하',18,'여','1학년','서울시');
--CHECK GENDER 오류 : ORA-02290: 체크 제약조건
INSERT INTO student_t2 VALUES ('kSS','김수수',22,'?','2학년','인천시');
--CHECK GRADE 오류 : ORA-02290: 체크 제약조건
INSERT INTO student_t2 VALUES ('kMM','김미미',19,'남','5학년','부산시');

RENAME student_t1 TO student_t;