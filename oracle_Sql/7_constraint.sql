--11/07_2

--������ ���Ἲ�� ��������
--��������
--���̺� ��ȿ�������� (��������) �����Ͱ� �ԷµǴ� ���� ����
--���̺� ����������

/*
NOT NULL NULL�� �������� ���ϰ�
UNIQUE ��� �ο쿡 ���ؼ� ������ ���� ��������
PRIMARY KEY �ߺ��� ���� NULL�� ��� ������� ����
FOREIGN KEY �����Ǵ� ���̺� Į�� ���� �׻� �����ؾ��� NULL���� �ȵȴ� (NOT NULL + UNIQUE)
CHECK ���� ������ ������ ���� ������ ������ �����Ͽ� ������ ���� ���
*/

/*NOT NULL*/
CREATE TABLE customer (
ID VARCHAR2(20) NOT NULL,
pwd VARCHAR2(20) NOT NULL,
NAME VARCHAR2(20) NOT NULL,
phone VARCHAR2(30),
address VARCHAR2(100));

--���� : ORA-01400: NULL�� ("TEST"."CUSTOMER"."ID") �ȿ� ������ �� �����ϴ�
INSERT INTO customer VALUES (NULL,NULL,NULL,'010-111-1111','SEOUL');
INSERT INTO customer VALUES ('','','','010-111-1111','SEOUL');
--�̷��� �ϸ� �� ������ �̷����ؼ��� �ȵȴ�
INSERT INTO customer VALUES (' ',' ',' ','010-111-1111','SEOUL');

--UNIQUE Ư�� Į���� ��簪�� �����ϰ� �����ǵ��� �ϴ� ����Ű�� ���� 
--����Ŭ�� ��� ����Ű�� ���� �ε����� �Խ������� ����

CREATE TABLE CUSTOMER (
ID VARCHAR2(20) UNIQUE,
PWD VARCHAR2(20) NOT NULL,
NAME VARCHAR2(20) NOT NULL,
PHONE VARCHAR2(30),
ADDRESS VARCHAR2(100));

--�������ǿ� �̸��� ���� CONSTRAINT ���������̸� ��������
CREATE TABLE CUSTOMER (
ID VARCHAR2(20) CONSTRAINT CUSTOMER_ID_UK UNIQUE,
PWD VARCHAR2(20) CONSTRAINT CUSTOMER_PWD_NN NOT NULL,
NAME VARCHAR2(20) CONSTRAINT CUSTOMER_NAME_NN NOT NULL,
PHONE VARCHAR2(30),
ADDRESS VARCHAR2(100));

--������ ����?

--PRIMARY KEY
--���̺� �⺻Ű ����
--�ߺ��� �����͸� ���� ���� ���ϴ� �������� �ο���
--NULL ���� ������ ���� 
--���̺��� ��� �ο츦 �����ϱ����� �ĺ��ڸ� ����

--�⺻Ű PRIMARY KEY ����
--CONSTRAINT ��� - ���������� �̸��� �����
CREATE TABLE CUSTOMER (
ID VARCHAR2(20) ,
PWD VARCHAR2(20) NOT NULL,
NAME VARCHAR2(20) NOT NULL,
PHONE VARCHAR2(30),
ADDRESS VARCHAR2(100),
CONSTRAINT CUSTOMER_ID_PK PRIMARY KEY(ID));

--CONSTRAINT - ���������� �̸��� ���� ���� ��� (���������� �̸��� ����Ŭ���� �ڵ����� �ο�)
CREATE TABLE CUSTOMER (
ID VARCHAR2(20) PRIMARY KEY,
PWD VARCHAR2(20) NOT NULL,
NAME VARCHAR2(20) NOT NULL,
PHONE VARCHAR2(30),
ADDRESS VARCHAR2(100));

--FIREIGN KEY ����Ű
--���� ���Ἲ�� ���̺�� ���̺� ������ �������� ������ ���� ��������

--FIREIGN KEY ����   CONSTRAINT ~ REFERENCES ~  �ݵ�� �ʿ��ϴ�
CREATE TABLE EMP_SECOND (
ENO NUMBER(4) CONSTRAINT EMP_SECOND_ENO_PK PRIMARY KEY ,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
DNO NUMBER(4) CONSTRAINT EMP_SECOND_DNO_FK REFERENCES DEPARTMENT);

DROP TABLE EMP_SECOND;

CREATE TABLE EMP_SECOND (
ENO NUMBER(4) CONSTRAINT EMP_SECOND_ENO_PK PRIMARY KEY ,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
DNO NUMBER(4) REFERENCES DEPARTMENT);

--CHECK
--�÷����� ��밡���� �������� ������ ������ ����
--������ �̿��� ���� ������ �����޼����� �Բ� ����� �������� ���ϰ� ��
--CHECK ���� ������ ���� ������ ���� CURRVAL,NEXTVAL,ROWNUM ���� �ǻ� �÷� SYSDATE,USER �� ���� �Լ����� ��� ���� 

CREATE TABLE EMP_SECOND(
ENO NUMBER(4) CONSTRAINT EMP_SECOND_ENO_PK PRIMARY KEY,
ENAME VARCHAR2(10),
SALARY NUMBER(4) CONSTRAINT EMP_SECOND_SALARY_MIN CHECK (SALARY >0));

CREATE TABLE CUSTOMER_2 (
ID VARCHAR2(20) NOT NULL CHECK(ID NOT IN(' ')) PRIMARY KEY,
PWD VARCHAR2(20) NOT NULL CHECK(PWD NOT IN(' ')),
NAME VARCHAR2(20) NOT NULL CHECK(NAME NOT IN(' ')),
PHONE VARCHAR2(30),
ADDRESS VARCHAR2(100));

INSERT INTO customer_2 VALUES (' ',' ',' ','010-111-1111','SEOUL');

/*DEFAULT 
    � ���� �Է����� �ʾ����� DEFAULT ���� �Էµ� */
DROP TABLE EMP_SECOND;

CREATE TABLE EMP_SECOND(
ENO NUMBER(4) CONSTRAINT EMP_SECOND_ENO_PK PRIMARY KEY,
ENAME VARCHAR2(10),
SALARY NUMBER(7,2) DEFAULT 1000);

--����: ORA-00947: ���� ���� ������� �ʽ��ϴ�
INSERT INTO EMP_SECOND VALUES (1111,'�ص�');
--�÷����� ������� ������� ��� �����͸� �Է��ؾ��Ѵ�
INSERT INTO EMP_SECOND (ENO,ENAME) VALUES (1111,'�ص�');

--���� ������ �߰� 
--ALTER ADD CONSTRAINT
--���� ������ ���� 
--ALTER DROP CONSTRAINT
--�Ͻ������� ���� ���� ���ֱ�
--ENABLE, DISABLE
 
/**/
--������ ���Ἲ
