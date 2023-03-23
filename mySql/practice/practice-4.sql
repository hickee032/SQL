use sqldb;

-- 서브쿼리는 굉장히 중요하다. 반드시 기억하도록 하자

-- 아래의 쿼리문의 경우에는 김경호의 키가 177인것을 내가 알고 있을 경우에만 쓸수 있는 쿼리문이다.
-- 그러나 내가 김경호의 키를 모를때에는 어떻게 해야할까.

select name,height
	from usertbl
		where height >=177;
        
-- 서브쿼리는 쿼리문안에 또 쿼리문이 존재하는 것
-- 아래는 키가 177이상이 되는 데이터를 출력
-- 그러나 김경호의 키가 177인것을 모를때 어떻게 할까
-- 이때에는 적절하게 서브쿼리를 이용하도록한다.     
-- 서브쿼리의 실행순서는 ()안의 서브쿼리가 먼저 실행되고 (서브쿼리의 값 =177)
-- 나온 결과값으로 상위 쿼리가 실행된다.   

select name,height
	from usertbl
		where height >= (select height 
							from usertbl
								where name = "김경호");
                                
select name,height
	from usertbl
		where height >= (select height 
							from usertbl 
								where addr="경남");
                                
-- 하여 위의 코드를 실행하고자 하려면 아래와 같이 작성하도록한다.
-- any 키워드를 이용하여 실행해보면된다.
-- 서브쿼리의 값은 170,173이다.                                
                                
select name,height
	from usertbl
		where height >= any(select height 
								from usertbl 
									where addr="경남");    
                                    
select name,height
	from usertbl
		where height >= some(select height 
								from usertbl 
									where addr="경남");      

-- all 서브쿼리의 결과 값이 둘다 만족하는 데이터만 출력한다.
-- 다시말해서 170,173이다 둘다 만족하는 값은 173이다.
  
select name,height
	from usertbl
		where height >= all(select height 
								from usertbl 
									where addr="경남");                                     

select name,height
	from usertbl
		where height = any(select height 
								from usertbl 
									where addr="경남");                                      

-- 위와 같은 결과를 얻고자 한다면 앞에서 배운 in을 사용하면 쉽게 해결된다.                                    
select name,height
	from usertbl
		where height in(select height 
							from usertbl 
								where addr="경남");    

-- select - from - order by 컬럼명
-- select - from - where - order by 컬럼명

select*
	from usertbl
		order by name asc;

select*
	from usertbl
		order by name desc;   

select addr
	from usertbl;
  
-- 중복을 제거해서 보고자 할때는 distinct 키워드를 쓰도록 한다 (현업에서는 정말 많이 쓴다.)  
select distinct addr
		from usertbl;
        
use employees;    

select*
	from employees;   
    
-- limit는 데이터 갯수의 제한을 두는 키워드이다.
-- limit를 쓰지않는 다면 모든 데이터를 긁어서 가져와서 쿼리를 치니 굉장히 비효율적이다.
-- 하여 적절히 limit를 쓰도록 하자

select*
	from employees
		order by hire_date
			limit 5;

-- limit 100,5; 경우 100번째 부터 5명을 출력하는 것이다.
            
select*
	from employees
		order by hire_date
			limit 100,5;
            
use sqldb; 
        
-- 테이블을 복사하는 방법
-- 설명을 하자면 buytbl의 모든 데이터를 조회해서 그 데이터를 가지고 
-- buytbl2를 만들어라는 뜻이다.
drop table if exists buytbl2;

create table buytbl2(
select* -- 모든것을 복사
	from buytbl
);

select*
	from buytbl2;
-- 하지만 테이블을 복사하더라고 제약조건 PK FK는 복사 되지 않는다    
-- 반드시 기억하도록하자
desc buytbl;
desc buytbl2;   



  
		
		
                                
                                    
                                    

