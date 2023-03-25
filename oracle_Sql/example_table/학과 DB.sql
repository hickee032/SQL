

-- major_table Table Create SQL
CREATE TABLE major_table(
    m_no        VARCHAR2(20)    NOT NULL, 
    m_name      VARCHAR2(20)    NOT NULL, 
    m_office    VARCHAR2(20)    NOT NULL, 
    m_call      VARCHAR2(20)    NOT NULL, 
     PRIMARY KEY (m_no)
);

COMMENT ON TABLE major_table IS '�а�';
COMMENT ON COLUMN major_table.m_no IS '�а���ȣ';
COMMENT ON COLUMN major_table.m_name IS '�а���';
COMMENT ON COLUMN major_table.m_office IS '�繫��';
COMMENT ON COLUMN major_table.m_call IS '��ȭ��ȣ';


-- professor_table Table Create SQL
CREATE TABLE professor_table(
    pf_no        VARCHAR2(20)    NOT NULL, 
    pf_rr        VARCHAR2(20)    NOT NULL, 
    pf_name      VARCHAR2(20)    NOT NULL, 
    pf_addr      VARCHAR2(60)    NOT NULL, 
    pf_call      VARCHAR2(20)    NOT NULL, 
    pf_pos       VARCHAR2(20)    NOT NULL, 
    pf_indate    DATE            NOT NULL, 
    pf_major     VARCHAR2(20)    NOT NULL, 
     PRIMARY KEY (pf_no)
);

COMMENT ON TABLE professor_table IS '����';
COMMENT ON COLUMN professor_table.pf_no IS '������ȣ';
COMMENT ON COLUMN professor_table.pf_rr IS '�ֹι�ȣ';
COMMENT ON COLUMN professor_table.pf_name IS '�̸�';
COMMENT ON COLUMN professor_table.pf_addr IS '�ּ�';
COMMENT ON COLUMN professor_table.pf_call IS '��ȭ��ȣ';
COMMENT ON COLUMN professor_table.pf_pos IS '����';
COMMENT ON COLUMN professor_table.pf_indate IS '�ӿ�⵵';
COMMENT ON COLUMN professor_table.pf_major IS '�а���ȣ';

--professor_table ��������
ALTER TABLE professor_table
    ADD CONSTRAINT FK_professor_table_pf_major_major_table_m_no FOREIGN KEY (pf_major)
        REFERENCES major_table (m_no);

-- subject_table Table Create SQL
CREATE TABLE subject_table(
    sub_no        VARCHAR2(20)     NOT NULL, 
    sub_name      VARCHAR2(50)     NOT NULL, 
    sub_score     INT              NOT NULL, 
    sub_year      VARCHAR2(20)     NOT NULL, 
    sub_sem       NVARCHAR2(20)    NOT NULL, 
    sub_office    NVARCHAR2(20)    NOT NULL, 
    sub_pe        INT              NOT NULL, 
     PRIMARY KEY (sub_no)
);

COMMENT ON TABLE subject_table IS '����';
COMMENT ON COLUMN subject_table.sub_no IS '���¹�ȣ';
COMMENT ON COLUMN subject_table.sub_name IS '���¸�';
COMMENT ON COLUMN subject_table.sub_score IS '����';
COMMENT ON COLUMN subject_table.sub_year IS '����';
COMMENT ON COLUMN subject_table.sub_sem IS '�б�';
COMMENT ON COLUMN subject_table.sub_office IS '���ǽ�';
COMMENT ON COLUMN subject_table.sub_pe IS '�����ο�';

-- student_table Table Create SQL
CREATE TABLE student_table(
    std_no          VARCHAR2(20)    NOT NULL, 
    std_rr          VARCHAR2(20)    NOT NULL, 
    std_name        VARCHAR2(20)    NOT NULL, 
    std_addr        VARCHAR2(60)    NOT NULL, 
    std_call        VARCHAR2(20)    NOT NULL, 
    std_major_no    VARCHAR2(20)    NOT NULL, 
     PRIMARY KEY (std_no)
);

COMMENT ON TABLE student_table IS '�л�';
COMMENT ON COLUMN student_table.std_no IS '�й�';
COMMENT ON COLUMN student_table.std_rr IS '�ֹι�ȣ';
COMMENT ON COLUMN student_table.std_name IS '�̸�';
COMMENT ON COLUMN student_table.std_addr IS '�ּ�';
COMMENT ON COLUMN student_table.std_call IS '��ȭ��ȣ';
COMMENT ON COLUMN student_table.std_major_no IS '�а���ȣ';

--student_table ��������
ALTER TABLE student_table
    ADD CONSTRAINT FK_student_table_std_major_no_major_table_m_no FOREIGN KEY (std_major_no)
        REFERENCES major_table (m_no); 



-- sign_table Table Create SQL
CREATE TABLE sign_table(
    sf_no        INT             NOT NULL, 
    sg_st_no     VARCHAR2(20)    NOT NULL, 
    sg_sub_no    VARCHAR2(20)    NOT NULL, 
    st_pf_no     VARCHAR2(20)    NOT NULL, 
    sf_score     VARCHAR2(20)    NOT NULL, 
     PRIMARY KEY (sf_no)
);

--sign_table_SEQ ������ ����
CREATE SEQUENCE sign_table_SEQ
START WITH 1
INCREMENT BY 1;


CREATE OR REPLACE TRIGGER sign_table_AI_TRG
BEFORE INSERT ON sign_table 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT sign_table_SEQ.NEXTVAL
    INTO :NEW.sf_no
    FROM DUAL;
END;


--DROP TRIGGER sign_table_AI_TRG; /

--DROP SEQUENCE sign_table_SEQ; /

COMMENT ON TABLE sign_table IS '���� ���';
COMMENT ON COLUMN sign_table.sf_no IS '��Ϲ�ȣ';
COMMENT ON COLUMN sign_table.sg_st_no IS '�й�';
COMMENT ON COLUMN sign_table.sg_sub_no IS '���¹�ȣ';
COMMENT ON COLUMN sign_table.st_pf_no IS '������ȣ';
COMMENT ON COLUMN sign_table.sf_score IS '����';


--sign_table ��������
ALTER TABLE sign_table
    ADD CONSTRAINT FK_sign_table_st_pf_no_professor_table_pf_no FOREIGN KEY (st_pf_no)
        REFERENCES professor_table (pf_no);

ALTER TABLE sign_table
    ADD CONSTRAINT FK_sign_table_sg_sub_no_subject_table_sub_no FOREIGN KEY (sg_sub_no)
        REFERENCES subject_table (sub_no); 

ALTER TABLE sign_table
    ADD CONSTRAINT FK_sign_table_sg_st_no_student_table_std_no FOREIGN KEY (sg_st_no)
        REFERENCES student_table (std_no);
/
--------------------------------------------------------------------------------------------
--major_table
insert into major_table values ('M001','�İ���','A201','021112222');
insert into major_table values ('M002','����','A203','023334444');
insert into major_table values ('M003','�̼���','A205','025556666');
insert into major_table values ('M005','�濵��','A301','027778888');
insert into major_table values ('M006','���а�','A303','029990000');

select * from major_table;

--professor_table
insert into professor_table values ('P001','780902','�豳��','�����','01011112222','����',(select sysdate from dual),'M001');
--random �Լ� ���
insert into professor_table values ('P002',(select to_char(trunc(DBMS_random.value(700000,909999)))
from dual),'�̱���','�ϳ���',random_call,'�α���',random_date,'M001');
insert into professor_table values ('P003',(select to_char(trunc(DBMS_random.value(700000,909999)))
from dual),'�ڱ���','������',random_call,'������',random_date,'M002');
insert into professor_table values ('P004',(select to_char(trunc(DBMS_random.value(700000,909999)))
from dual),'������','��õ��',random_call,'����',random_date,'M002');

select * from professor_table;
delete from professor_table;

--�������� �ֹι�ȣ ���ڸ� ����
select to_char(trunc(DBMS_random.value(700000,909999)))
from dual;
--���� ���� 
create or replace function random_date
return varchar2
is
f_loc varchar2(20);   
f_num number := trunc(DBMS_random.value(1,10));
begin
case f_num when 1 then  f_loc := '�����';
           when 2 then  f_loc := '������';
           when 3 then  f_loc := '�뱸��';
           when 4 then  f_loc := '�λ��';
           when 5 then  f_loc := '��õ��';
           when 6 then  f_loc := '���ֽ�';
           when 7 then  f_loc := '����';
           when 8 then  f_loc := '���ֽ�';
           when 9 then  f_loc := '������';
           when 10 then  f_loc := '������';
return f_loc;        
end; 
/

--�������� ��¥ ����
create or replace function random_date
return varchar2
is
f_date varchar2(50);   
f_year number := trunc(DBMS_random.value(15,23));
f_month number := trunc(DBMS_random.value(10,12));
f_day number := trunc(DBMS_random.value(01,30));
begin
f_date := to_char(f_year)||'/'||to_char(f_month)||'/'||to_char(f_day);       
return f_date;        
end; 
/

--�������� ��ȭ��ȣ ����
create or replace function random_call
return varchar2
is
f_call varchar2(50);   
f_first varchar2(3) := '010';
f_second number := trunc(DBMS_random.value(0001,9999));
f_third number := trunc(DBMS_random.value(0001,9999));
begin
f_call := f_first||to_char(f_second)||to_char(f_third);       
return f_call;        
end; 
/

SET SERVEROUTPUT ON  
BEGIN
DBMS_OUTPUT.PUT_LINE(random_call);
END;

/*
select to_char(trunc(DBMS_random.value(05,22)))||'/'||to_char(trunc(DBMS_random.value(01,12)))||'/'||
(select to_char(trunc(DBMS_random.value(01,12))),
    if 
from dual;
*/


