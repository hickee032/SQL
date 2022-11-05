--11/02_1

/*DUAL  TABLE
    오라클 자제 제공 테이블
    함수의 결과값을 확인할떄 사용하는 테이블
    SYSTEM 사용자가 소유한 표준 테이블 (어느 사용자나 접근가능)
    한행 한컬럼을 담고 있는 Dummy 테이블
    
    함수의 쓰임을 알고싶을 때 특정 테이블을 생성할 필요 없이 DUAL테이블을 사용
    함수의 값을 리턴받을수 있음 */
    
--함수 (리턴값이 존재) -- 아래는 오라클에서만 사용, 표준은 아니다    
SELECT 'Oracle mania',
    UPPER('Oracle mania'), -- 전부 대분자
    LOWER('Oracle mania'), --전부 소문자
    INITCAP('Oracle mania') --단어의 첫 글자를 대문자로 변환
from DUAL;

--LENGTH (한글 1바이트)
select length('Oracle mania'),length('오라클매니아')
from DUAL;
--LENGTHB (한글 2바이트)
select lengthb('Oracle mania'),lengthb('오라클매니아')
from DUAL;

/* 문자 처리 함수 (문자 조작 함수)
concat 문자의 값 연결
substr 문자를 잘라 추출 한글 1바이트
substrb 문자를 잘라 추출 한글 2바이트
instr 특정 문자의 위치 값을 반환 한글 1바이트
instrb 특정 문자의 위치 값을 반환 한글 2바이트
lpad,rpad 입력 받은 문자열과 기호를 정렬하여 특정길이 의 문자열로 반환
trim 잘라내고 남은문자를 표시 */

/*숫자함수
round 특정자릿수에서 반올림
trunc 특정자릿수에서 잘라냄(버림)
mod 입력 받은 수를 나눈 나머지 */

select 98.7654,
    round(98.7654), --소수점 반올림 -> 정수로 변환
    round(98.7654,2), --소수점 두번쨰 자리 반올림
    round(98.7654,-1) --소수점 이전에서 반환
from DUAL;    


select 98.7654,
    trunc(98.7654), --소수점 잘라냄
    trunc(98.7654,2), --소수점 두번쨰 자리 잘라냄
    trunc(98.7654,-1) --소수점 이전 잘라냄
from DUAL;

/*날짜 함수
SYSDATE 시스템 저장 현재 날짜를 반환
MOTHS_BETWEEN 두 날짜 사이의 개월수
ADD_MONTHS 특정 날짜의 개월수 더함
NEXT_DAT 특정날짜에서 최초로 도래하는 인자로 받은 요일의 날짜를 반환
LAST_DAY 해당달의 마지막 날짜
ROUND 인자로 받은 날짜를 특정 기준으로 반올림
TRUNC 인자로 받은 날짜를 특정 기준으로 잘라냄
*/

--현재 날짜
select sysdate
from DUAL;

--날짜 연산(날짜 + 숫자),(날짜 - 숫자)
--그 날짜로부터 숫자만큼 지난 날짜를 계산
select sysdate -1 어제,
       sysdate 오늘,
       sysdate+1 내일
from DUAL;

--employee 테이블 사원의 근무일수 계산
select ename 사원명, round(sysdate-hiredate) 근무일수
from employee;

--trunc 잘라낸다는 의미가 약간 다름 그 달의 첫째 일로 만듬
--초기화 비슷하게 만듬 trunc(hiredate,'year') 80/12/17->80/01/01

select hiredate,
        trunc(hiredate,'year')
from employee;

select hiredate,
        trunc(hiredate,'month')
from employee;

--months_between 날짜와 날짜 사이의 개월 수 계산
select ename,sysdate,hiredate,
       months_between(sysdate,hiredate)--소수로 표시됨
from employee;

select ename,sysdate,hiredate,
       trunc(months_between(sysdate,hiredate))
from employee;

--add_months 개월 수를 더함 
select ename,hiredate,
       add_months(hiredate,6)
from employee;

--최초로 오는 요일에 해당하는 날짜
select sysdate "현재 날짜",
       next_day(sysdate,'토요일') "이번 토요일의 날짜"
from dual;

/* 형변환 함수
to_char 날짜 혹은 숫자형을 문자형으로
to_date 문자형을 날짜형으로
to_number 문자형을 숫자형으로
*/

select ename 사원명, hiredate 입사일,
       to_char(hiredate,'YY-MM'),
       to_char(hiredate,'YYYY/MM/DD DAY')
from employee;

--한글을 사용하여 출력하는 방법
--'YY-MM' >> 'YY"년"MM"월"'
select ename 사원명, hiredate 입사일,
       to_char(hiredate,'YY"년" MM"월"'),
       to_char(hiredate,'YYYY"년" MM"월" DD"일" DAY')
from employee;

--NVL NULL을 0이나 다른 값으로 변환
--NVL(a,b) a 를 b로 바꿔서 출력(테이블 데이터에는 변함이 없음)
select ename,salary,commission,
    nvl(commission,0),
    salary*12+ nvl(commission,0)
from employee
order by job;

--DECODE
--조건에 따라 다양한 선택
--switch 문과 비슷함
select ename,dno,
     decode(dno,10,'ACCOUNTING',
                20,'RESERCH',
                30,'SALES',
                40,'OPERRATING',
                'DEFALT') as dname
from employee
order by dno;

--한글도 사용 가능        
select ename 사원명 ,dno 부서번호,
    decode(dno,10,'회계',
               20,'연구',
               30,'판매',
               40,'관리',
                'DEFALT') as dname
from employee
order by dno;

--CASE
--조건에 따라 다양한 선택
--switch 문과 비슷함

select ename 사원명,dno 부서번호,
case when dno=10 then 'ACCOUNTING'
     when dno=20 then 'RESERCH'
     when dno=30 then 'SALES'
     when dno=40 then 'OPERRATING'
else 'DEFALT'
end as 부서명
   from employee
   order by dno;

--한글 사용   
select ename 사원명,dno 부서번호,
case when dno=10 then '회계'
     when dno=20 then '연구'
     when dno=30 then '판매'
     when dno=40 then '관리'
else '대기'
end as 부서명
   from employee
   order by dno;   
   
select ename 사원명,dno 부서번호,
case when dno=10 then '회계'
     when dno=20 then '연구'
     when dno=30 then '판매'
     when dno=40 then '관리'
else '대기중'
end as 부서명,
case when 4000 <= salary  then '임원'
     when 3000 <= salary and salary <4000 then '부장'
     when 2000 <= salary and salary <3000 then '대리'
     when 1000 <= salary and salary <2000 then '사원'
else '인턴'
end 직급,
salary 급여
   from employee
   order by salary desc;   

--여러개를 함께 쓸수도 있다.   
select ename 사원명,dno 부서번호,
case when dno=10 then '회계'
     when dno=20 then '연구'
     when dno=30 then '판매'
     when dno=40 then '관리'
else '대기중'
end as 부서명,
case when 4000 <= salary  then '임원'
     when 3000 <= salary and salary <4000 then '부장'
     when 2000 <= salary and salary <3000 then '대리'
     when 1000 <= salary and salary <2000 then '사원'
else '인턴'
end 직급,
salary 급여
   from employee
   order by salary desc;   
