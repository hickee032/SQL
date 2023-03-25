--1 DBMS(RDBMS) ���� -> (����Ŭ) 
--2 ���̺� ���� -> �����͸� �ֱ� ���� Ʋ�̶�� �����ϸ� ��
--  ���� �����Ͱ� ����Ǵ� �� (2���� �迭�� ���� >> ��row�� ��column�� ����)
--  column ���� �Ӽ�(��ȣ,�̸�,�ּ� ��)�� �����Ѵ� (C ����ü ���� ���)
--3 SQL�� ����Ͽ� �����͸� ���
--  CRUD : C -> insert, R ->read, U->update, D->delete
--4 ���� �ܰ� (����ȭ)


/*
--���̺� ���� (���� �� �ҹ��� ������� -> �������� ���� �ҹ��ڸ� �ҹ��ڷ� �빮�ڸ� �빮�ڷ�)

CREATE TABLE customer_t (
    NAME VARCHAR2(20),
    age NUMBER,
    gender CHAR(1),
    rdate DATE DEFAULT sysdate
);

--������ �߰�
--insert into ���̺�� values �÷� ������

INSERT INTO customer_t (name,age,gender,rdate) 
VALUES ('ȫ�浿',100,'M',sysdate);

--�÷� ��� ������ �������� ������ ��ġ�ؾ��� ���� : ORA-00913
--�ݴ��� ��쵵 ���� �߻�
INSERT INTO customer_t (name,age,gender) 
VALUES ('ȫ�浿',100,'M',sysdate);

--�����Ұ�� ��������� �־������
insert into customer_t
values ('��浿',50,'M',sysdate);

--������ ���� oracle �������� ctrl+enter ����� f5 ������ �ణ �ٸ�
--select �÷��� from ���̺��;

--name �����͸� ��
select name from customer_t;
--age, gender �����͸� ��
select age,gender from customer_t;
--��� �����͸� ��
select * from customer_t;

*/


--������ Ÿ��
--VARCHAR2 �������� ���ڿ� ���� "ȫ�浿",'ȫ�浿'
--char �������� ���ڿ�
--number ���� ����
--int ���� ����
--date ��¥
--clob ��뷮 ���ڿ�
--blob �̹��� ������ ����



--���̺� ���� ���� 01
--�л� ���̺� �й� �̸� ���� �ּ� ��ȭ��ȣ �̸��� ī��ID
--�й� ���� ���� ������ ���ڿ�
--10���� ������ insert
--select ������ ���

CREATE table student_t(
st_no number,
name VARCHAR2(20),
age number,
addr VARCHAR2(40),
phone VARCHAR2(20),
e_mail VARCHAR2(20),
k_id VARCHAR2(20)
);

insert into student_t
values ('001','������',22,'�뱸','010-1234-1234','AAA@mail','AAA');
insert into student_t
values ('002','�ٶ�',24,'����','010-3278-1234','BBB@mail','A135');
insert into student_t
values ('003','�ٻ��',21,'����','010-1784-1234','CCC@mail','C89');
insert into student_t
values ('004','������',25,'�λ�','010-1369-1234','DDD@mail','A56');
insert into student_t
values ('005','īŸ��',21,'����','010-1258-1234','EEE@mail','E12');
insert into student_t
values ('006','AAA',22,'�뱸','010-4637-1234','FFF@mail','FFF');
insert into student_t
values ('007','BBB',20,'�λ�','010-5678-1234','GGG@mail','GGG');
insert into student_t
values ('008','CCC',21,'����','010-1234-1234','HHH@mail','HHH');
insert into student_t
values ('009','DDD',22,'����','010-0000-1234','UUU@mail','UUU');
insert into student_t
values ('010','EEE',23,'�뱸','010-7896-1234','QQQ@mail','QQQ');

--������ �Ѳ����� �ֱ�
INSERT INTO student_t
SELECT '001','EEE',23,'�뱸','010-7896-1234','QQQ@mail','QQQ' FROM DUAL
union all
SELECT '002','������',23,'����','010-6731-1234','aaa@mail','a11' FROM DUAL
union all
SELECT '003','������',24,'����','010-7891-1614','bbb@mail','bb2' FROM DUAL;

select* from student_t;

select ST_NO,NAME,ADDR from student_t;

select ST_NO,NAME,PHONE from student_t;

select name, age from student_t
where age >21;

--���̺� ����
--�÷� �߰� name2
alter table student_t add(name2 varchar2(40));
--�÷� ������ ���� 40->20
alter table student_t modify(name2 varchar2(20));


--���� �˻� select from where
select st_no, name, phone from student_t;

--�̸��� '������'
select st_no, name, phone from student_t
where name = '������';

select st_no, name, phone from student_t
where st_no = 001;

select * from student_t
where st_no = 001;

--���� �˻� and, or
select * from student_t
where addr = '�뱸' or addr = '�λ�' ;

delete from student_t;

-- not null�� NULL ���� ���� ��� ���� : ORA-01400
INSERT INTO cus_t
VALUES (NULL,'010-1234-1234',40,sysdate);










