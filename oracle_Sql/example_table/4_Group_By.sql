--11/02_2

/*
������ �׷� GROUP BY
�׷��� ��� ���� HAVING ��

�׷��Լ� (�׷쿡 ���õ� �Լ�)

SUM �׷��� �����հ�
AVG �׷��� ���
COUNT �׷��� �� ����
MAX �׷��� �ִ밪
MIN �׷��� �ּҰ�
*/

select sum(salary) as �޿��Ѿ�,
    avg(salary) as �޿����,
    max(salary) as �ִ�޿�,
    min(salary) as �ּұ޿�
from employee;

--�Ҽ��� ó��
select sum(salary) as �޿��Ѿ�,
    round(avg(salary)) as �޿����, 
    max(salary) as �ִ�޿�,
    min(salary) as �ּұ޿�
from employee;

select sum(commission) as "Ŀ�̼� �Ѿ�"
from employee;

--count (���⼭�� �� ������ ��)
select count(*) as "����� ��"
from employee;

--distinct �ߺ����� ������ ��
select count(distinct job) as "������ ��"
from employee;

--�����߻�
select ename, max(salary)
from employee;

select ename, max(salary)
from employee
group by ename;

--group by  : select dno �� group by dno ��ġ

select dno "�μ� ��ȣ" ,avg(salary) "�޿� ���"
from employee
group by dno;

select dno "�μ� ��ȣ" ,round(avg(salary)) "�޿� ���"
from employee
group by dno;

--���� �÷��� ����� �׷캰�� �˻�
select dno, job,count(*),sum(salary)
from employee
group by dno,job
order by dno,job; --��������

--group by���� ����
select dno, max(salary)
from employee
group by dno
having max(salary)>=3000;

---------------------------------------------------------
--����
--group by

--�μ��ο��� 4���� ���� �μ��� �μ���ȣ, �ο���,�޿��� ��
select dno, count(*), sum(salary)
from employee
group by dno
having count(*) > 4
order by dno;

--��� ����� �޿� �ְ��,������,�Ѿ�,��� �޿� ��� (��� ���� �Ҽ��� �ݿø� ó��)
select ename ,max(salary),min(salary),sum(salary),round(avg(salary))
from employee
group by ename;

select max(salary),min(salary),sum(salary),round(avg(salary))
from employee;

select max(salary),min(salary),sum(salary),round(avg(salary))
from employee
group by dno;

--count ���� 

select count(case when job ='�Ŵ���' then 1 end) as "�Ŵ����� ��"
from employee;

select count(case when job ='���' then 1 end) as "����� ��"
from employee;

select count(case when 2000 < salary and salary <=3000  then 1 end) as "������ ��"
from employee;

select job ��å, count(*) �μ��������� , sum(salary) ��������
from employee
group by rollup(job);
