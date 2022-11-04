--11/1
--CRUD 
--DDL DML DCL TCL 

--select 연습

--사원 테이블에 모든 요소 출력
select * from employee;
--사원 테이블 에 eno,ename 출력
select eno ,ename  from employee;

--as를 사용해 테이블 칼럼에 별명을 지어줌
select eno as 사원번호 ,ename as 사원명  from employee;
--as를 생략
select eno 사원번호 ,ename 사원명  from employee;
--공백이 있는 경우는 쌍따옴표("")를 붙여줘야 한다 
select eno 사원번호 ,ename "사원 이름"  from employee;

-- 산술 연산도 가능 salary*12 하지만 반드시 연산되는 대상이 NUMBER 여야함
select ename 사원명 ,salary 월급 ,salary*12 연봉 from employee;

--중복제거 distinct
select dno from employee; --중복 제거 전
select distinct dno from employee; --중복 제거 후

---------------------------------------------------------------------------

--조건을 써서 검색


/*  select 컬럼명
    from 테이블명
    where 조건    */
    
select eno 사원번호, ename 사원명 ,salary 월급 from employee
where salary = 1500;

select eno 사원번호, ename 사원명 ,salary 월급 from employee
where salary >= 1500;

--같지 않다 <> != ^=
select eno 사원번호, ename 사원명 ,salary 월급 from employee
where salary <> 1500;

select eno 사원번호, ename 사원명 ,salary 월급 from employee
where salary != 1500;

select eno 사원번호, ename 사원명 ,salary 월급 from employee
where salary ^= 1500;

--varchar 일 경우 (' ') 필요함
select *from employee 
where ename = '스콧';

--날짜 데이터 조회 (' ') 필요함 hiredate - date타입
select * from employee
where hiredate <= '1981/01/01';

/*  논리 연산자 
    AND OR NOT */

--둘다 true
select *from employee
where dno = 10 and job = '매니저';

--하나만 true
select * from employee
where dno  = 10 or job ='매니저';

--부서번호가 10이 아닌 사원
select * from employee
where not dno = 10;

/*  BETWEEN AND 연산자  
    BETWEEN a AND b
    a :하한값 b:상한값 */
    
select * from employee
where salary between 1000 and 1500;

--입사일이 81/01/01 81/12/31 사이 날짜 (' ')
--날짜 (' ')
select ename 사원명,hiredate 입사일 from employee
where hiredate between '81/01/01' and '81/12/31';

--in(a,b,c) a 이거나 b 이거나 c인 것
--in(300,500,1400) NUMBER 타입만 가능
select * from employee
where commission in(300,500,1400);

--in(a,b,c) a 이거나 b 이거나 c가 아닌 것
--not in(0,500,1400)
select * from employee
where commission not in(300,500,1400);

/*LIKE 칼럼에 저장된 데이터의 일부만 일치하더라도 조회가 가능
% : 자리수가 의미 없음 %길동 김길동 홍길동 박길동 다 검색됨
_ : 자리수 에 따라 달라짐 
*/

--사원명이 '스'로 시작하는 모든 사원
select * from employee
where ename like '스%';

--사원명이 '스'로 시작하는 모든 사원을 제외
select * from employee
where ename not like '스%';

--사원명이 '스'로 끝나는 모든 사원
select * from employee
where ename like '%스';

--사원명이 '스'로 끝나는 모든 사원을 제외
select * from employee
where ename not like '%스';

--사원명에 '드'가 포함된 사원
select * from employee
where ename like '%드%';

--'_'는 한문자에 대해서 
select * from employee
where ename like '_스'; --앞에 한글자 다음에 '스' 가 들어가는 경우

select * from employee
where ename like '__스'; --앞에 두글자 다음에 '스' 가 들어가는 경우

select * from employee
where ename like '스_'; --앞에 '스'가 있고 뒤에 한글자가 있을 경우

select * from employee
where ename like '스__'; --앞에 '스'가 있고 뒤에 두글자가 있을 경우

/*IS NULL 값을 알수 없다 라는 뜻임*/

--NULL 값만 출력 0이면 제외
select * from employee
where commission is null;

--NULL 값이 아닌 값 출력
select * from employee
where commission is not null;
    
/*정렬 ORDER BY 오름차순 ASC 1,2,3,4,5
               내림차순 DESC 5,4,3,2,1
               오름차순은 ASC를 생략가능하다*/    
               
select * from employee
order by salary asc;

select * from employee
order by salary desc;

select * from employee
where manager is not null
order by salary desc;

--salary 내림차순으로 정렬하되 값이 같을 경우 ename을 오름차순으로 정렬
select * from employee
order by salary desc, ename asc;



/*inner join 
select e.ename 사원명 ,d.dname 부서명 from employee e
inner join department d
on (e.dno=d.dno)
where e.dno = 20;*/

-------------------------------------------------------------

--1.사원 번호가 7788 인 사원의 이름 부서번호
select ename 사원이름, dno 부서번호 from employee
where eno = 7788;


