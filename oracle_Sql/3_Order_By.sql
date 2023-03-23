--11/02_1

/*DUAL  TABLE
    ����Ŭ ���� ���� ���̺�
    �Լ��� ������� Ȯ���ҋ� ����ϴ� ���̺�
    SYSTEM ����ڰ� ������ ǥ�� ���̺� (��� ����ڳ� ���ٰ���)
    ���� ���÷��� ��� �ִ� Dummy ���̺�
    
    �Լ��� ������ �˰���� �� Ư�� ���̺��� ������ �ʿ� ���� DUAL���̺��� ���
    �Լ��� ���� ���Ϲ����� ���� */
    
--�Լ� (���ϰ��� ����) -- �Ʒ��� ����Ŭ������ ���, ǥ���� �ƴϴ�    
SELECT 'Oracle mania',
    UPPER('Oracle mania'), -- ���� �����
    LOWER('Oracle mania'), --���� �ҹ���
    INITCAP('Oracle mania') --�ܾ��� ù ���ڸ� �빮�ڷ� ��ȯ
from DUAL;

--LENGTH (�ѱ� 1����Ʈ)
select length('Oracle mania'),length('����Ŭ�ŴϾ�')
from DUAL;
--LENGTHB (�ѱ� 2����Ʈ)
select lengthb('Oracle mania'),lengthb('����Ŭ�ŴϾ�')
from DUAL;

/* ���� ó�� �Լ� (���� ���� �Լ�)
concat ������ �� ����
substr ���ڸ� �߶� ���� �ѱ� 1����Ʈ
substrb ���ڸ� �߶� ���� �ѱ� 2����Ʈ
instr Ư�� ������ ��ġ ���� ��ȯ �ѱ� 1����Ʈ
instrb Ư�� ������ ��ġ ���� ��ȯ �ѱ� 2����Ʈ
lpad,rpad �Է� ���� ���ڿ��� ��ȣ�� �����Ͽ� Ư������ �� ���ڿ��� ��ȯ
trim �߶󳻰� �������ڸ� ǥ�� */

/*�����Լ�
round Ư���ڸ������� �ݿø�
trunc Ư���ڸ������� �߶�(����)
mod �Է� ���� ���� ���� ������ */

select 98.7654,
    round(98.7654), --�Ҽ��� �ݿø� -> ������ ��ȯ
    round(98.7654,2), --�Ҽ��� �ι��� �ڸ� �ݿø�
    round(98.7654,-1) --�Ҽ��� �������� ��ȯ
from DUAL;    


select 98.7654,
    trunc(98.7654), --�Ҽ��� �߶�
    trunc(98.7654,2), --�Ҽ��� �ι��� �ڸ� �߶�
    trunc(98.7654,-1) --�Ҽ��� ���� �߶�
from DUAL;

/*��¥ �Լ�
SYSDATE �ý��� ���� ���� ��¥�� ��ȯ
MOTHS_BETWEEN �� ��¥ ������ ������
ADD_MONTHS Ư�� ��¥�� ������ ����
NEXT_DAT Ư����¥���� ���ʷ� �����ϴ� ���ڷ� ���� ������ ��¥�� ��ȯ
LAST_DAY �ش���� ������ ��¥
ROUND ���ڷ� ���� ��¥�� Ư�� �������� �ݿø�
TRUNC ���ڷ� ���� ��¥�� Ư�� �������� �߶�
*/

--���� ��¥
select sysdate
from DUAL;

--��¥ ����(��¥ + ����),(��¥ - ����)
--�� ��¥�κ��� ���ڸ�ŭ ���� ��¥�� ���
select sysdate -1 ����,
       sysdate ����,
       sysdate+1 ����
from DUAL;

--employee ���̺� ����� �ٹ��ϼ� ���
select ename �����, round(sysdate-hiredate) �ٹ��ϼ�
from employee;

--trunc �߶󳽴ٴ� �ǹ̰� �ణ �ٸ� �� ���� ù° �Ϸ� ����
--�ʱ�ȭ ����ϰ� ���� trunc(hiredate,'year') 80/12/17->80/01/01

select hiredate,
        trunc(hiredate,'year')
from employee;

select hiredate,
        trunc(hiredate,'month')
from employee;

--months_between ��¥�� ��¥ ������ ���� �� ���
select ename,sysdate,hiredate,
       months_between(sysdate,hiredate)--�Ҽ��� ǥ�õ�
from employee;

select ename,sysdate,hiredate,
       trunc(months_between(sysdate,hiredate))
from employee;

--add_months ���� ���� ���� 
select ename,hiredate,
       add_months(hiredate,6)
from employee;

--���ʷ� ���� ���Ͽ� �ش��ϴ� ��¥
select sysdate "���� ��¥",
       next_day(sysdate,'�����') "�̹� ������� ��¥"
from dual;

/* ����ȯ �Լ�
to_char ��¥ Ȥ�� �������� ����������
to_date �������� ��¥������
to_number �������� ����������
*/

select ename �����, hiredate �Ի���,
       to_char(hiredate,'YY-MM'),
       to_char(hiredate,'YYYY/MM/DD DAY')
from employee;

--�ѱ��� ����Ͽ� ����ϴ� ���
--'YY-MM' >> 'YY"��"MM"��"'
select ename �����, hiredate �Ի���,
       to_char(hiredate,'YY"��" MM"��"'),
       to_char(hiredate,'YYYY"��" MM"��" DD"��" DAY')
from employee;

--NVL NULL�� 0�̳� �ٸ� ������ ��ȯ
--NVL(a,b) a �� b�� �ٲ㼭 ���(���̺� �����Ϳ��� ������ ����)
select ename,salary,commission,
    nvl(commission,0),
    salary*12+ nvl(commission,0)
from employee
order by job;

--DECODE
--���ǿ� ���� �پ��� ����
--switch ���� �����
select ename,dno,
     decode(dno,10,'ACCOUNTING',
                20,'RESERCH',
                30,'SALES',
                40,'OPERRATING',
                'DEFALT') as dname
from employee
order by dno;

--�ѱ۵� ��� ����        
select ename ����� ,dno �μ���ȣ,
    decode(dno,10,'ȸ��',
               20,'����',
               30,'�Ǹ�',
               40,'����',
                'DEFALT') as dname
from employee
order by dno;

--CASE
--���ǿ� ���� �پ��� ����
--switch ���� �����

select ename �����,dno �μ���ȣ,
case when dno=10 then 'ACCOUNTING'
     when dno=20 then 'RESERCH'
     when dno=30 then 'SALES'
     when dno=40 then 'OPERRATING'
else 'DEFALT'
end as �μ���
   from employee
   order by dno;

--�ѱ� ���   
select ename �����,dno �μ���ȣ,
case when dno=10 then 'ȸ��'
     when dno=20 then '����'
     when dno=30 then '�Ǹ�'
     when dno=40 then '����'
else '���'
end as �μ���
   from employee
   order by dno;   
   
select ename �����,dno �μ���ȣ,
case when dno=10 then 'ȸ��'
     when dno=20 then '����'
     when dno=30 then '�Ǹ�'
     when dno=40 then '����'
else '�����'
end as �μ���,
case when 4000 <= salary  then '�ӿ�'
     when 3000 <= salary and salary <4000 then '����'
     when 2000 <= salary and salary <3000 then '�븮'
     when 1000 <= salary and salary <2000 then '���'
else '����'
end ����,
salary �޿�
   from employee
   order by salary desc;   

--�������� �Բ� ������ �ִ�.   
select ename �����,dno �μ���ȣ,
case when dno=10 then 'ȸ��'
     when dno=20 then '����'
     when dno=30 then '�Ǹ�'
     when dno=40 then '����'
else '�����'
end as �μ���,
case when 4000 <= salary  then '�ӿ�'
     when 3000 <= salary and salary <4000 then '����'
     when 2000 <= salary and salary <3000 then '�븮'
     when 1000 <= salary and salary <2000 then '���'
else '����'
end ����,
salary �޿�
   from employee
   order by salary desc;   
