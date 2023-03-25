--11/04
--�������� ��������

--�����ȣ�� 7788�� ����� �������� ������� ��� - ����� ��� ����
select ename ,job
from employee
where job = (select job from employee where eno = 7788);

--�����ȣ�� 7499 ���� �޿��� ���� ����� ����� ������ �޿�
select ename ,job,salary
from employee
where salary > (select salary from employee where eno = 7499);

--�ּ�, �ִ� �޿��� �޴� ����� �޿� �μ���ȣ
select ename,salary,dno
from employee
where salary = ((select min(salary) from employee)) or (salary = (select max(salary) from employee));
--�� �μ��� �ּ� �޿��� �޴� ����� �޿� �μ���ȣ
--�� �μ��� �ּ� �޿��� �޴� ����� �޿� �μ���ȣ �μ��� �ٹ���
select e.ename, e.salary, d.dno,d.dname,d.loc
from employee e inner join department d
on e.dno = d.dno
where salary = any(select min(salary) from employee group by dno);

--��� ������ �м����� ������� �޿��� �����鼭 �м����� �ƴ� �����  ��� ����� ������ �޿�
select eno,ename,job,salary
from employee
where salary < any(select salary from employee where job = '�м���') and job != '�м���';

--���ӻ���� ���� ������ ���
select ename
from employee
where eno = (select eno from employee where manager is null);

--���ӻ���� ���� ���� �μ��� �ٹ��� ���
select e.ename,d.dname,d.loc
from employee e inner join department d
on e.dno = d.dno
where e.eno = (select eno from employee where manager is null);

-- ����� ������ �μ����� �ٹ��ϴ� ��� �� �μ���ȣ 
select ename, dno
from employee
where dno in (select dno from employee where ename = '����');


-- ����� ������ �μ����� �ٹ��ϴ� ��� �� �μ���ȣ �μ��� �ٹ����� 
--equi
select e.ename, d.dno, d.dname,d.loc
from employee e , department d
where e.dno = d.dno and e.dno in (select dno from employee where ename = '����');

--inner join
select e.ename, d.dno,d.dname, d.loc
from employee e inner join department d
on e.dno = d.dno
where e.dno in (select dno from employee where ename in('����'));

--JOIN using 
select e.ename,dno,d.dname,d.loc
from employee e join department d
using(dno)
where dno in (select dno from employee where ename in('����'));

--NATUAL JOIN
select e.ename,dno,d.dname,d.loc
from employee e NATURAL join department d
where dno in (select dno from employee where ename in('����'));























