--11/09
--���� ����
--https://tantangerine.tistory.com/20

--�񱳿�����, ��������, SQL������ ����

--1.�Ҽ����� �Ｚ����������� �������� ���
SELECT player_name
FROM PLAYER
WHERE team_id IN('K02');
--2.�������� �̵��ʴ��� �������� ���
SELECT player_name
FROM PLAYER
WHERE POSITION IN ('MF');
--3.Ű�� 170CM�̻��� �������� ���
SELECT player_name
FROM PLAYER
WHERE HEIGHT >=170;
--4.�Ҽ����� �Ｚ��������̰ų� �����巡���� �Ҽ��� �������� ���
SELECT PLAYER_NAME
FROM PLAYER
WHERE TEAM_ID IN('K02') OR TEAM_ID IN('K07');

SELECT PLAYER_NAME
FROM PLAYER 
WHERE TEAM_ID = 'K02' OR TEAM_ID = 'K07';

--5.�Ｚ��������̰ų� �����巡���� �Ҽ��̸鼭 �������� �̵��ʴ��̰� Ű�� 170�̻� 180������ �������� ���
SELECT PLAYER_NAME
FROM PLAYER
WHERE TEAM_ID IN('K02') OR TEAM_ID IN('K07') AND POSITION IN ('MF') AND HEIGHT BETWEEN 170 AND 180;

--6.�Ｚ��������̰ų� �����巡���� �Ҽ��̸鼭 �������� �̵��ʴ��ƴϰ� Ű�� 170�̻� 180������ �������� ���
SELECT PLAYER_NAME
FROM PLAYER
WHERE TEAM_ID IN('K02') OR TEAM_ID IN('K07') AND POSITION NOT IN('MF') AND HEIGHT BETWEEN 170 AND 180;

--7.JOB�� MANAGER�̸鼭 20�� �μ��� ���ϰų� JOB�� CLERK�̸鼭 30�� �μ��� ���ϴ� ����� ������ ���
SELECT ENAME
FROM EMP
WHERE (JOB IN ('MANAGER') AND DEPTNO = 20 )OR (JOB IN ('CLERK') AND DEPTNO = 30);

--�������� ���� ������ ������ EXISTS
--1.������ ������ �Ҽӵ� ���� �����鿡 ���� ������ ���
SELECT P.TEAM_ID,PLAYER_ID,P.player_name,p.position
FROM PLAYER P
WHERE TEAM_ID IN (SELECT TEAM_ID FROM PLAYER WHERE PLAYER_NAME IN('������'));

--2.�������� Ű�� ��� ������ �������� ������ ���
SELECT PLAYER_NAME ,HEIGHT
FROM PLAYER
WHERE HEIGHT <(SELECT AVG(HEIGHT) FROM PLAYER);

--3.�� �μ��� �޿���պ��� �� ���� �޴� ����� �����ȣ, �̸�, �޿��� ���
SELECT DEPTNO,EMPNO,ENAME,SAL 
FROM EMP
WHERE SAL > ALL(SELECT AVG(SAL) FROM EMP GROUP BY DEPTNO)
ORDER BY DEPTNO;

--4.CHICAGO ������ �ٹ��ϴ� ����� �� BLACK�� ���� ����� ������� �����ȣ, �̸� ,���� ���
 SELECT EMPNO,ENAME,JOB
 FROM EMP
 WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT WHERE LOC IN ('CHICAGO'));

--5.�� �μ� ���� �ְ�޿��� �޴� ������ ������ȣ, �̸�, �޿��� ���
SELECT DEPTNO, EMPNO, ENAME ,SAL
FROM EMP
WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO)
ORDER BY DEPTNO;

--6.20120501 ���� 20120502 ���̿� ��Ⱑ �ִ� ������� ���
SELECT STADIUM_ID,STADIUM_NAME
FROM STADIUM
WHERE STADIUM_ID IN (SELECT STADIUM_ID FROM SCHEDULE WHERE sche_date BETWEEN '20120501' AND '20120502');

SELECT STADIUM_ID ,STADIUM_NAME
FROM STADIUM A
WHERE EXISTS (SELECT 1 FROM SCHEDULE X WHERE X.stadium_id = A.stadium_id
AND X.sche_date BETWEEN '20120501' AND '20120502');

--7.�Ҽ����� Ű�� ���� ���� ������� ������ ���
SELECT TEAM_ID, PLAYER_ID, PLAYER_NAME,HEIGHT
FROM PLAYER
WHERE (TEAM_ID,HEIGHT) IN (SELECT TEAM_ID,MIN(HEIGHT) FROM PLAYER GROUP BY TEAM_ID);

--8.�� �μ����� �ְ�޿��� �޴� ������ ������ȣ, �̸�, �޿� ���
SELECT DEPTNO,EMPNO, ENAME, SAL
FROM EMP
WHERE SAL IN(SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

--9.K���� ������տ��� �������� �̵��ʴ��� �������� �Ҽ����� ���������� ���
--10.K���� �������߿��� ���� Ű�� ū ���� 5���� ���
--11.�ֱ� �Ի��� 5���� ����� ���
--12.����� �޿��� ������������ ��� ������ ���
--13.����̸��� �޿��� �ְ� ���� ������ �����ϰ� ������ ǥ���ϴ� Į���� �����Ͽ� ���
--14.�޿��� ���� �޴� 6~10��° ����� ���
--15.�Ｚ�������(K02)�� ���Ű���� ���� ���� �̸��� �ش� ���� ��� Ű�� ���
--16.����� �����ִ� �μ���ȣ�� �μ��̸��� ��� (�ߺ��� ������� �ʴ� ��)



--GROUP BY , HAVING ����

--1.�����Ǻ� �ο���, �ִ�Ű ,�ּ�Ű , ���Ű�� ��� �Ҽ��� 2�ڸ�
SELECT POSITION, COUNT(*) �ο���, MAX(HEIGHT) �ִ�Ű ,MIN(HEIGHT) �ּ�Ű , ROUND(AVG(HEIGHT),2) ���Ű
FROM PLAYER
GROUP BY POSITION
HAVING POSITION IS NOT NULL;

--2.K���� �������� �����Ǻ� ���Ű�� ���ϰ� ���Ű�� 180CM�̻��� ������ ���

SELECT position,COUNT(*), ROUND(AVG(HEIGHT)) ���Ű
FROM player
GROUP BY position
HAVING ROUND(AVG(HEIGHT)) >= 180;

--3.K���� �������� �Ｚ�������(K02)�� FC����(K09)�� �ο����� ���

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

--4.�����Ǻ��� ���Ű�� ��� �ִ�Ű�� 190CM�̻��� ������ �����ϰ� �ִ� �������� ������ ���
SELECT POSITION ������,ROUND(AVG(HEIGHT),2) ���Ű
FROM PLAYER
GROUP BY position
HAVING MAX(HEIGHT) >= 190;

