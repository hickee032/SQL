--11/11
--�Լ� FUNCTION --���� ���� ������ (���α׷��� �� >> ���ν����� VOID �Լ�, �Լ��� RETURN���� �ִ� �Լ�)
--OUT������ ������� �ʰ� ������� �����ֱ� ���� �뵵 --�Ű������� ������� �ʴ� �� �ƴϴ�

--�Լ� ���ϰ��� �����ϴ� ����
CREATE OR REPLACE FUNCTION GET_NAME(
    V_DNO DEPARTMENT.DNO%TYPE)
    RETURN DEPARTMENT.DNAME%TYPE --���� Ÿ���� ���⼭ ����
IS 
    V_DNAME DEPARTMENT.DNAME%TYPE;  
BEGIN
    SELECT DNAME INTO V_DNAME FROM department WHERE DNO =V_DNO; --SELECT ����� v_dname ������ ��� ����
    RETURN V_DNAME;
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line(SQLCODE||SQLERRM);
        RETURN 0;
END;
/

SELECT DNO �μ���ȣ,ENO ��� ,ENAME �����, GET_NAME(DNO) �μ��� 
FROM EMPLOYEE;
--�л��� ��米��--
CREATE OR REPLACE FUNCTION PROF_GET_NAME(
    V_PRONUM PROFESSOR.PRONUM%TYPE)
    RETURN PROFESSOR.PRONAME%TYPE
    IS
    V_PRONAME PROFESSOR.PRONAME%TYPE;
BEGIN
    SELECT PRONAME INTO V_PRONAME FROM PROFESSOR WHERE PRONUM = V_PRONUM;
    RETURN V_PRONAME;
        EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line(SQLCODE||SQLERRM);
        RETURN 0;
END;
/

SELECT STNAME NAME ,MAJOR MAJOR, PROF_GET_NAME(PRONUM) PFS
FROM STUDENT;

--������ ����л���--
CREATE OR REPLACE FUNCTION STD_COUNT(
V_PRONUM PROFESSOR.PRONUM%TYPE)
RETURN NUMBER
IS
ST_COUNT NUMBER;
BEGIN 
    SELECT COUNT(*) INTO ST_COUNT FROM STUDENT WHERE PRONUM = V_PRONUM;
    RETURN ST_COUNT;
            EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line(SQLCODE||SQLERRM);
        RETURN 0;
END;
/

SELECT PRONAME �̸� ,PROMAJOR �а�, STD_COUNT(PRONUM) "��� �л���"
FROM PROFESSOR;

--Ʈ���� TRIGGER
--� �̺�Ʈ�� �߻������� ���������� ����ǵ��� �����ͺ��̽��� ����� ���ν���
--� �̺�Ʈ :  ������ �߰�, ����, ���� ��

--[BEFORE] �ش繮���� ����Ǳ��� üũ
--[AFTER] ������ ����ǰ� �� �Ŀ� Ʈ���Ű� ������ �ִ� BEGIN END���� ����

CREATE OR REPLACE TRIGGER EMP_TR 
    BEFORE
        INSERT OR UPDATE OF ENAME,SALARY OR DELETE ON EMPLOYEE
BEGIN
CASE 
    WHEN INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('INSERT Ʈ����');
    WHEN UPDATING('SALARY') THEN
        DBMS_OUTPUT.PUT_LINE('UPDATE SALARY Ʈ����');   
    WHEN UPDATING('ENAME') THEN
        DBMS_OUTPUT.PUT_LINE('UPDATE ENAME Ʈ����');   
    WHEN DELETING THEN
       DBMS_OUTPUT.PUT_LINE('DELETE Ʈ����'); 
    END CASE;
END;
/

INSERT INTO EMPLOYEE (ENO,ENAME,JOB) VALUES (999,'ȫ�浿','������');
UPDATE EMPLOYEE SET ENAME = '��浿' WHERE ENO =999;
DELETE FROM EMPLOYEE WHERE ENO =999;

----------------------------------------------------------------------------------------

CREATE TABLE DEPT_HIST AS SELECT * FROM DEPARTMENT WHERE 0 =1;

CREATE OR REPLACE TRIGGER DEPT_TR BEFORE
     INSERT ON DEPARTMENT FOR EACH ROW --FOR EACH ROW : �� �࿡ ��ȭ�� ������� (���ο� �����Ͱ� ���� ����)
BEGIN
     IF INSERTING THEN
        INSERT INTO DEPT_HIST(DNO,DNAME,LOC) VALUES(:NEW.DNO,:NEW.DNAME,:NEW.LOC); --NEW : ���ο����, OLD : ���� ������
    END IF;
END;
/

INSERT INTO DEPARTMENT VALUES (39,'����5��','�뱸');
SELECT * FROM dept_hist
