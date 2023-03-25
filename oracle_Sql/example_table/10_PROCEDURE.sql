--���ν���
--�Ϸ��� �۾����� �ϳ��� ��� �����صξ��ٰ� ȣ�� �Ͽ� �̷� �۾����� �����Ҽ��ְ� ��

/*
CREATE OR REPLACE PROCEDURE [���ν��� ��](
     [�Ű�������] [MODE] [����������]) IS
    [������] [����������] -- ���� ����
    );
BEGIN
...
END;
/


*/
--���ν����� ���� 
--EXECUTE PROCEDURE_NAME
--���ν����� ����
--DROP PROCEDURE_NAME

--IN -- �ܺο��� ���ν��� ������ (�Ű�����)
--�����͸� ���� ������

--OUT --�ܺο��� ���ν��� ������� Ȯ�� 
--����� ����� �޾ư���

--INPUT --�� �ΰ��� ������ ���� ���

SET SERVEROUTPUT ON 

CREATE OR REPLACE PROCEDURE emp_info(
    p_empno IN employee.eno%TYPE) IS
    v_eno employee.eno%TYPE;
    v_sal NUMBER;
    v_ename employee.ename%TYPE;
BEGIN
    SELECT eno,ename,salary INTO v_eno,v_ename,v_sal
        FROM employee WHERE eno = p_empno;
    dbms_output.put_line('��� :'||v_eno);
    dbms_output.put_line('�̸� :'||v_ename);
    dbms_output.put_line('�޿� :'||v_sal);
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('�˼� ���� ����');
 END;
 /
 
 --���ν��� ȣ��
 EXECUTE emp_info(7788);
 
 -------------------------------------------------------------------
 
CREATE OR REPLACE PROCEDURE emp_info(
    p_empdno IN employee.dno%TYPE) IS
BEGIN
for empdno_buf in( SELECT * FROM employee WHERE dno = p_empdno)
    loop
    dbms_output.put_line('�μ���ȣ : '||empdno_buf.dno||' �����ȣ : '||empdno_buf.eno||' �̸� : '||empdno_buf.ename||'/ �޿� : '||empdno_buf.salary);
    end loop;
END;
/

EXECUTE emp_info(10);    
 -------------------------------------------------------------------
 
CREATE OR REPLACE PROCEDURE emp_info2(
    p_empdno IN employee.dno%TYPE) IS
    CURSOR EMP2_CURSOR IS 
    SELECT * FROM EMPLOYEE WHERE DNO = p_empdno;
    empdno_buf EMPLOYEE%ROWTYPE;
BEGIN
open EMP2_CURSOR;
    loop
    FETCH EMP2_CURSOR INTO empdno_buf;
    EXIT WHEN EMP2_CURSOR%NOTFOUND;
    dbms_output.put_line('�μ���ȣ : '||empdno_buf.dno||' �����ȣ : '||empdno_buf.eno||' �̸� : '||empdno_buf.ename||'/ �޿� : '||empdno_buf.salary);
    end loop;
    CLOSE EMP2_CURSOR;
END;
/

EXECUTE emp_info2(10);



 
 