--11/03
--���� ����

--�з� ���� ������ ���� ��� �� �μ�����
select dno,count(*)
from employee
where salary > (select salary from employee where ename = '�з�')
group by dno
order by dno asc;

--Ŭ��ũ ���� ���� �Ի��� ���
select ename 
from employee
where hiredate <= (select hiredate from employee where ename = 'Ŭ��ũ');

-- �μ���ȣ,�μ� �̸�, ������,�����, �μ� �μ����� ������� ��� �޿���� inner join
select d.dno �μ���ȣ,d.dname �μ��� ,d.loc �ٹ���, count(*) ����� ,round(avg(salary)) "�μ��� �޿� ���"
from employee e
inner join department d
on e.dno = d.dno
group by d.dno,d.dname,d.loc;

---------------------------------------------------------------------------

--group by ��������

--�� �μ��� ���ؼ� �μ� ��ȣ, �����, �μ����� ������� ��� �޿��� �μ����� ������ ������ ��� �޿��� �ݿø�

select dno �μ���ȣ ,count(*) ����� ,round(avg(salary)) "��� �޿�"
from employee
group by dno
order by dno;

--�� �μ��� ���� �μ���ȣ,�μ� �̸� ������,�����, �μ� �μ����� ������� ��� �޿����- ��� �޿� �ݿø� decode case
select dno �μ���ȣ,
case when dno=10 then 'ȸ��'
     when dno=20 then '����'
     when dno=30 then '�Ǹ�'
     when dno=40 then '����'
else '�����'
end as �μ���,
case when dno=10 then '����'
     when dno=20 then '�޶�'
     when dno=30 then '��ī��'
     when dno=40 then '������'
else '�����'
end as �ٹ���,
count(*) ����� , round(avg(salary)) ��ձ޿�
from employee
group by dno
order by dno;

--�μ� ��ȣ,�����, ����� �μ��� �ο��� �� �հ�, ��� �μ� �ο� , �޿� �� �հ� ��� rollup
select dno �μ���ȣ ,ename ����� ,count(*) ����� ,sum(salary) "�޿� �� �հ�"
from employee
group by rollup(dno,ename) ;

--�� ������ cube ���
select dno,ename,count(*),sum(salary)
from employee
group by cube(dno,ename);

------------------------------------------------------------------------------------------------












