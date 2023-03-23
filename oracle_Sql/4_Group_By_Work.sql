--11/02
--��������

--select

--�����ڰ� ���� ����� �̸��� ��� ���� ���
select *
from employee
where manager is null;

--Ŀ�̼��� �������ִ� ����� �̸��� �޿� Ŀ�̼� ��� --�޿� Ŀ�̼� ��������
select ename , salary , commission
from employee
where commission is null or commission = 0
order by salary,commission;

--�̸��� 3��° ���ڰ� '��' �� ��� �����
select ename
from employee
where ename like '__��';

--�̸��� '��'�� '��'�� ��� �����ϴ� ���
select ename
from employee
where ename like '%��%' and ename like '%��%';

--�������� �繫�� �Ǵ� ������� �̸鼭 �޿��� 1600,950 1300�� �ƴ� ����� �̸� ������ �޿�
select ename ,job,salary
from employee
where (job ='���' or job = '�Ǹſ�') and salary not in(1600,950,1300);

--group by

--�������� �޿� �ְ�� ������ �Ѿ� ��վ� ��� ��վ� �ݿø�
select max(salary), min(salary), sum(salary), round(avg(salary))
from employee
group by job;

--�������� ������ ����� ���
select count(*)
from employee
group by job;

--���޺� ����� ���� �޿� ��� �����ڸ� �˼����� ��� �� �����޿��� 2000 �̸��� �׷��� ���� �޿� ��������

select job, min(salary) as �����޿�
from employee
where manager is not null
group by job
having min(salary) > 2000
order by �����޿� desc;


select job, min(salary) as �����޿�
from employee
group by job, manager
having min(salary) > 2000 and manager is not null
order by �����޿� desc;
