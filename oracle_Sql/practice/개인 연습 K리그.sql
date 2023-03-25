--11/09
--개인 연습
--https://tantangerine.tistory.com/20

--비교연산자, 논리연산자, SQL연산자 문제

--1.소속팀이 삼성블루윙즈팀인 선수들을 출력
SELECT player_name
FROM PLAYER
WHERE team_id IN('K02');
--2.포지션이 미드필더인 선수들을 출력
SELECT player_name
FROM PLAYER
WHERE POSITION IN ('MF');
--3.키가 170CM이상인 선수들을 출력
SELECT player_name
FROM PLAYER
WHERE HEIGHT >=170;
--4.소속팀이 삼성블루윙즈이거나 전남드래곤즈 소속인 선수들을 출력
SELECT PLAYER_NAME
FROM PLAYER
WHERE TEAM_ID IN('K02') OR TEAM_ID IN('K07');

SELECT PLAYER_NAME
FROM PLAYER 
WHERE TEAM_ID = 'K02' OR TEAM_ID = 'K07';

--5.삼성블루윙즈이거나 전남드래곤즈 소속이면서 포지션이 미드필더이고 키가 170이상 180이하인 선수들을 출력
SELECT PLAYER_NAME
FROM PLAYER
WHERE TEAM_ID IN('K02') OR TEAM_ID IN('K07') AND POSITION IN ('MF') AND HEIGHT BETWEEN 170 AND 180;

--6.삼성블루윙즈이거나 전남드래곤즈 소속이면서 포지션이 미드필더아니고 키가 170이상 180이하인 선수들을 출력
SELECT PLAYER_NAME
FROM PLAYER
WHERE TEAM_ID IN('K02') OR TEAM_ID IN('K07') AND POSITION NOT IN('MF') AND HEIGHT BETWEEN 170 AND 180;

--7.JOB이 MANAGER이면서 20번 부서에 속하거나 JOB이 CLERK이면서 30번 부서에 속하는 사원의 정보를 출력
SELECT ENAME
FROM EMP
WHERE (JOB IN ('MANAGER') AND DEPTNO = 20 )OR (JOB IN ('CLERK') AND DEPTNO = 30);

--서브쿼리 문제 단일행 다중행 EXISTS
--1.정남일 선수가 소속된 팀의 선수들에 대한 정보를 출력
SELECT P.TEAM_ID,PLAYER_ID,P.player_name,p.position
FROM PLAYER P
WHERE TEAM_ID IN (SELECT TEAM_ID FROM PLAYER WHERE PLAYER_NAME IN('정남일'));

--2.선수들중 키가 평균 이하인 선수들의 정보를 출력
SELECT PLAYER_NAME ,HEIGHT
FROM PLAYER
WHERE HEIGHT <(SELECT AVG(HEIGHT) FROM PLAYER);

--3.각 부서별 급여평균보다 더 많이 받는 사원의 사원번호, 이름, 급여를 출력
SELECT DEPTNO,EMPNO,ENAME,SAL 
FROM EMP
WHERE SAL > ALL(SELECT AVG(SAL) FROM EMP GROUP BY DEPTNO)
ORDER BY DEPTNO;

--4.CHICAGO 지역에 근무하는 사원들 중 BLACK의 직속 상관인 사원들의 사원번호, 이름 ,직무 출력
 SELECT EMPNO,ENAME,JOB
 FROM EMP
 WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT WHERE LOC IN ('CHICAGO'));

--5.각 부서 별로 최고급여를 받는 직원의 직원번호, 이름, 급여를 출력
SELECT DEPTNO, EMPNO, ENAME ,SAL
FROM EMP
WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO)
ORDER BY DEPTNO;

--6.20120501 부터 20120502 사이에 경기가 있는 경기장을 출력
SELECT STADIUM_ID,STADIUM_NAME
FROM STADIUM
WHERE STADIUM_ID IN (SELECT STADIUM_ID FROM SCHEDULE WHERE sche_date BETWEEN '20120501' AND '20120502');

SELECT STADIUM_ID ,STADIUM_NAME
FROM STADIUM A
WHERE EXISTS (SELECT 1 FROM SCHEDULE X WHERE X.stadium_id = A.stadium_id
AND X.sche_date BETWEEN '20120501' AND '20120502');

--7.소속팀별 키가 가장 작은 사람들의 정보를 출력
SELECT TEAM_ID, PLAYER_ID, PLAYER_NAME,HEIGHT
FROM PLAYER
WHERE (TEAM_ID,HEIGHT) IN (SELECT TEAM_ID,MIN(HEIGHT) FROM PLAYER GROUP BY TEAM_ID);

--8.각 부서별로 최고급여를 받는 직원의 직원번호, 이름, 급여 출력
SELECT DEPTNO,EMPNO, ENAME, SAL
FROM EMP
WHERE SAL IN(SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

--9.K리그 선수들둥에서 포지션이 미드필더인 선수들의 소속팀명 선수정보를 출력
--10.K리그 선수들중에서 가장 키가 큰 선수 5명을 출력
--11.최근 입사한 5명의 사원을 출력
--12.사원의 급여를 내림차순으로 모든 정보를 출력
--13.사원이름과 급여를 최고 높은 순으로 정렬하고 순위를 표시하는 칼럼을 생성하여 출력
--14.급여를 많이 받는 6~10번째 사원을 출력
--15.삼성블루윙즈(K02)의 평균키보다 작은 팀의 이름과 해당 팀의 평균 키를 출력
--16.사원이 속해있는 부서번호와 부서이름을 출력 (중복은 허용하지 않는 다)



--GROUP BY , HAVING 문제

--1.포지션별 인원수, 최대키 ,최소키 , 평균키를 출력 소수점 2자리
SELECT POSITION, COUNT(*) 인원수, MAX(HEIGHT) 최대키 ,MIN(HEIGHT) 최소키 , ROUND(AVG(HEIGHT),2) 평균키
FROM PLAYER
GROUP BY POSITION
HAVING POSITION IS NOT NULL;

--2.K리그 선수들의 포지션별 평균키를 구하고 평균키가 180CM이상인 정보만 출력

SELECT position,COUNT(*), ROUND(AVG(HEIGHT)) 평균키
FROM player
GROUP BY position
HAVING ROUND(AVG(HEIGHT)) >= 180;

--3.K리그 선수들중 삼성블루윙즈(K02)와 FC서울(K09)의 인원수를 출력

SELECT team_id, COUNT(*)
FROM player
GROUP BY team_id
HAVING team_id IN('K02','K09')
ORDER BY team_id;

SELECT TEAM_ID,COUNT(*)
FROM PLAYER
WHERE team_id IN('K02','K09')
GROUP BY team_id
ORDER BY team_id;

--4.포지션별로 평균키를 출력 최대키가 190CM이상인 선수를 포함하고 있는 포지션의 정보만 출력
SELECT POSITION 포지션,ROUND(AVG(HEIGHT),2) 평균키
FROM PLAYER
GROUP BY position
HAVING MAX(HEIGHT) >= 190;

