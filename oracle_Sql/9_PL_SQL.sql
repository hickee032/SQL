--11/10
--PL/SQL
--���� ��� (��Į��) ���� �����Ͽ� SQL�� ������ ���� ���

--DECLARE ����� - ��� ������ ����� �����ϴ� �κ� DECLARE�� ���۵� (�ʼ��ƴ�)
--BEGIN ����� ������ ��� �� ���ִ� �κ� BEGIN���� ���۵� (�ʼ�)
--EXCEPTION ����ó���� ������ �߻�(���ܻ���) �ϸ� �̸� �ذ��ϱ� ���� �κ� EXCEPTION���� ���۵� (�ʼ��ƴ�)

--�������� �����ϱ� ���ؼ� / �� �ݵ�� �ԷµǾ���� 
--PL/SQL ����� /�� ������ �����Ȯ��

/*
--�޼��� ���
SET SERVEROUTPUT ON --�ܺο� �޼����� ����϶�� �� (�̰� ���� ���� �Ǵ� ���� ����) 
BEGIN
DBMS_OUTPUT.PUT_LINE('WELCOME');
END;
/

SET SERVEROUTPUT ON --��ũ��Ʈ���� �ѹ��� �Ź� ���� �� �ʿ�� ����
BEGIN
DBMS_OUTPUT.PUT_LINE('WELCOME'||' TO ORACLE'); 
--���ڿ�1 || ���ڿ�2 =���ڿ�1���ڿ�2
--�������� ���ڿ��� �����ϴ�
END;
/
*/
--��������

--DECLARE
--[������] [���̺� Į��]%TYPE;
--OR
--[������] [����������]

--��Į�� ���� ���� ��¥ BOOLEAN 4����

--DECLARE
--V_ENO EMPLOYEE.ENO%TYPE;  --EMPLOYEE.ENO �� ���� Ÿ������ ����
--V_ENAME EMPLOYEE.ENAME%TYPE;

--�ο�(��) ��ü�� ���� ������ Ÿ���� ���� %ROWTYPE
--V_EMPLOYEE EMPLOYEE%ROWTYPE;

--�� ����
--[������] := [��]
--V_ENO := 7788;
--V_ENAME := 'SCOTT';

/*

��Į�� ���� ���۷��� ����

���ù� 
IF THEN END IF,
IF THEN ELSE END IF, 
IF THEN ELSIF

�ݺ�ó��
BASIC LOOP
FOR LOOP
WHILE LOOP/
*/

--��� IF
/*
DECLARE -- �����
--���� ����
    GRADE CHAR(10);
    RESULT VARCHAR2(30);
BEGIN -- �����
    GRADE := 'B'; --���� ����
IF GRADE = 'A'THEN  --�񱳿����� (=)
    RESULT := 'A����';
ELSIF GRADE = 'B'THEN 
    RESULT := 'B����';
ELSIF GRADE = 'C'THEN 
    RESULT := 'C����';
ELSE
    RESULT := '����';
END IF;
    DBMS_OUTPUT.PUT_LINE('���� : '||GRADE||'=>'||RESULT);
EXCEPTION -- ����ó����
    WHEN OTHERS THEN -- �˼����� ����
        DBMS_OUTPUT.PUT_LINE('�����߻�');
END;
/
*/

/*
--���� ���� (����)
DECLARE 
    SCORE NUMBER;
    RESULT VARCHAR2(30);
BEGIN 
SCORE := 87;
IF (90<=SCORE) AND (SCORE <=100) THEN
     RESULT := 'A';
ELSIF (80<=SCORE)AND(SCORE <=89)THEN
     RESULT := 'B';
ELSIF (70<=SCORE)AND(SCORE <=79)THEN
     RESULT := 'C';
ELSIF (60<=SCORE)AND(SCORE <=69)THEN
     RESULT := 'D';
ELSE
    RESULT := 'F'; 
END IF; 
    DBMS_OUTPUT.PUT_LINE('���� : '||SCORE||' ���� : '|| RESULT);
EXCEPTION 
    WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('�����߻�');
END;
/
*/
/*
--��� CASE (������ �ƴ� ���� ���� ���)

DECLARE
    GRADE CHAR(5);
    RESULT VARCHAR2(20);
BEGIN
GRADE := 'B';
    CASE GRADE
        WHEN 'A' THEN
            RESULT :='A����';
        WHEN 'B' THEN
            RESULT :='B����';
        WHEN 'C' THEN
            RESULT :='C����';
        WHEN 'D' THEN
            RESULT :='D����';
    ELSE
        RESULT := '����';
    END CASE;
        DBMS_OUTPUT.PUT_LINE('�������� : '||GRADE||'='||RESULT);
EXCEPTION 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('�����߻�');
END;
/
*/
/*
--�ݺ��� FOR
DECLARE 
    I NUMBER :=0;  -- ���� �ʱ�ȭ
    RES NUMBER :=0;
BEGIN
    FOR I IN 1..10 LOOP --1���� 10������ ����
    RES := I*2;
    DBMS_OUTPUT.PUT_LINE(RES);
    END LOOP;
END;
/
*/

--�ݺ��� WHILE (ī���� ������ �ʿ��ϴ�)
DECLARE 
    I NUMBER  :=0;
    RES NUMBER :=0;
BEGIN
    I :=1;
    WHILE I<=10 LOOP
    RES := I*2;
    DBMS_OUTPUT.PUT_LINE(RES);
    I := I+1;
    END LOOP;
END;
/

--���ѷ��� - 1���� 10������ ��
DECLARE 
    V_NUM NUMBER :=0;
    RES INT :=0;
BEGIN
    V_NUM:=1;
    LOOP
        RES := RES+V_NUM;
        IF V_NUM > 10 THEN
        EXIT;
        END IF;
        V_NUM := V_NUM+1;
        DBMS_OUTPUT.PUT_LINE(RES);
    END LOOP;
END;
/

--����
--1���� 100������ 3�� ���

--FOR
DECLARE 
    I NUMBER :=0;  -- ���� �ʱ�ȭ
    RES NUMBER :=0;
BEGIN
    FOR I IN 1..100 LOOP
    IF MOD(I,3)=0 THEN
        RES := RES+I; 
    END IF;
    END LOOP;
        DBMS_OUTPUT.PUT_LINE(RES);
END;
/

--WHILE
DECLARE 
    I NUMBER  :=0;
    RES NUMBER :=0;
BEGIN
    I :=0;
    WHILE I<=100 LOOP
        IF MOD(I,3)=0 THEN
        RES := RES+I; 
    END IF;
    I := I+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(RES);
END;
/

--���ѷ���

DECLARE 
V_NUM NUMBER :=0;
RES INT :=0;
BEGIN
V_NUM:=1;
LOOP
IF MOD(V_NUM,3) =0 THEN
    RES := RES+V_NUM;
    END IF;
IF V_NUM > 100 THEN
    EXIT;
    END IF;
    V_NUM := V_NUM+1;
    END LOOP;
DBMS_OUTPUT.PUT_LINE(RES);
END;
/



--Ŀ��
--CURSOR OPEN FETCH CLOSE
--SELECT ���� ����� �������� �ο� �϶� �̸� ó���ϱ� ���� ��� (������� �������� ���)

/*
DECLARE 
    CURSOR Ŀ���� IS 
    [SQL ��ɾ�(SELECT)];
    [����1]%ROWTYPE;
    --[SQL ��ɾ�] ����� [������]�� ����ȴ� -- �������� ������� ����
BEGIN
    OPEN [Ŀ����]; --Ŀ������
    LOOP 
    --Ŀ���� �����͸� �ϳ��� ������ ������ ����
    FETCH [Ŀ����] INTO [����1];
    EXIT WHEN [Ŀ����]%NOTFOUND; --ã�� �����Ͱ� ���ٸ� EXIT
    DBMS_OUTPUT.PUT_LINE(EMP_BUF.ENO||':'||EMP_BUF.ENAME);
    END LOOP;
CLOSE [Ŀ����]; --Ŀ�� ����
END;
/
*/

--Ŀ�� ��� ǥ��
/*
DECLARE 
BEGIN
FOR [������] IN(SQL ��ɾ�(SELECT))
LOOP
    DBMS_OUTPUT.PUT_LINE(EMP_BUF.ENO||':'||EMP_BUF.ENAME);
    END LOOP;
END;
/

*/

DECLARE 
    CURSOR EMP_CURSOR IS --Ŀ�� ����
    SELECT * FROM EMPLOYEE WHERE DNO =20;
    EMP_BUF EMPLOYEE%ROWTYPE;
BEGIN
    OPEN EMP_CURSOR; --Ŀ������
    LOOP 
    --Ŀ���� �����͸� �ϳ��� ������ ������ ����
    FETCH EMP_CURSOR INTO EMP_BUF;
    EXIT WHEN EMP_CURSOR%NOTFOUND; --ã�� �����Ͱ� ���ٸ� EXIT
    DBMS_OUTPUT.PUT_LINE(EMP_BUF.ENO||':'||EMP_BUF.ENAME);
END LOOP;
CLOSE EMP_CURSOR; --Ŀ�� ����
END;
/

DECLARE 
BEGIN
FOR EMP_BUF IN( SELECT *FROM EMPLOYEE WHERE DNO =20)
LOOP
    DBMS_OUTPUT.PUT_LINE(EMP_BUF.ENO||EMP_BUF.ENAME);
    END LOOP;
END;
/