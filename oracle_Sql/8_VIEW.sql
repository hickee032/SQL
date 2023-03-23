--11/08
--view (��)
--�������� ���̺��� �ٰ��� ������ ���� ���̺� (�޸�)
--�ӵ��� ����
--��ũ ���� ������ �Ҵ���� ����
--���̺��� �Ļ��� ��ü ���̺�� ����

--�並 �������ؼ��� ������ �ʿ��ϴ� 
--�� ���� �ο� (SYSTEM �������� �ο�)
GRANT CREATE VIEW TO test;

/*
CREATE OR REPLACE  VIEW VIEWNAME AS SUBQUERY
[WITH CHECK OPTION]
[WITH READ ONLY]
*/

--�ܼ� �� �ϳ��� �⺻���̺�� ���� DML��ɹ� ���� DML��ɹ��� ó������� �⺻���̺� �ݿ�
--���� �� �ΰ��̻��� �⺻���̺�� ����

--�並 ����ϴ� ���� - ���Ȱ� ����� ���Ǽ� ����

--������ ���� ��
CREATE VIEW V_EMP_SAMPLE
AS
SELECT ENO,ENAME,JOB,MANAGER,DNO
FROM EMPLOYEE;

--������ �ս��� ������� ��
CREATE VIEW V_EMP_COMPLEX2
AS
SELECT E.ENO,E.ENAME,E.SALARY,DNO,D.DNAME,D.LOC
FROM EMPLOYEE E NATURAL JOIN DEPARTMENT D;

--USER_VIEWS ������ ����
SELECT VIEW_NAME, TEXT
FROM USER_VIEWS;

--��� �����͸� �����ϰ� ���� ���� ���� ���̺� ��ü�� ����
--�並 ���� �ҋ� CREAT VIEW ��ɾ� ���� AS���� ����� ���� ���� ��ü�� �����ߴٰ� �̸� ���� (CASH�� ����� CASH�� ���������� ���� VIEW�� �޸𸮿� ���� )

--�信 �׷��Լ� ��� (��Ī���)
--��Ī�� �÷���ó�� ����Ҽ� ����
CREATE VIEW V_EMP_SALARY
AS
SELECT DNO,SUM(SALARY) AS "SAL_SUM", AVG(SALARY) AS "SAL_AVG"
FROM EMPLOYEE
GROUP BY DNO;

CREATE VIEW V_EMP_SALARY
AS
SELECT DNO,SUM(SALARY) AS "�޿��հ�", ROUND(AVG(SALARY)) AS "�޿����"
FROM EMPLOYEE
GROUP BY DNO;

--�並 �̿��� ���� ����
SELECT * FROM V_EMP_SALARY ORDER BY DNO;
SELECT DNO,�޿��հ�,�޿���� FROM V_EMP_SALARY ORDER BY DNO;

--�䰡 �� �̻� �ʿ� ���� ���� 
--DROP VIEW �� �̸�
DROP VIEW V_EMP_SALARY;
--��� ���� ���̺��̱� ������ �並 ���� �Ѵٴ� ���� USER_VIEWS ������ ��ųʸ��� ����� ���� ���� �Ѵٴ� ��
--�並 �����ص� ���� ���̺� ������ ���� �ʴ� ��

--CREATE OR REPLACE VIEW 
--�̹� �����ϴ� �信 ���ؼ� �� ������ ���Ӱ� �����Ͽ� ����
--FORCE
--�⺻ ���̺��� ���翩�ο� ��� ���� �� ����

--WITH CHECK OPTION
--�ش� �並 ���ؼ� ���� �ִ� ���� �������� UPDATE, INSERT �� ����
--WITH READ ONLY
--�ش�並 ���ؼ��� SELECT�� ���� INSERT, UPDATE ,DELETE �Ҽ�����
--�̰��� �����Ѵٸ� INSERT, UPDATE ,DELETE ��� ����

--LEVEL : MANAGER�� �������� ���� 
SELECT LEVEL ���޼���,ENO ���, ENAME �����, JOB ������, SALARY �޿� FROM employee
START WITH MANAGER IS NULL CONNECT BY PRIOR ENO=MANAGER 
ORDER SIBLINGS BY MANAGER;
--ORDER SIBLINGS BY : ��ȸ�� ������ Į���� ���ؼ� ORDER BY ����
--CONNECT BY ���� �ڵ�� ���� �ڵ带 �̿��ؼ� TREE ���� ���


--����
--1.���޼���, ���, �����, ������, �Ŵ�����ȣ, �Ի��� ,�޿�, Ŀ�̼� , �μ���ȣ,�μ��� ���

SELECT LEVEL ���޼���,E.ENO ���, E.ENAME �����, E.JOB ������, E.MANAGER �Ŵ�����ȣ,E.HIREDATE �Ի���, E.SALARY �޿�,E.COMMISION Ŀ�̼�, E.DNO �μ���ȣ,D.DNAME �μ��� 
FROM employee E ,department D
WHERE E.DNO = D.DNO
START WITH MANAGER IS NULL CONNECT BY PRIOR ENO=MANAGER 
ORDER SIBLINGS BY '���޼���';

SELECT LEVEL ���޼���,E.ENO ���, E.ENAME �����, E.JOB ������, E.MANAGER �Ŵ�����ȣ,E.HIREDATE �Ի���, E.SALARY �޿�,E.COMMISION Ŀ�̼�,E.DNO �μ���ȣ,D.DNAME �μ��� 
FROM employee E INNER JOIN department D
ON E.DNO = D.DNO
START WITH MANAGER IS NULL CONNECT BY PRIOR ENO=MANAGER 
ORDER SIBLINGS BY '���޼���';

SELECT RANK() OVER (ORDER BY MANAGER ASC NULLS FIRST) AS ���޼���,E.ENO ���, E.ENAME �����, E.JOB ������, E.MANAGER �Ŵ�����ȣ,E.HIREDATE �Ի���, E.SALARY �޿�,E.COMMISION Ŀ�̼�,E.DNO �μ���ȣ,D.DNAME �μ��� 
FROM employee E INNER JOIN department D
ON E.DNO = D.DNO
ORDER BY '���޼���';

--���� �Ⱦ��� �ϴ� ���
--�������� 
--SELECT���� ��������
SELECT LEVEL ���޼���,E.ENO ���,E.ENAME �����, E.JOB ������, E.MANAGER �Ŵ�����ȣ,E.HIREDATE �Ի���, E.SALARY �޿�,E.COMMISSION Ŀ�̼�,E.DNO �μ���ȣ, 
(SELECT DNAME FROM department WHERE E.ENO = DNO) �μ���
FROM employee E
START WITH MANAGER IS NULL CONNECT BY PRIOR ENO=MANAGER
ORDER SIBLINGS BY '���޼���';

SELECT LEVEL ���޼���,E.ENO ���,E.ENAME �����, E.JOB ������, E.MANAGER �Ŵ�����ȣ,E.HIREDATE �Ի���, E.SALARY �޿�,NVL(E.COMMISSION,0) Ŀ�̼�,E.DNO �μ���ȣ, 
(SELECT DNAME FROM department WHERE E.ENO = DNO) �μ���
FROM employee E
START WITH MANAGER IS NULL CONNECT BY PRIOR ENO=MANAGER
ORDER SIBLINGS BY '���޼���';

--CASE ~WHEN ~THEN END 
SELECT LEVEL ���޼���,ENO ���,ENAME �����, JOB ������, MANAGER �Ŵ�����ȣ,HIREDATE �Ի���, SALARY �޿�,COMMISSION Ŀ�̼�,DNO �μ���ȣ, 
CASE WHEN DNO = 10 THEN 'ȸ��'
     WHEN DNO = 20 THEN '����'
     WHEN DNO = 30 THEN '����'
     WHEN DNO = 40 THEN '����'
END AS �μ��� 
FROM employee
START WITH MANAGER IS NULL CONNECT BY PRIOR ENO=MANAGER
ORDER SIBLINGS BY '���޼���';

--1���� ��� ���� - ���� ���� ������������ ����

CREATE OR REPLACE VIEW staff_list
AS
SELECT LEVEL ���޼���,E.ENO ���, E.ENAME �����, E.JOB ������, E.MANAGER �Ŵ�����ȣ,E.HIREDATE �Ի���, E.SALARY �޿�,E.COMMISSION Ŀ�̼�,E.DNO �μ���ȣ,D.DNAME �μ��� 
FROM employee E INNER JOIN department D
ON E.DNO = D.DNO
START WITH MANAGER IS NULL CONNECT BY PRIOR ENO=MANAGER 
ORDER SIBLINGS BY MANAGER;

SELECT *
FROM staff_list
ORDER BY ���޼���;

--������ SEQUENCE
--���̺��� ������ ���ڸ� �ڵ����� ���� 

/*
CREATE SEQUENCE_NAME
        START WITH N -- �������� ���� ��ȣ 
        INCREMENT BY N -- ������ ������
        MAXVALUE N OR NOMAXVALUE --�������� ������ �ִ� �ִ밪 ASCENDING 10�� 27�� DESCENDING -1
        MINVALUE N OR NOMINVALUE --�������� ������ �ִ� �ּҰ� DESCENDING 10�� 26��
        CYCLE OR NOCYCLE --�������� �ִ밪���� �������� �ٽ� START WITH ������ NOCYCLE�� ������ �Ϸ�Ǹ� ������ ���� 
        CACHE N OR NOCACHE --�޸𸮻󿡼� �������� ���� ���� 
*/

--���� ������
CREATE SEQUENCE SAMPLE_SEQ
    INCREMENT BY 10 -- 10�� ������
    START WITH 10; -- 10���� ������

--���� ������
CREATE SEQUENCE emp_seq
    INCREMENT BY -10 --10�� ������
    START WITH 1000; --1000���� ������

--CURRVAL --�������� ���� �� (CURRVAL �� ���ΰ��� �Ҵ�Ǳ� ���ؼ��� NEXTVAL�� ���ο� ���� �����ؾ���)
--NEXTVAL --�������� ���� �� (NEXTVAL�� ���ο� ���� ������ ���� �̰��� CURRVAL�� ��ü)

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
--���̺� �����͸� �����Ŀ� �ٽ� ������ 10���Ͱ� �ƴ� 20���� �־��� �ٽ� 10���� �ֱ����ؼ��� �������� ������ �־����



--�������� �����ҷ��� 
--ALTER SEQUENCE
ALTER SEQUENCE DNO_SEQ
MAXVALUE 50;

--������ ����
DROP SEQUENCE DNO_SEQ;

--�ε��� INDEX
--�˻� ������ ��� ��Ű������ ���(���� �ǵڿ� �������� ��)
--�⺻Ű�� ����Ű�� �ε����� �ڵ����� ������
--������ ������ ���ٰ� ���� �� �ƴ�

/*
CREATE INDEX INDEX_NAME
ON TABLE_NAME (�÷���);
*/

--�ε��� ����
CREATE INDEX IDX_EMP_ENAME
ON EMPLOYEE(ENAME);
--�ε��� ����
DROP INDEX IDX_EMP_ENAME;

--�ε����� ��� �ؾ��ϴ� ���
--���̺��� ���� �� �� ���� ���
--WHERE ���� �ش� Į���� ���� ���ɶ�
--�˻������ ��ü �������� 2~4% ���� �϶�
--JOIN�� ���� ���Ǵ� Į���̳� NULL�� �����ϴ� Į���� ���� ���

--�ε����� ������� ���ƾ��ϴ� ���
--���� �ݴ� 
--�˻������ ��ü �������� 10~15% ���� �϶�
--���̺� DML�۾��� ���� ��� �Է� ���� �������� ���� ���
