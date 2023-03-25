DROP TABLE EMPLOYEE; --���
DROP TABLE DEPARTMENT; --�μ�
DROP TABLE SALGRADE; --�޿����

--�μ�
CREATE TABLE DEPARTMENT
--DNO DNAME LOC �÷���
--CONSTRAINT �������� 
   (DNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY, --�μ���ȣ
   DNAME VARCHAR2(14), --�μ���
	 LOC   VARCHAR2(13) ) ; --�μ� ������
     
--���
CREATE TABLE EMPLOYEE 
    --�����ȣ (�⺻Ű)
   (ENO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	 ENAME VARCHAR2(20),
 	 JOB   VARCHAR2(10),
	 MANAGER  NUMBER(4), --�ش����� ��� ��ȣ
	 HIREDATE DATE, --�Ի���
	 SALARY NUMBER(7,2), --(7,2) �� �ϰ� �ڸ����� �Ҽ��� ���ڸ�
	 COMMISSION NUMBER(7,2), --���ʽ�
     --�μ���ȣ (����Ű)
	 DNO NUMBER(2) CONSTRAINT FK_DNO REFERENCES DEPARTMENT);
     
--�޿����
CREATE TABLE SALGRADE
   (GRADE NUMBER, --���
	 LOSAL NUMBER, --�޿� ���Ѱ�
	 HISAL NUMBER ); --�޿� ���Ѱ�

INSERT INTO DEPARTMENT VALUES (10,'ȸ��','����');
INSERT INTO DEPARTMENT VALUES (20,'����','�޶�');
INSERT INTO DEPARTMENT VALUES (30,'����','��ī��');
INSERT INTO DEPARTMENT VALUES (40,'����','������');

INSERT INTO EMPLOYEE VALUES
(7369,'���̽�','���',    7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7499,'�˷�','�Ǹſ�', 7698,to_date('20-2-1981', 'dd-mm-yyyy'),1600,300,30);
INSERT INTO EMPLOYEE VALUES
(7521,'����','�Ǹſ�',  7698,to_date('22-2-1981', 'dd-mm-yyyy'),1250,500,30);
INSERT INTO EMPLOYEE VALUES
(7566,'����','�Ŵ���',  7839,to_date('2-4-1981',  'dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7654,'��ƾ','�Ǹſ�',7698,to_date('28-9-1981', 'dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMPLOYEE VALUES
(7698,'����ũ','�Ŵ���',  7839,to_date('1-5-1981',  'dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7782,'Ŭ��ũ','�Ŵ���',  7839,to_date('9-6-1981',  'dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7788,'����','�м���',  7566,to_date('13-07-1987', 'dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7839,'ŷ','����', NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7844,'Ʃ��','�Ǹſ�',7698,to_date('8-9-1981',  'dd-mm-yyyy'),1500,0,30);
INSERT INTO EMPLOYEE VALUES
(7876,'�ƴ㽺','���',    7788,to_date('13-07-1987', 'dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7900,'���ӽ�','���',    7698,to_date('3-12-1981', 'dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7902,'����','�м���',   7566,to_date('3-12-1981', 'dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7934,'�з�','���',   7782,to_date('23-1-1982', 'dd-mm-yyyy'),1300,NULL,10);

INSERT INTO SALGRADE VALUES (1, 700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

COMMIT;

