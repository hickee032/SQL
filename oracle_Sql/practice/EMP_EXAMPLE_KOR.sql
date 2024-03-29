DROP TABLE EMPLOYEE; --사원
DROP TABLE DEPARTMENT; --부서
DROP TABLE SALGRADE; --급여등급

--부서
CREATE TABLE DEPARTMENT
--DNO DNAME LOC 컬럼명
--CONSTRAINT 제약조건 
   (DNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY, --부서번호
   DNAME VARCHAR2(14), --부서명
	 LOC   VARCHAR2(13) ) ; --부서 지역명
     
--사원
CREATE TABLE EMPLOYEE 
    --사원번호 (기본키)
   (ENO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	 ENAME VARCHAR2(20),
 	 JOB   VARCHAR2(10),
	 MANAGER  NUMBER(4), --해당사원의 상사 번호
	 HIREDATE DATE, --입사일
	 SALARY NUMBER(7,2), --(7,2) 총 일곱 자리에서 소수점 두자리
	 COMMISSION NUMBER(7,2), --보너스
     --부서번호 (참조키)
	 DNO NUMBER(2) CONSTRAINT FK_DNO REFERENCES DEPARTMENT);
     
--급여등급
CREATE TABLE SALGRADE
   (GRADE NUMBER, --등급
	 LOSAL NUMBER, --급여 하한값
	 HISAL NUMBER ); --급여 상한값

INSERT INTO DEPARTMENT VALUES (10,'회계','뉴욕');
INSERT INTO DEPARTMENT VALUES (20,'연구','달라스');
INSERT INTO DEPARTMENT VALUES (30,'영업','시카고');
INSERT INTO DEPARTMENT VALUES (40,'관리','보스턴');

INSERT INTO EMPLOYEE VALUES
(7369,'스미스','사원',    7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7499,'알렌','판매원', 7698,to_date('20-2-1981', 'dd-mm-yyyy'),1600,300,30);
INSERT INTO EMPLOYEE VALUES
(7521,'워드','판매원',  7698,to_date('22-2-1981', 'dd-mm-yyyy'),1250,500,30);
INSERT INTO EMPLOYEE VALUES
(7566,'존스','매니저',  7839,to_date('2-4-1981',  'dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7654,'마틴','판매원',7698,to_date('28-9-1981', 'dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMPLOYEE VALUES
(7698,'블레이크','매니저',  7839,to_date('1-5-1981',  'dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7782,'클라크','매니저',  7839,to_date('9-6-1981',  'dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7788,'스콧','분석원',  7566,to_date('13-07-1987', 'dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7839,'킹','사장', NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7844,'튜너','판매원',7698,to_date('8-9-1981',  'dd-mm-yyyy'),1500,0,30);
INSERT INTO EMPLOYEE VALUES
(7876,'아담스','사원',    7788,to_date('13-07-1987', 'dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7900,'제임스','사원',    7698,to_date('3-12-1981', 'dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7902,'포드','분석원',   7566,to_date('3-12-1981', 'dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7934,'밀러','사원',   7782,to_date('23-1-1982', 'dd-mm-yyyy'),1300,NULL,10);

INSERT INTO SALGRADE VALUES (1, 700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

COMMIT;

