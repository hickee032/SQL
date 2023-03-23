--11/04

--JOIN ����
--����̸��� �ش����� �����ϴ� ������ ��� NULL���� ������� �ʱ�
select e.ename,e1.ename
from employee e , employee e1
where e.manager = e1.eno;

select e.ename , e1.ename
from employee e inner join employee e1
on e.dno = e1.dno
where e.manager = e1.eno;

--ward ������� �Ի����� ���� ����� �Ի��� ��� - �Ի��� ���� ��������
select e.ename, e.hiredate
from employee e
where e.hiredate < (select hiredate from employee where ename = '����')
order by hiredate desc;

select e.ename,e.hiredate
from employee e,employee e1
where e.hiredate < e1.hiredate and e1.ename = '����'
order by hiredate;

--��� �̸��� �ش� ����� �����ϴ� �����ڸ� ��� null ����
select e.ename , e1.ename
from employee e left outer join employee e1
on e.manager = e1.eno;

--��� ����� ��� ���� ������ ��ȣ �μ���ȣ �μ���
select e.eno, e.ename ,e.job,e.manager,e.dno,d.dname
from employee e left outer join department d
on e.dno = d.dno
order by dno;

select e.eno, e.ename ,e.job,e.manager,e.dno,d.dname
from department d left outer join employee e
on e.dno = d.dno
order by dno;

select e.eno, e.ename ,e.job,e.manager,e.dno,d.dname
from employee e right outer join department d
on e.dno = d.dno
order by dno;

select e.eno, e.ename ,e.job,e.manager,e.dno,d.dname
from department d right outer join employee e
on e.dno = d.dno
order by dno;

select e.eno, e.ename ,e.job,e.manager,e.dno,d.dname
from employee e inner join department d
on e.dno = d.dno
order by dno;

select e.eno, e.ename ,e.job,e.manager,e.dno,d.dname
from department d inner join employee e
on e.dno = d.dno
order by dno;


select e.eno, e.ename ,e.job,e.manager,e.dno,d.dname
from employee e left outer join department d
on e.dno = d.dno
order by dno;