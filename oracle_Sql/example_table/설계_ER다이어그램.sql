--11/14
-- ������ ���̽� ����
--�����ͺ��̽��� ��Ű�� ���� ���̺�, �ε���, �� ���� �����ͺ��̽� ��ü�� �����ϴ� ��.
--�ֵ� ������ ���̺��� �̸��̳� ��, �ڷ����� �����ϴ� ��.
--���̺� ���� ���踦 �����ϸ� ���� ���̺��� ���� �ϰ� �ۼ��ϴ� ��.

--��Ű��
--�����ͺ��̽��� ������ �������ǿ� ���� ���������� ����� ��

-- ER���̾�׷�
-- ERD (Entity Relationship Diagram)

-- 1.�䱸���� �м� (������ �𵨸�)
-- ����� �߷����� ����

-- 2.���� �𵨸�
-- ER�𵨸� ����
-- ��ƼƼ,����,�Ӽ�,�ĺ��� 
-- ���̺�, Į��, ���� 

-- 3.������ �𵨸�
-- ���̺� ����
-- ��ƼƼ,����,�Ӽ�,�ĺ��ڸ� ���̺�, Į��, ����� ��ȯ

-- 4.����
-- ���� ����Ͽ� ���� �𵨸�,������ �𵨸��� ���� ǥ���ϱ⵵ �Ѵ�.

--ER���̾�׷��� �����Ͽ� ���̺� ����

--����,�л�,���� ���̺�

--���� ���̺�
drop table professor_t;

create table professor_t (
pf_num varchar2(10) primary key,
pf_name varchar2(10),
pf_major varchar2(20)
);

--�л����̺�
create table stu_t (
st_num varchar2(10) PRIMARY key,
st_name varchar2(10),
st_major varchar2(10),
st_pf_num varchar2(10)  REFERENCES professor_t
);

drop table major_t;
--�������̺�
create table major_t(
major_num varchar2(10) PRIMARY key,
major_name varchar2(20),
major_score number,
major_pf_num varchar2(10) REFERENCES professor_t
);

drop table stu_t;
--�л����̺�
create table stu_t (
st_num varchar2(10) PRIMARY key,
st_name varchar2(10),
st_major varchar2(20),
st_pf_num varchar2(10)  REFERENCES professor_t
);

--�������̺�
drop table sign_t;


create table sign_t (
st_num varchar2(10) REFERENCES stu_t,
major_num varchar2(10) REFERENCES major_t,
PRIMARY key(st_num,major_num)
);

insert into professor_t VALUES ('P001','ȫ�浿','��ǻ���а�');
insert into stu_t VALUES ('S001','�̰���','��ǻ���а�','P001');
insert into major_t VALUES ('B001','��ǻ���а�',3,'P001');
insert into sign_t VALUES ('S001','B001');
