--11/1
--CRUD 
--DDL DML DCL TCL 

--select ����

--��� ���̺� ��� ��� ���
select * from employee;
--��� ���̺� �� eno,ename ���
select eno ,ename  from employee;

--as�� ����� ���̺� Į���� ������ ������
select eno as �����ȣ ,ename as �����  from employee;
--as�� ����
select eno �����ȣ ,ename �����  from employee;
--������ �ִ� ���� �ֵ���ǥ("")�� �ٿ���� �Ѵ� 
select eno �����ȣ ,ename "��� �̸�"  from employee;

-- ��� ���굵 ���� salary*12 ������ �ݵ�� ����Ǵ� ����� NUMBER ������
select ename ����� ,salary ���� ,salary*12 ���� from employee;

--�ߺ����� distinct
select dno from employee; --�ߺ� ���� ��
select distinct dno from employee; --�ߺ� ���� ��

---------------------------------------------------------------------------

--������ �Ἥ �˻�


/*  select �÷���
    from ���̺��
    where ����    */
    
select eno �����ȣ, ename ����� ,salary ���� from employee
where salary = 1500;

select eno �����ȣ, ename ����� ,salary ���� from employee
where salary >= 1500;

--���� �ʴ� <> != ^=
select eno �����ȣ, ename ����� ,salary ���� from employee
where salary <> 1500;

select eno �����ȣ, ename ����� ,salary ���� from employee
where salary != 1500;

select eno �����ȣ, ename ����� ,salary ���� from employee
where salary ^= 1500;

--varchar �� ��� (' ') �ʿ���
select *from employee 
where ename = '����';

--��¥ ������ ��ȸ (' ') �ʿ��� hiredate - dateŸ��
select * from employee
where hiredate <= '1981/01/01';

/*  �� ������ 
    AND OR NOT */

--�Ѵ� true
select *from employee
where dno = 10 and job = '�Ŵ���';

--�ϳ��� true
select * from employee
where dno  = 10 or job ='�Ŵ���';

--�μ���ȣ�� 10�� �ƴ� ���
select * from employee
where not dno = 10;

/*  BETWEEN AND ������  
    BETWEEN a AND b
    a :���Ѱ� b:���Ѱ� */
    
select * from employee
where salary between 1000 and 1500;

--�Ի����� 81/01/01 81/12/31 ���� ��¥ (' ')
--��¥ (' ')
select ename �����,hiredate �Ի��� from employee
where hiredate between '81/01/01' and '81/12/31';

--in(a,b,c) a �̰ų� b �̰ų� c�� ��
--in(300,500,1400) NUMBER Ÿ�Ը� ����
select * from employee
where commission in(300,500,1400);

--in(a,b,c) a �̰ų� b �̰ų� c�� �ƴ� ��
--not in(0,500,1400)
select * from employee
where commission not in(300,500,1400);

/*LIKE Į���� ����� �������� �Ϻθ� ��ġ�ϴ��� ��ȸ�� ����
% : �ڸ����� �ǹ� ���� %�浿 ��浿 ȫ�浿 �ڱ浿 �� �˻���
_ : �ڸ��� �� ���� �޶��� 
*/

--������� '��'�� �����ϴ� ��� ���
select * from employee
where ename like '��%';

--������� '��'�� �����ϴ� ��� ����� ����
select * from employee
where ename not like '��%';

--������� '��'�� ������ ��� ���
select * from employee
where ename like '%��';

--������� '��'�� ������ ��� ����� ����
select * from employee
where ename not like '%��';

--����� '��'�� ���Ե� ���
select * from employee
where ename like '%��%';

--'_'�� �ѹ��ڿ� ���ؼ� 
select * from employee
where ename like '_��'; --�տ� �ѱ��� ������ '��' �� ���� ���

select * from employee
where ename like '__��'; --�տ� �α��� ������ '��' �� ���� ���

select * from employee
where ename like '��_'; --�տ� '��'�� �ְ� �ڿ� �ѱ��ڰ� ���� ���

select * from employee
where ename like '��__'; --�տ� '��'�� �ְ� �ڿ� �α��ڰ� ���� ���

/*IS NULL ���� �˼� ���� ��� ����*/

--NULL ���� ��� 0�̸� ����
select * from employee
where commission is null;

--NULL ���� �ƴ� �� ���
select * from employee
where commission is not null;
    
/*���� ORDER BY �������� ASC 1,2,3,4,5
               �������� DESC 5,4,3,2,1
               ���������� ASC�� ���������ϴ�*/    
               
select * from employee
order by salary asc;

select * from employee
order by salary desc;

select * from employee
where manager is not null
order by salary desc;

--salary ������������ �����ϵ� ���� ���� ��� ename�� ������������ ����
select * from employee
order by salary desc, ename asc;



/*inner join 
select e.ename ����� ,d.dname �μ��� from employee e
inner join department d
on (e.dno=d.dno)
where e.dno = 20;*/

-------------------------------------------------------------

--1.��� ��ȣ�� 7788 �� ����� �̸� �μ���ȣ
select ename ����̸�, dno �μ���ȣ from employee
where eno = 7788;


