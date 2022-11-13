--11/08
--view (뷰)
--물리적인 테이블을 근거한 논리적인 가상 테이블 (메모리)
--속도가 빠름
--디스크 저장 공간이 할당되지 않음
--테이블에서 파생된 객체 테이블과 유사

--뷰를 쓰기위해서는 권한이 필요하다 
--뷰 권한 부여 (SYSTEM 계정으로 부여)
GRANT CREATE VIEW TO test;

/*
CREATE OR REPLACE  VIEW VIEWNAME AS SUBQUERY
[WITH CHECK OPTION]
[WITH READ ONLY]
*/

--단순 뷰 하나의 기본테이블로 생성 DML명령문 실행 DML명령문의 처리결과는 기본테이블에 반영
--복합 뷰 두개이상의 기본테이블로 생성

--뷰를 사용하는 이유 - 보안과 사용의 편의성 때문

--보안을 위한 뷰
CREATE VIEW V_EMP_SAMPLE
AS
SELECT ENO,ENAME,JOB,MANAGER,DNO
FROM EMPLOYEE;

--정보를 손쉽게 얻기위한 뷰
CREATE VIEW V_EMP_COMPLEX2
AS
SELECT E.ENO,E.ENAME,E.SALARY,DNO,D.DNAME,D.LOC
FROM EMPLOYEE E NATURAL JOIN DEPARTMENT D;

--USER_VIEWS 데이터 사전
SELECT VIEW_NAME, TEXT
FROM USER_VIEWS;

--뷰는 데이터를 저장하고 있지 않은 가상 테이블 실체가 없음
--뷰를 정의 할떄 CREAT VIEW 명령어 다음 AS절에 기술한 쿼리 문장 자체를 저장했다가 이를 실행 (CASH와 흡사함 CASH는 물리적으로 저장 VIEW는 메모리에 저장 )

--뷰에 그룹함수 사용 (별칭사용)
--별칭을 컬럼명처럼 사용할수 있음
CREATE VIEW V_EMP_SALARY
AS
SELECT DNO,SUM(SALARY) AS "SAL_SUM", AVG(SALARY) AS "SAL_AVG"
FROM EMPLOYEE
GROUP BY DNO;

CREATE VIEW V_EMP_SALARY
AS
SELECT DNO,SUM(SALARY) AS "급여합계", ROUND(AVG(SALARY)) AS "급여평균"
FROM EMPLOYEE
GROUP BY DNO;

--뷰를 이용해 정보 보기
SELECT * FROM V_EMP_SALARY ORDER BY DNO;
SELECT DNO,급여합계,급여평균 FROM V_EMP_SALARY ORDER BY DNO;

--뷰가 더 이상 필요 없을 때는 
--DROP VIEW 뷰 이름
DROP VIEW V_EMP_SALARY;
--뷰는 가상 테이블이기 때문에 뷰를 삭제 한다는 것은 USER_VIEWS 데이터 디셔너리에 저장된 것을 삭제 한다는 뜻
--뷰를 삭제해도 실제 테이블에 영향을 주지 않는 다

--CREATE OR REPLACE VIEW 
--이미 존재하는 뷰에 대해서 그 내용응 새롭게 변경하여 생성
--FORCE
--기본 테이블의 존재여부와 상관 없이 뷰 생성

--WITH CHECK OPTION
--해당 뷰를 통해서 볼수 있는 범위 내에서만 UPDATE, INSERT 가 가능
--WITH READ ONLY
--해당뷰를 통해서는 SELECT만 가능 INSERT, UPDATE ,DELETE 할수없음
--이것을 생략한다면 INSERT, UPDATE ,DELETE 모두 가능

--LEVEL : MANAGER를 기준으로 순번 
SELECT LEVEL 직급순위,ENO 사번, ENAME 사원명, JOB 담당업무, SALARY 급여 FROM employee
START WITH MANAGER IS NULL CONNECT BY PRIOR ENO=MANAGER 
ORDER SIBLINGS BY MANAGER;
--ORDER SIBLINGS BY : 조회된 데이터 칼럼에 대해서 ORDER BY 적용
--CONNECT BY 상위 코드와 하위 코드를 이용해서 TREE 형태 출력


--연습
--1.직급순위, 사번, 사원명, 담당업무, 매니저번호, 입사일 ,급여, 커미션 , 부서번호,부서명 출력

SELECT LEVEL 직급순위,E.ENO 사번, E.ENAME 사원명, E.JOB 담당업무, E.MANAGER 매니저번호,E.HIREDATE 입사일, E.SALARY 급여,E.COMMISION 커미션, E.DNO 부서번호,D.DNAME 부서명 
FROM employee E ,department D
WHERE E.DNO = D.DNO
START WITH MANAGER IS NULL CONNECT BY PRIOR ENO=MANAGER 
ORDER SIBLINGS BY '직급순위';

SELECT LEVEL 직급순위,E.ENO 사번, E.ENAME 사원명, E.JOB 담당업무, E.MANAGER 매니저번호,E.HIREDATE 입사일, E.SALARY 급여,E.COMMISION 커미션,E.DNO 부서번호,D.DNAME 부서명 
FROM employee E INNER JOIN department D
ON E.DNO = D.DNO
START WITH MANAGER IS NULL CONNECT BY PRIOR ENO=MANAGER 
ORDER SIBLINGS BY '직급순위';

SELECT RANK() OVER (ORDER BY MANAGER ASC NULLS FIRST) AS 직급순위,E.ENO 사번, E.ENAME 사원명, E.JOB 담당업무, E.MANAGER 매니저번호,E.HIREDATE 입사일, E.SALARY 급여,E.COMMISION 커미션,E.DNO 부서번호,D.DNAME 부서명 
FROM employee E INNER JOIN department D
ON E.DNO = D.DNO
ORDER BY '직급순위';

--조인 안쓰고 하는 방법
--서브쿼리 
--SELECT에서 서브쿼리
SELECT LEVEL 직급순위,E.ENO 사번,E.ENAME 사원명, E.JOB 담당업무, E.MANAGER 매니저번호,E.HIREDATE 입사일, E.SALARY 급여,E.COMMISSION 커미션,E.DNO 부서번호, 
(SELECT DNAME FROM department WHERE E.ENO = DNO) 부서명
FROM employee E
START WITH MANAGER IS NULL CONNECT BY PRIOR ENO=MANAGER
ORDER SIBLINGS BY '직급순위';

SELECT LEVEL 직급순위,E.ENO 사번,E.ENAME 사원명, E.JOB 담당업무, E.MANAGER 매니저번호,E.HIREDATE 입사일, E.SALARY 급여,NVL(E.COMMISSION,0) 커미션,E.DNO 부서번호, 
(SELECT DNAME FROM department WHERE E.ENO = DNO) 부서명
FROM employee E
START WITH MANAGER IS NULL CONNECT BY PRIOR ENO=MANAGER
ORDER SIBLINGS BY '직급순위';

--CASE ~WHEN ~THEN END 
SELECT LEVEL 직급순위,ENO 사번,ENAME 사원명, JOB 담당업무, MANAGER 매니저번호,HIREDATE 입사일, SALARY 급여,COMMISSION 커미션,DNO 부서번호, 
CASE WHEN DNO = 10 THEN '회계'
     WHEN DNO = 20 THEN '연구'
     WHEN DNO = 30 THEN '영업'
     WHEN DNO = 40 THEN '관리'
END AS 부서명 
FROM employee
START WITH MANAGER IS NULL CONNECT BY PRIOR ENO=MANAGER
ORDER SIBLINGS BY '직급순위';

--1번을 뷰로 생성 - 직급 순위 오름차순으로 정렬

CREATE OR REPLACE VIEW staff_list
AS
SELECT LEVEL 직급순위,E.ENO 사번, E.ENAME 사원명, E.JOB 담당업무, E.MANAGER 매니저번호,E.HIREDATE 입사일, E.SALARY 급여,E.COMMISSION 커미션,E.DNO 부서번호,D.DNAME 부서명 
FROM employee E INNER JOIN department D
ON E.DNO = D.DNO
START WITH MANAGER IS NULL CONNECT BY PRIOR ENO=MANAGER 
ORDER SIBLINGS BY MANAGER;

SELECT *
FROM staff_list
ORDER BY 직급순위;

--시퀀스 SEQUENCE
--테이블내에 유일한 숫자를 자동으로 생성 

/*
CREATE SEQUENCE_NAME
        START WITH N -- 시퀀스의 시작 번호 
        INCREMENT BY N -- 시퀀스 증가값
        MAXVALUE N OR NOMAXVALUE --시퀀스가 가질수 있는 최대값 ASCENDING 10의 27승 DESCENDING -1
        MINVALUE N OR NOMINVALUE --시퀀스가 가질수 있는 최소값 DESCENDING 10의 26승
        CYCLE OR NOCYCLE --시퀀스가 최대값까지 증가한후 다시 START WITH 값으로 NOCYCLE은 증가가 완료되면 에러를 유발 
        CACHE N OR NOCACHE --메모리상에서 시퀀스의 값을 관리 
*/

--증가 시퀀스
CREATE SEQUENCE SAMPLE_SEQ
    INCREMENT BY 10 -- 10씩 증가함
    START WITH 10; -- 10부터 시작함

--감소 시퀀스
CREATE SEQUENCE emp_seq
    INCREMENT BY -10 --10씩 감소함
    START WITH 1000; --1000부터 시작함

--CURRVAL --시퀀스의 현재 값 (CURRVAL 에 새로값이 할당되기 위해서는 NEXTVAL로 새로운 값을 생성해야함)
--NEXTVAL --시퀀스의 다음 값 (NEXTVAL로 새로운 값을 생성한 다음 이값을 CURRVAL에 대체)

CREATE SEQUENCE DNO_SEQ
INCREMENT BY 10
START WITH 10;

CREATE TABLE DEPT_SECOND
AS
SELECT *
FROM department;

DROP TABLE DEPT_SECOND;
DELETE DEPT_SECOND;

INSERT INTO DEPT_SECOND
VALUES(DNO_SEQ.NEXTVAL,'ACCOUNTING','NEW YORK');
--테이블 데이터를 삭제후에 다시 넣으면 10부터가 아닌 20부터 넣어짐 다시 10부터 넣기위해서는 시퀀스를 삭제후 넣어야함



--시퀀스를 변경할려면 
--ALTER SEQUENCE
ALTER SEQUENCE DNO_SEQ
MAXVALUE 50;

--시퀀스 제거
DROP SEQUENCE DNO_SEQ;

--인덱스 INDEX
--검색 성능을 향상 시키기위해 사용(도서 맨뒤에 목차같은 것)
--기본키나 유일키는 인덱스가 자동으로 생성됨
--하지만 무조건 쓴다고 좋은 건 아님

/*
CREATE INDEX INDEX_NAME
ON TABLE_NAME (컬럼명);
*/

--인덱스 생성
CREATE INDEX IDX_EMP_ENAME
ON EMPLOYEE(ENAME);
--인덱스 삭제
DROP INDEX IDX_EMP_ENAME;

--인덱스를 사용 해야하는 경우
--테이블의 행의 수 가 많을 경우
--WHERE 절에 해당 칼럼이 많이 사용될때
--검색결과가 전체 데이터의 2~4% 정도 일때
--JOIN에 자주 사용되는 칼럼이나 NULL을 포함하는 칼럼이 많은 경우

--인덱스를 사용하지 말아야하는 경우
--위와 반대 
--검색결과가 전체 데이터의 10~15% 정도 일때
--테이블에 DML작업이 많을 경우 입력 수정 삭제등이 많을 경우
