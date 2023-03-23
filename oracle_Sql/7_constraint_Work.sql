--11/07 ��������

--�л� ���̺� STUDENT_T
--ID ���ڿ� 5 �⺻Ű ,NAME ���ڿ� 10, NULL �ƴ�
--���� ���� NULL �ƴ�, ���� ���ڿ� 5 NULL �ƴ�
--�г� ���ڿ� 10 NULL �ƴ� �ּ� ���ڿ� 50 NULL�ƴ�
-- ���̵� (�⺻Ű) ���� (19�� �̻�)  ���� (��, ��) �г� (1�г�,2�г�,3�г�,4�г�)
DROP TABLE STUDENT_T;

CREATE TABLE student_t(
ID VARCHAR2(5) PRIMARY KEY,
NAME VARCHAR2(10) NOT NULL,
age NUMBER NOT NULL CHECK(age >= 19),
gender VARCHAR2(5) NOT NULL CHECK(gender IN ('��','��')),
grade VARCHAR2(10) NOT NULL CHECK (grade IN ('1�г�','2�г�','3�г�','4�г�')),
addr VARCHAR2(50) NOT NULL
);

INSERT INTO student_t VALUES ('kkk','�谡��',21,'��','3�г�','�뱸��');
--�⺻Ű �ߺ� ���� : ORA-00001: ���Ἲ ���� ����
INSERT INTO student_t VALUES ('kkk','�豸��',20,'��','2�г�','�뱸��');
--CHECK AGE ���� : ORA-02290: üũ ��������
INSERT INTO student_t VALUES ('kHH','������',18,'��','1�г�','�����');
--CHECK GENDER ���� : ORA-02290: üũ ��������
INSERT INTO student_t VALUES ('kSS','�����',22,'?','2�г�','��õ��');
--CHECK GRADE ���� : ORA-02290: üũ ��������
INSERT INTO student_t VALUES ('kMM','��̹�',19,'��','5�г�','�λ��');

--ALTER ���

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
ALTER TABLE STUDENT_T2 MODIFY GENDER NOT NULL ADD(CHECK(GENDER IN ('��','��')));
ALTER TABLE STUDENT_T2 MODIFY GRADE NOT NULL ADD(CHECK(GRADE IN ('1�г�','2�г�','3�г�','4�г�')));
ALTER TABLE STUDENT_T2 MODIFY ADDR NOT NULL;

INSERT INTO student_t2 VALUES ('kkk','�谡��',21,'��','3�г�','�뱸��');
--�⺻Ű �ߺ� ���� : ORA-00001: ���Ἲ ���� ����
INSERT INTO student_t2 VALUES ('kkk','�豸��',20,'��','2�г�','�뱸��');
--CHECK AGE ���� : ORA-02290: üũ ��������
INSERT INTO student_t2 VALUES ('kHH','������',18,'��','1�г�','�����');
--CHECK GENDER ���� : ORA-02290: üũ ��������
INSERT INTO student_t2 VALUES ('kSS','�����',22,'?','2�г�','��õ��');
--CHECK GRADE ���� : ORA-02290: üũ ��������
INSERT INTO student_t2 VALUES ('kMM','��̹�',19,'��','5�г�','�λ��');

RENAME student_t1 TO student_t;