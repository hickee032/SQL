--프로시저
--일련의 작업들을 하나로 묶어서 저장해두었다가 호출 하여 이런 작업들이 실행 할수있게 함

/*
CREATE OR REPLACE PROCEDURE [프로시저 명](
     [매개변수명] [MODE] [데이터형식]) 
     IS
     [변수명] [데이터형식] -- 지역 변수
    );
BEGIN
...
END;
/


*/
--프로시저를 실행 
--EXECUTE PROCEDURE_NAME
--프로시저를 삭제
--DROP PROCEDURE_NAME

--IN -- 외부에서 프로시저 안으로 (매개변수)
--데이터를 전달 받을때

--OUT --외부에서 프로시저 결과값을 확인 
--수행된 결과를 받아갈때

--INPUT --위 두가지 목적을 위해 사용

SET SERVEROUTPUT ON 

CREATE OR REPLACE PROCEDURE emp_info(
    p_empno IN employee.eno%TYPE) IS
    v_eno employee.eno%TYPE;
    v_sal NUMBER;
    v_ename employee.ename%TYPE;
BEGIN
    SELECT eno,ename,salary INTO v_eno,v_ename,v_sal
        FROM employee WHERE eno = p_empno;
    dbms_output.put_line('사번 :'||v_eno);
    dbms_output.put_line('이름 :'||v_ename);
    dbms_output.put_line('급여 :'||v_sal);
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('알수 없는 에러');
 END;
 /
 
 --프로시저 호출
 EXECUTE emp_info(7788);
 
 -------------------------------------------------------------------
 
CREATE OR REPLACE PROCEDURE emp_info(
    p_empdno IN employee.dno%TYPE) IS
BEGIN
for empdno_buf in( SELECT * FROM employee WHERE dno = p_empdno)
    loop
    dbms_output.put_line('부서번호 : '||empdno_buf.dno||' 사원번호 : '||empdno_buf.eno||' 이름 : '||empdno_buf.ename||'/ 급여 : '||empdno_buf.salary);
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
    dbms_output.put_line('부서번호 : '||empdno_buf.dno||' 사원번호 : '||empdno_buf.eno||' 이름 : '||empdno_buf.ename||'/ 급여 : '||empdno_buf.salary);
    end loop;
    CLOSE EMP2_CURSOR;
END;
/

EXECUTE emp_info2(10);

--out 변수를 사용해보자
--부서 테이블에 데이터 추가 (dno,dname,loc 추가)
--기존 dno가 있으면 오류 아니면 추가됨
create or replace procedure dept_ins_p(
    v_dno in number, 
    v_dname in department.dname%type,
    v_loc in varchar2,
    v_result out varchar2 --외부로 정보를 출력
)is
    cnt number :=0; --실제 dno가 있는 지 판별하는 변수
--사용자 처리 예외처리 (exception)
    EXIST_DNO_ERR exception;
begin
    select count(*) into cnt from department where dno = v_dno and rownum = 1;--dno = v_dno 가 있으면 -- and rownum = 1 > 최종결과값을 1개만 
    if cnt > 0 then
        v_result :='등록된 부서번호';
        raise EXIST_DNO_ERR; --강제로 오류(예외)를 발생 exception 호출 -- (상수 변수는 가급적 대문자로 사용)
    else insert into department(dno, dname,loc) VALUES (v_dno,v_dname,v_loc);
        commit;
        v_result := '정상입력';
    end if;
exception 
 when EXIST_DNO_ERR then
 rollback;
 dbms_output.put_line('DB 에러발생');
end;
/

SET SERVEROUTPUT ON 
--out 전용 bind 변수
variable v_res varchar2(50); --넉넉하게 잡아야함 -- 오류 발생
execute dept_ins_p(12,'개발1팀','대구',:v_res);
print v_res;

var v_res varchar2(50);
execute dept_ins_p(15,'개발2팀','서울',:v_res);
print v_res;

--exception 발생
variable v_res varchar2(50); 
execute dept_ins_p(10,'개발1팀','대구',:v_res);
print v_res;

 
 