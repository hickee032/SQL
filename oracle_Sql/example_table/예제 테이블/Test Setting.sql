-- �ּ�ó�� ��� ���� �ּ��� -- ���� �� �ּ��� /* */
--setting
-- 11g ȣȯ�� ���� �����
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

-- �Ϲݰ����� ���� : �����ڷ� ���� 
-- > ���̵� ---- ����� ----�� ������ ������
CREATE USER xxxx IDENTIFIED BY xxxx;

-- ���� ���� �ο��ؾ� DB�� ������ �Ҽ� �ִ�
-- �����ڷ� ������ �ߴ��� �Ϲݰ������� ������ �ߴ��� �򰥸��� �ȵ�
-- grant ���� �ο�
grant connect, resource to test;

-- ���̺� ��� ���� �ο�
alter user test quota unlimited on users;

--��� ���� ��ư ->  ������ ���� ��ŭ�� ���� (���� ���� ����)
--�ι�° ���� ��ư -> �Ѳ����� ����


