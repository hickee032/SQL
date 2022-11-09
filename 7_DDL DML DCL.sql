--11/07_1

-- 연습 문제

--부하 직원이 없는 직원
select eno,ename,salary
from employee
where eno not in (select manager from employee where manager is not null group by manager);

--블레이크와 동일한 부서에 속한 사원명 입시일 블레이크 출력 제외
select ename, hiredate,dno 
from employee
where dno = any(select dno from employee where ename in '블레이크') and  ename not in('블레이크');

--근무지가 달라스인 사원명 부서번호 담당 업무 출력 이름 오름차순 (서브쿼리, 조인)
select distinct e.ename, e.dno, e.job 
from employee e , department d
where e.dno = (select dno from department d where d.loc = '달라스')
order by e.ename;

select e.ename, e.dno, e.job
from employee e inner join department d
on e.dno = d.dno
where d.loc in ('달라스')
order by e.ename;

----------------------------------------------------------------------------------------------------
/*  create table 테이블 생성
    alter table 테이블 구조 변경
    rename 테이블 이름 변경
    drop table 테이블 구조 제거
    truncate table 데이터 제거   */
    
-- 툴을 사용하여 하는 경우도 많다.

/*
alter table dept
    add(birth ,date);

drop table 테이블 명
truncate table 테이블 명
*/ 

--데이터 조작 insert update delete
--DML
--INSRTT INTO : 테이블에 데이터를 입력
--문자나 날짜는  ''

--데이터를 제외한 구조만 복사
CREATE TABLE DEPT_COPY
AS 
SELECT *FROM department WHERE 0= 1;

CREATE TABLE EMP_COPY
AS 
SELECT *FROM employee WHERE 0= 1;

--컬럼명을 생략할 경우
--원래 테이블에 명시된 컬럼의 순서대로 입력해야함
INSERT INTO DEPT_COPY VALUES (10,'회계','뉴욕');

--컬럼명을 명시할 경우
--명시된 컬럼의 순서대로 입력해야함
INSERT INTO DEPT_COPY (DNO,LOC,DNAME )VALUES (20,'달라스','연구');

--NULL 값을 갖는 로우 삽입
--입력시 NULL값을 생략 (칼럼을 명시할 경우)
INSERT INTO dept_copy (DNO,DNAME)VALUES (30,'판매');

--입력시 NULL값을 명시
INSERT INTO DEPT_COPY VALUES (40,'관리',NULL);

--날짜 데이터 입력시 오라클의 경우 YY/MM/DD 의 형식
INSERT INTO EMP_COPY
VALUES (7000,'캔디','매니저',NULL,'2012/05/01',NULL,NULL,10);
--TO_DATE
INSERT INTO EMP_COPY
VALUES (8000,'앤디','판매원',NULL,TO_DATE(SYSDATE),NULL,NULL,10); 

--다른 테이블에서 데이터를 복사하기
/*INSERT INTO TABLE [(컬럼1,컬럼2]
SUBQUERY;*/

--서브쿼리를 이용해 다중행을 입력
INSERT INTO dept_copy
SELECT * FROM department;

--UPDATE 수정
/*
UPDATE TABLE이름
SET 컬럼1 = 값, 컬럼2 = 값 
WHERE CONDITIONS;
*/

UPDATE dept_copy
SET DNAME = '개발', LOC = '서울'
WHERE DNO = 10;

UPDATE dept_copy
SET DNAME = 'HR';

--다른 테이블을 기반으로 데이터를 수정

UPDATE dept_copy
SET LOC = (SELECT LOC FROM dept_copy WHERE DNO = 20)
WHERE DNO = 10;


UPDATE dept_copy
SET DNAME = (SELECT DNAME FROM dept_copy WHERE DNO = 30),
LOC = (SELECT LOC FROM dept_copy WHERE DNO = 30)
WHERE DNO = 10;

--DELETE TKRWP
--WHERE절을 생략하면 테이블에 있는 모든행이 삭제됨

/*DELETE 테이블명
    WHERE 조건*/
    
DELETE dept_copy
WHERE DNO = 10;

--다름 테이블 기반으로 로우 삭제

DELETE EMP_COPY
WHERE DNO = (SELECT DNO FROM department WHERE DNAME = '영업');

/* 트랜잭션 
데이터 처리에서 논리적으로 하나의 작업단위
오라클 명령어중 DDL DCL은 하나의 명령어가 하나의 트랜잭션
(쉽게 말하자면 ; 세미콜론을 기준으로 한다)
DML은 데이터의 변동의 일관성으로위해 하나 이상의 DML문이 모여 하나의 트랜잭션

ALL OR NOTING 여러개의 명령어 집합이 정상적으로 처리되면 정상 종료 명령어중 하나라도 잘못된다면 전체를 취소 */

/*
DML 문은 실행됨과 동시에 트랜잭션이 진행
DML 작업이 정상 처리되었다면 COMMIT 취소해야한다면 ROLLBACK

COMMIT 트랜잭션 처리과정을 반영 변경된 내용을 모두 영구 저장
ROLLBACK 트랜잭션 처리과정 중 발생한 변경 사항을 취소 ROLLBACK 실행시 하나의 묶음처리 시작 이전으로 돌아감 */