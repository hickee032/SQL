--select ����

--�޿��� 2000�� �Ѵ� ����� �̸��� �޿��� �޿��� ���� ������ ���
select ename �����, salary �޿� from employee
where salary >2000
order by salary desc;

--��� ����� ���� �޿� 300�� �λ��Ͽ� ����� ����� �̸� �޿� �λ�� �޿� ���
select ename �����, salary �޿�, salary+300 �λ�޿�
from employee;

--����� �̸� �޿� ���� �Ѽ����� �Ѽ����� ���� ������ ��� +100
select ename �����, salary �޿�, (salary*12)+100 �����Ѽ���
from employee
order by �����Ѽ��� desc;

--����� �̸� �޿� ���� �Ѽ����� �Ѽ����� ���� ������ ���
select ename �����, salary �޿�, (salary*12) + NVL(COMMISSION,0) �����Ѽ���
from employee
order by salary desc;

--�޿��� 2000~3000���̿� ���Ե��� �ʴ� ���
select * from employee
where salary not between 2000 and 3000;

--�޿��� 2000~3000���̿� ���ԵǴ� ��� 2����

select * from employee
where salary between 2000 and 3000;

select * from employee
where salary>2000 and salary<3000;

--1981/2/20~ 1982/5/1 �Ի��� ����� �̸� ������ �Ի���
select ename �����,job ������, hiredate �Ի��� from employee
where hiredate between '1981/2/20' and '1982/5/1';

--�μ���ȣ�� 20~30�� ���� ����� �̸��� �μ���ȣ �̸����� ��������
select ename �����, dno �μ���ȣ from employee
where dno between 20 and 30
order by ename desc;

select ename �����, dno �μ���ȣ from employee
where dno in(20,30)
order by ename desc;

--����� �޿��� 2000~3000 ���̿� ���Եǰ� �μ���ȣ�� 20 �Ǵ� 30�� ����� �̸� �޿� �μ���ȣ �̸����� ��������
select ename �����, salary �޿�,dno �μ���ȣ from employee
where salary between 2000 and 3000 and dno between 20 and 30
order by ename;

select ename �����, salary �޿�,dno �μ���ȣ from employee
where salary between 2000 and 3000 and (dno = 20 or dno = 30)
order by ename;

select ename �����, salary �޿�,dno �μ���ȣ from employee
where (salary > 2000 and salary < 3000 )and (dno = 20 or dno = 30)
order by ename;

select ename �����, salary �޿�,dno �μ���ȣ from employee
where salary between 2000 and 3000 and dno in(20,30)
order by ename;

--1981������ �Ի��� ����� �̸� �Ի��� like
select ename �����, hiredate �Ի��� from employee
where hiredate >= '1981/01/01' and hiredate <= '1981/12/31';

select ename �����, hiredate �Ի��� from employee
where hiredate like '%81%';

------------------------------------------------------------

select e.ename �����, d.dname �μ��� from employee e
inner join department d
on e.dno = d.dno
where salary between 2000 and 3000;

select *
from employee e
left join department d
on e.dno = d.dno
order by e.dno asc;

select e.ename �����,d.dname �μ��� ,d.loc �ٹ���,e.job ������
from employee e
right join department d
on e.dno = d.dno
order by d.dname;

select *
from employee e
full join department d
on e.dno = d.dno;
