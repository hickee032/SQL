--11/04
--��������
--�������� �Ϲ� ������ select�� ���� ��Ī�Ѵ�
--������(��������) ��ü������ �ؼ��� �������� ���� �Ѵ�
--�������� ��ġ�� select ������ �Ǵ� from ������ ��ġ�ϱ⵵ �ϰ� �Ϲ������δ� where ���� ���

/* ����
select select_list
from table
where ex_operator > (select select_list from table --��������
                        where ex_operator); */

--��������
select ename, salary
from employee
where salary > (select salary from employee --��������
                where ename = '����');

/*
������ ��������
���������� ����� �ϳ�
������ �������� - �񱳿����� (=,>,<,>=,<=,<>)
*/

--����� ������ �μ��� ���
select ename, dno
from employee
where dno = (select dno from employee 
                where ename = '����');
                
/*
������ ��������
���������� ����� ������
������ �� ������ �ݵ�� ��� (in,any, some, all, exists)

in �ϳ��� ��ġ ���� ������ �������� '='�� ���� ���
any , some �ϳ��̻��� ��ġ
all ��� ��ġ
exists �ϳ��� �����ϸ� ��
*/

--�μ����� �ּұ޿��� �޴� ����� �����ȣ, �̸��� ���
select eno,ename
from employee
where salary in( select min(salary) from employee group by dno);

--equi
select e.eno,e.ename,d.dname,d.loc
from employee e,department d
where e.dno = d.dno and salary in( select min(salary) from employee group by dno);

--inner join
select e.eno,e.ename,d.dname,d.loc
from employee e inner join department d
on e.dno = d.dno
where salary in( select min(salary) from employee group by dno);

--join using
select e.eno,e.ename,d.dname,d.loc
from employee e join department d
using(dno)
where salary in( select min(salary) from employee group by dno);

/* any */
--�ϳ� �̻� ��ġ�ϸ� ��
-- '> any' �� ã���� �������ؼ� �ϳ��� ũ�� ��
--ã���� ���� ���� ���� �� �ּҰ����� ũ�� ��

--������ �Ǹſ��� �ƴϸ鼭 �޿��� ������ �Ǹſ����� �������
select eno,ename,job,salary
from employee
where salary < any(select salary from employee where job = '�Ǹſ�') 
and job != '�Ǹſ�';

/* ALL */
--���� ������ �������� ���������� �˻������ ��簪�� ��ġ�ϸ� ��
--'>ALL'�� ��� �񱳰����� ũ�� ��� ���� �� �ִ밪���� ũ�� ��

--������ �Ǹſ��� �ƴϸ鼭 ������ �Ǹſ����� �޿��� ���� ��� �Ǹſ�
select eno,ename,job,salary
from employee
where salary < all(select salary from employee where job = '�Ǹſ�') 
and job != '�Ǹſ�'

                

