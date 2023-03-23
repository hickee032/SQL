--11/07_1

-- ���� ����

--���� ������ ���� ����
select eno,ename,salary
from employee
where eno not in (select manager from employee where manager is not null group by manager);

--����ũ�� ������ �μ��� ���� ����� �Խ��� ����ũ ��� ����
select ename, hiredate,dno 
from employee
where dno = any(select dno from employee where ename in '����ũ') and  ename not in('����ũ');

--�ٹ����� �޶��� ����� �μ���ȣ ��� ���� ��� �̸� �������� (��������, ����)
select distinct e.ename, e.dno, e.job 
from employee e , department d
where e.dno = (select dno from department d where d.loc = '�޶�')
order by e.ename;

select e.ename, e.dno, e.job
from employee e inner join department d
on e.dno = d.dno
where d.loc in ('�޶�')
order by e.ename;

----------------------------------------------------------------------------------------------------
/*  create table ���̺� ����
    alter table ���̺� ���� ����
    rename ���̺� �̸� ����
    drop table ���̺� ���� ����
    truncate table ������ ����   */
    
-- ���� ����Ͽ� �ϴ� ��쵵 ����.

/*
alter table dept
    add(birth ,date);

drop table ���̺� ��
truncate table ���̺� ��
*/ 

--������ ���� insert update delete
--DML
--INSRTT INTO : ���̺� �����͸� �Է�
--���ڳ� ��¥��  ''

--�����͸� ������ ������ ����
CREATE TABLE DEPT_COPY
AS 
SELECT *FROM department WHERE 0= 1;

CREATE TABLE EMP_COPY
AS 
SELECT *FROM employee WHERE 0= 1;

--�÷����� ������ ���
--���� ���̺� ��õ� �÷��� ������� �Է��ؾ���
INSERT INTO DEPT_COPY VALUES (10,'ȸ��','����');

--�÷����� ����� ���
--��õ� �÷��� ������� �Է��ؾ���
INSERT INTO DEPT_COPY (DNO,LOC,DNAME )VALUES (20,'�޶�','����');

--NULL ���� ���� �ο� ����
--�Է½� NULL���� ���� (Į���� ����� ���)
INSERT INTO dept_copy (DNO,DNAME)VALUES (30,'�Ǹ�');

--�Է½� NULL���� ���
INSERT INTO DEPT_COPY VALUES (40,'����',NULL);

--��¥ ������ �Է½� ����Ŭ�� ��� YY/MM/DD �� ����
INSERT INTO EMP_COPY
VALUES (7000,'ĵ��','�Ŵ���',NULL,'2012/05/01',NULL,NULL,10);
--TO_DATE
INSERT INTO EMP_COPY
VALUES (8000,'�ص�','�Ǹſ�',NULL,TO_DATE(SYSDATE),NULL,NULL,10); 

--�ٸ� ���̺��� �����͸� �����ϱ�
/*INSERT INTO TABLE [(�÷�1,�÷�2]
SUBQUERY;*/

--���������� �̿��� �������� �Է�
INSERT INTO dept_copy
SELECT * FROM department;

--UPDATE ����
/*
UPDATE TABLE�̸�
SET �÷�1 = ��, �÷�2 = �� 
WHERE CONDITIONS;
*/

UPDATE dept_copy
SET DNAME = '����', LOC = '����'
WHERE DNO = 10;

UPDATE dept_copy
SET DNAME = 'HR';

--�ٸ� ���̺��� ������� �����͸� ����

UPDATE dept_copy
SET LOC = (SELECT LOC FROM dept_copy WHERE DNO = 20)
WHERE DNO = 10;


UPDATE dept_copy
SET DNAME = (SELECT DNAME FROM dept_copy WHERE DNO = 30),
LOC = (SELECT LOC FROM dept_copy WHERE DNO = 30)
WHERE DNO = 10;

--DELETE TKRWP
--WHERE���� �����ϸ� ���̺� �ִ� ������� ������

/*DELETE ���̺��
    WHERE ����*/
    
DELETE dept_copy
WHERE DNO = 10;

--�ٸ� ���̺� ������� �ο� ����

DELETE EMP_COPY
WHERE DNO = (SELECT DNO FROM department WHERE DNAME = '����');

/* Ʈ����� 
������ ó������ �������� �ϳ��� �۾�����
����Ŭ ��ɾ��� DDL DCL�� �ϳ��� ��ɾ �ϳ��� Ʈ�����
(���� �����ڸ� ; �����ݷ��� �������� �Ѵ�)
DML�� �������� ������ �ϰ����������� �ϳ� �̻��� DML���� �� �ϳ��� Ʈ�����

ALL OR NOTING �������� ��ɾ� ������ ���������� ó���Ǹ� ���� ���� ��ɾ��� �ϳ��� �߸��ȴٸ� ��ü�� ��� */

/*
DML ���� ����ʰ� ���ÿ� Ʈ������� ����
DML �۾��� ���� ó���Ǿ��ٸ� COMMIT ����ؾ��Ѵٸ� ROLLBACK

COMMIT Ʈ����� ó�������� �ݿ� ����� ������ ��� ���� ����
ROLLBACK Ʈ����� ó������ �� �߻��� ���� ������ ��� ROLLBACK ����� �ϳ��� ����ó�� ���� �������� ���ư� */