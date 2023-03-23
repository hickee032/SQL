-- 시스템 DB인 mysql을 사용하겠다
use mysql;
show tables;

-- mysql db에는 employees 테이블이 없어서 오류가 발생한다.
select *
	from employees;
    
--  아래와 같이 직접 DB명.테이블명으로써 기재를 하여 select해야한다.
--  아니면 use employees;를 하고 조회하면 된다.
 select *
	from employees.employees;
    
use employees;

select *
 from titles;
 -- 아래와 같이 원하는 열만 가져올수도 있다 원하는대로 나열해주면 된다.
 -- as는 알리아스(별명)으로서 열의 명을 임의대로 사용자가 바꿀수 있다.
 
select first_name as '성',last_name as '이름',gender as '성별'
	from employees;
    
 -- 만약에 DB명과 table명이 생각이 나지 않는다면  먼저 DB를 조회해보고 DB를 선택한다.    
show databases;
use employees;
-- DB를 선택한후에 table명이 생각이 나지 않는 다면  아래와 같이 진행한다.
show tables;
-- 두번째 방법은 좀더 자세하게 보고자 할때 사용한다.
show table status;

select*
 from employees
  where gender = 'M';
