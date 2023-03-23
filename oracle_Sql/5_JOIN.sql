--11/03

--���� join
--�ٸ� ���̺��� ������ �ҷ������� �ҋ�
--�������� ���̺� ����� �����͸� �Ѳ����� ��ȸ�� �ʿ伺�� ���� ���
--���� ���� ���·� �ҷ����Ե� (ī��þ� ��)

--equi join (���� ���� (��������) : ǥ���� �ƴ� ����Ŭ������)

select *from employee, department; -- ���̺��� �ϳ��� ������ ����(������ �������� �ʴ´�)

/* ����
select table1.column,table2.column
from table1,table2
where table1.column1=table2.column2
*/

select *
from employee,department
where employee.dno = department.dno;

select employee.eno,employee.ename,department.dname,employee.dno
from employee,department
where employee.dno = department.dno and employee.eno =7788;

--���̺�� ��Ī ����Ҽ��� �ִ�
select e.eno,e.ename,d.dname,e.dno
from employee e,department d
where e.dno = d.dno and e.eno =7788;

--natural join
--�ߺ��� ���� ������ �ڵ����� �ɷ��ش�(�ߺ� ����)
--�ߺ��� ���� ������ ����

/*
select table1.column,table2.column
from table1 natural join table2
*/

select e.eno,e.ename,d.dname,dno --������ Į���� ���� e.dno �� ���� ����
from employee e natural join department d
where e.eno =7788;

--using ���� ������ �Ǵ� ����� �Ǵ� �÷��� ����

/*
select table1.column,table2.column
from table1 join table2
using(column);
*/

select e.eno,e.ename,d.dname,dno
from employee e join department d
using(dno)
where e.eno =7788;

--on : ������ ������ �����ϰų� ������ Į���� ����

/*
select table1.column,table2.column
from table1 join table2
on table1.column1 = table2.column2;
*/

select e.eno,e.ename,d.dname,e.dno
from employee e join department d
on e.dno = d.dno
where e.eno =7788;

--non-equi join
--�� ���� ���̺� ���� Į�� ������ ���� ��Ȯ�ϰ� ��ġ���� �ʴ� ���
--where ���� < , between A and B( = ������ �ƴ�) -> �����ڸ� ���
select ename, salary ,grade
from employee,salgrade
where salary between losal  and hisal;

--3���� ���̺��� ����

select e.ename,d.dname,e.salary,s.grade
from employee e,department d ,salgrade s
where e.dno = d.dno
and salary between losal  and hisal;

--self join
--�ڽ��� ���̺���� ����
--�ϳ��� ���̺� �ִ� Į�� ���� �����ؾ��ϴ� ������ ǧ���Ѱ��

select employees.ename as "����̸�",manager.ename as "����̸�"
from employee employees, employee manager
where employees.manager = manager.eno;

--outer join
--������ Į�� ������ �ϳ��� NULL������ ���� ����� ��� �� �ʿ䰡 ���� ���

/*
select table1.column,table2.column
from table1, table2
where table1.column(+) = table2.column
�Ǵ�
where table1.column = table2.column(+)
*/

select employees.ename ||'�� ����� '||manager.ename
from employee employees join employee manager
on employees.manager = manager.eno(+);

--ANSI (ǥ��)

--null ��ġ�� ���� ������ LEFT ������ ROGHT 
/*
select table1.column,table2.column
from table1 [LEFT,RIGHT,FULL] table2
on table1.column1 = table2.column2;
*/

--left outer join
select employees.ename ||'�� ���ӻ���� '||manager.ename
from employee employees left outer join employee manager
on employees.manager = manager.eno;





