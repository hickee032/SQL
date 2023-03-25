
--���� ���̺� ����
CREATE TABLE userTBL (
    userID CHAR(8) NOT NULL PRIMARY KEY, --����� ���̵�
    userName NVARCHAR2(10) NOT NULL, --�̸�
    birthYear NUMBER(4) NOT NULL, --�������
    addr NCHAR(2) NOT NULL, --�ּ�
    mobile1 CHAR(3), --�޴��� ����
    mobile2 CHAR(8), --�޴��� ������ ��ȣ
    height NUMBER(3),--Ű
    mDate DATE --ȸ�� ������
    );

--ȸ�� ���� ���̺�    
CREATE TABLE buyTBL (
    idNum NUMBER(8) NOT NULL PRIMARY KEY,--����PK
    userID CHAR(8) NOT NULL, --���̵�(FK)
    prodName NCHAR(6) NOT NULL, --��ǰ��
    groupName NCHAR(4), --�з�
    price NUMBER(8) NOT NULL, --�ܰ�
    amount NUMBER(3) NOT NULL,--����
    FOREIGN KEY(userID) REFERENCES userTBL(userID)
    );    


INSERT INTO usertbl VALUES('LSG','�̽±�',1987,'����','011','11111111',182,'2008-8-8');
INSERT INTO usertbl VALUES('KBS','�����',1979,'�泲','011','22222222',173,'2012-4-4');
INSERT INTO usertbl VALUES('KKH','���ȣ',1971,'����','019','33333333',177,'2007-7-7');
INSERT INTO usertbl VALUES('JYP','������',1950,'���','011','44444444',166,'2009-4-4');
INSERT INTO usertbl VALUES('SSK','���ð�',1979,'����',NULL,NULL,186,'2013-12-12');
INSERT INTO usertbl VALUES('LJB','�����',1963,'����','016','66666666',182,'2009-9-9');
INSERT INTO usertbl VALUES('YJS','������',1969,'�泲',NULL,NULL,170,'2005-5-5');
INSERT INTO usertbl VALUES('EJW','������',1972,'���','011','88888888',174,'2014-3-3');
INSERT INTO usertbl VALUES('JKW','������',1965,'���','018','99999999',172,'2010-10-10');
INSERT INTO usertbl VALUES('BBK','�ٺ�Ŵ',1973,'����','010','00000000',176,'2013-5-5');

CREATE SEQUENCE idSEQ; --������ȣ �Է��� ���� ������ ����
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'KBS','�ȭ',NULL,30,2);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'KBS','��Ʈ��','����',1000,1);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'JYP','�����','����',200,1);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'BBK','�����','����',200,5);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'KBS','û����','�Ƿ�',50,3);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'BBK','�޸�','����',80,10);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'SSK','å','����',15,5);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'EJW','å','����',15,2);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'EJW','û����','�Ƿ�',50,1);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'BBK','�ȭ',NULL,30,2);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'EJW','å','����',15,1);
INSERT INTO buytbl VALUES(idSEQ.NEXTVAL,'BBK','�ȭ',NULL,30,2);

select *
from usertbl;

select *
from buytbl;

SELECT *FROM usertbl WHERE username = '���ȣ';

select userid,username from usertbl where birthyear >= 1970 and height >=182; 
select userid,username from usertbl where birthyear >= 1970 or height >=182; 

select username,height from usertbl where height >=180 and height <=183;
select username, height from usertbl where height between 180 and 183;

select username from usertbl where addr in('�泲','����','���');

--��������

select username,height from usertbl
where height >(select height from usertbl where username = '���ȣ');

--���� ���������� ��ȯ ���� 2��
select username, height from usertbl 
where height>(select height from usertbl where addr = '�泲');

--any ���������� ����� �ϳ��� �����ص� ��
select username, height from usertbl 
where height>=any(select height from usertbl where addr = '�泲');

--all ���������� ����� ��� �����ؾ� ��
select username, height from usertbl 
where height>=all(select height from usertbl where addr = '�泲');

