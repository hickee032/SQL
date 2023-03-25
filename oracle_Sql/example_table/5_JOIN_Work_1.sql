--11/03 ��������

--���� ����� �̸�,�μ���ȣ, �μ��̸� ��� (��������)
select e.ename, e.dno, d.dname
from employee e, department d
where e.dno=d.dno and e.ename = '����';

select e.ename, e.dno, d.dname
from employee e
inner join department d
on e.dno= d.dno
where e.ename = '����';

--����� �μ��� ������ ���

--���� ���� ǥ��,join~on ,join~using,equi ���� 4���� ���
--���� ����
select e.ename,d.dname,d.loc
from employee e inner join department d
on e.dno = d.dno;

--join~on
select e.ename, d.dname,d.loc
from employee e join department d
on e.dno = d.dno;

--join~using
select e.ename, d.dname,d.loc
from employee e join department d
using(dno);

--equi
select e.ename, d.dname,d.loc
from employee e ,department d
where e.dno = d.dno;

--�̸��� A �� �� ��� ����� �̸� �μ��� ��� equi,natural

--equi
select e.ename, d.dname
from employee e,department d
where e.dno = d.dno and e.ename like '%��%';

select e.ename, d.dname
from employee e inner join department d
on e.dno = d.dno
where e.ename like '%��%';

select e.ename, d.dname
from employee e natural join department d
where e.ename like '%��%';

--Ŀ�̼��� �޴� ����� �μ��� �ٹ��� equi,natural

select e.ename, d.dname ,d.loc
from employee e,department d
where e.dno = d.dno and e.commission is not null;

select e.ename,d.dname,d.loc
from employee e inner join department d
on e.dno = d.dno
where e.commission is not null and commission not in(0);

select e.ename, d.dname,d.loc
from employee e natural join department d
where e.commission is not null;

--���忡 �ٹ��ϴ� ��� ����� �̸� ���� �μ���ȣ �μ��� equi,natural

select e.ename,e.job,e.dno,d.dname
from employee e,department d
where e.dno = d.dno and d.loc = '����';

select e.ename,e.job,e.dno,d.dname
from employee e inner join department d
on e.dno = d.dno
where d.loc = '����';

select e.ename,e.job,dno,d.dname
from employee e natural join department d
where d.loc = '����';
