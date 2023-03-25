--11/10
--PL/SQL
--변수 상수 (스칼라) 등을 선언하여 SQL과 절차적 언어에서 사용

--DECLARE 선언부 - 모든 변수나 상수를 선언하는 부분 DECLARE로 시작됨 (필수아님)
--BEGIN 실행부 로직을 기술 할 수있는 부분 BEGIN으로 시작됨 (필수)
--EXCEPTION 예외처리부 에러가 발생(예외사항) 하면 이를 해결하기 위한 부분 EXCEPTION으로 시작됨 (필수아님)

--쿼리문을 수행하기 위해서 / 가 반드시 입력되어야함 
--PL/SQL 블록은 /가 있으면 종결됨확인

/*
--메세지 출력
SET SERVEROUTPUT ON --외부에 메세지를 출력하라는 뜻 (이것 먼저 실행 또는 같이 실행) 
BEGIN
DBMS_OUTPUT.PUT_LINE('WELCOME');
END;
/

SET SERVEROUTPUT ON --워크시트에서 한번만 매번 실행 할 필요는 없다
BEGIN
DBMS_OUTPUT.PUT_LINE('WELCOME'||' TO ORACLE'); 
--문자열1 || 문자열2 =문자열1문자열2
--여러개의 문자열도 가능하다
END;
/
*/
--변수선언

--DECLARE
--[변수명] [테이블 칼럼]%TYPE;
--OR
--[변수명] [데이터형식]

--스칼라 숫자 문자 날짜 BOOLEAN 4가지

--DECLARE
--V_ENO EMPLOYEE.ENO%TYPE;  --EMPLOYEE.ENO 와 같은 타입으로 선언
--V_ENAME EMPLOYEE.ENAME%TYPE;

--로우(행) 전체에 대한 데이터 타입을 참조 %ROWTYPE
--V_EMPLOYEE EMPLOYEE%ROWTYPE;

--값 대입
--[변수명] := [값]
--V_ENO := 7788;
--V_ENAME := 'SCOTT';

/*

스칼라 변수 레퍼런스 변수

선택문 
IF THEN END IF,
IF THEN ELSE END IF, 
IF THEN ELSIF

반복처리
BASIC LOOP
FOR LOOP
WHILE LOOP/
*/

--제어문 IF
/*
DECLARE -- 선언부
--변수 선언
    GRADE CHAR(10);
    RESULT VARCHAR2(30);
BEGIN -- 실행부
    GRADE := 'B'; --값을 대입
IF GRADE = 'A'THEN  --비교연산자 (=)
    RESULT := 'A학점';
ELSIF GRADE = 'B'THEN 
    RESULT := 'B학점';
ELSIF GRADE = 'C'THEN 
    RESULT := 'C학점';
ELSE
    RESULT := '제적';
END IF;
    DBMS_OUTPUT.PUT_LINE('학점 : '||GRADE||'=>'||RESULT);
EXCEPTION -- 예외처리부
    WHEN OTHERS THEN -- 알수없는 에러
        DBMS_OUTPUT.PUT_LINE('에러발생');
END;
/
*/

/*
--연습 점수 (정수)
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
    DBMS_OUTPUT.PUT_LINE('점수 : '||SCORE||' 학점 : '|| RESULT);
EXCEPTION 
    WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('에러발생');
END;
/
*/
/*
--제어문 CASE (범위가 아닌 값이 오는 경우)

DECLARE
    GRADE CHAR(5);
    RESULT VARCHAR2(20);
BEGIN
GRADE := 'B';
    CASE GRADE
        WHEN 'A' THEN
RESULT :='A학점';
WHEN 'B' THEN
RESULT :='B학점';
WHEN 'C' THEN
RESULT :='C학점';
WHEN 'D' THEN
RESULT :='D학점';
ELSE
RESULT := '제적';
END CASE;
DBMS_OUTPUT.PUT_LINE('학점정보 : '||GRADE||'='||RESULT);
EXCEPTION 
    WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('에러발생');
END;
/
*/
/*
--반복문 FOR
DECLARE 
    I NUMBER :=0;  -- 변수 초기화
    RES NUMBER :=0;
BEGIN
    FOR I IN 1..10 LOOP
    RES := I*2;
    DBMS_OUTPUT.PUT_LINE(RES);
    END LOOP;
END;
/
*/

--반복문 WHILE
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

--무한루프
--1에서 10까지의 합
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

--연습
--1에서 100까지의 3의 배수

--FOR
DECLARE 
    I NUMBER :=0;  -- 변수 초기화
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

--무한루프

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



--커서
--CURSOR OPEN FETCH CLOSE
--SELECT 실행 경과가 여러개의 로우 일때 이를 처리하기 위해 사용

/*
DECLARE 
    CURSOR 커서명 IS [SQL 명령어(SELECT)]
    --[SQL 명령어] 결과가 [변수명]에 저장된다 -- 여러개의 결과값을
    [변수명]%ROWTYPE;
BEGIN
    OPEN [커서명]; --커서열기
    LOOP 
    --커서에 데이터를 하나씩 꺼내어 변수에 전달
    FETCH [커서명] INTO [변수명];
    EXIT WHEN [커서명]%NOTFOUND; --찾을 데이터가 없다면 EXIT
    DBMS_OUTPUT.PUT_LINE(EMP_BUF.ENO||':'||EMP_BUF.ENAME);
    END LOOP;
CLOSE [커서명]; --커서 종료
END;
/
*/

--커서 약식 표현
/*
DECLARE 
BEGIN
FOR [변수명] IN(SQL 명령어(SELECT))
LOOP
    DBMS_OUTPUT.PUT_LINE(EMP_BUF.ENO||':'||EMP_BUF.ENAME);
    END LOOP;
END;
/

*/

DECLARE 
    CURSOR EMP_CURSOR IS --커서 선언
    SELECT * FROM EMPLOYEE WHERE DNO =20;
    EMP_BUF EMPLOYEE%ROWTYPE;
BEGIN
    OPEN EMP_CURSOR; --커서열기
    LOOP 
    --커서에 데이터를 하나씩 꺼내어 변수에 전달
    FETCH EMP_CURSOR INTO EMP_BUF;
    EXIT WHEN EMP_CURSOR%NOTFOUND; --찾을 데이터가 없다면 EXIT
    DBMS_OUTPUT.PUT_LINE(EMP_BUF.ENO||':'||EMP_BUF.ENAME);
END LOOP;
CLOSE EMP_CURSOR; --커서 종료
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