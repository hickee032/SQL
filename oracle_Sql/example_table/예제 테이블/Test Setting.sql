-- 주석처리 방법 한줄 주석은 -- 여러 줄 주석은 /* */
--setting
-- 11g 호환을 위해 사용함
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

-- 일반계정을 생성 : 관리자로 접속 
-- > 아이디 ---- 비번이 ----인 계정을 생성함
CREATE USER xxxx IDENTIFIED BY xxxx;

-- 접속 권한 부여해야 DB에 접속을 할수 있다
-- 관리자로 접속을 했는지 일반계정으로 접속을 했는지 헷갈리면 안됨
-- grant 권한 부여
grant connect, resource to test;

-- 테이블 사용 권한 부여
alter user test quota unlimited on users;

--녹색 실행 버튼 ->  지정한 범위 만큼만 실행 (단위 별로 실행)
--두번째 실행 버튼 -> 한꺼번에 실행


