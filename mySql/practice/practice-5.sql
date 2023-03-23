-- 기본적 쿼리문의 순서 물론 해당줄은 생략가능하다. 하지만 전부 다 사용하게 된다면 반드시 순서를 지켜야한다.
-- select
-- form
-- where
-- group by
-- having

use sqldb;

-- 고객이 구매한 건수를 확인 하지만 중복되는 것이 많이 나옴

select userID , amount
from buytbl
order by amount desc;

-- 아래 쿼리문을 실행해보면 고객별로 구매한 건수가 바로 한눈에 들어온다.
-- 여기서 sum이 나왔는 데 이것은 집계함수이며 아울러 group by 를 할때 즉 그룹을 지을때 userid로 하겠다는 의미
-- 집계함수 가 나오면 무조건 group by가 들어가야함.

select userid as "아이디",sum(amount) as "구매건수"
from buytbl
group by userid
order by sum(amount) desc;

-- 총구매액을 집계
-- 총구매액은 수량*단가
select *
	from buytbl;

-- 총구매액을 기준으로 내림차순으로 정렬
select userid as "아이디", sum(amount*price) as "총구매액"
		from buytbl
        group by userid
        order by sum(amount*price) desc;
        
-- 모든 고객을 대상으로 평균 구매갯수를 알아보는 쿼리 
 select avg(amount)
	from buytbl;

-- 사용자 별로 구매건수를 구하는 쿼리;
--  userid 그룹짓고 avg(amount)로 내림차순
    
select userid as '아이디', avg(amount) as '평균 구매갯수'
	from buytbl
    group by userid
    order by avg(amount) desc;
  
-- 최대값 max 최소값 min
select name,height
		from usertbl;

select name,max(height),min(height)
	from usertbl
	group by name;

-- 둘다 만족하는 값을 얻기위해서
select name, height
	from usertbl
    where height = (select max(height) from usertbl) or height = (select min(height) from usertbl);

-- union 각각의 쿼리 결과를 중복제거후 붙이는 키워드
select name, height
	from usertbl
    where height = (select max(height) from usertbl)
union
select name, height
	from usertbl
    where height = (select min(height) from usertbl);

-- 건수를 집게하는 count() 
-- usertbl에 있는 데이터 건수를 집계
select count(*)    
	from usertbl;
    
-- 그럼 핸드폰을 거지고 있는 사람의 건수만 집게해보는 쿼리를 만들어본다
-- 아래 두 쿼리문은 동일한 결과를 나타낸다 항상 말하지만 프로그램에서는 정답이 없다 결과만 도출하면 된다.

select count(*) as "휴대폰이 없는 사람"
	from usertbl
    where mobile1 is null 
    and mobile2 is null;
    
select count(*) as "휴대폰이 있는 사람"
	from usertbl
    where mobile1 is not null
    and mobile2 is not null;
    
use employees;  

-- 단순히 건수만 확인하고자 한다면 count()를 사용하자.
select*
	from employees;

select count(*)    
	from employees;

use sqldb;
-- having 절
select userid as '아이디', sum(price*amount) as '총구매액'
from buytbl
group by userid
order by sum(price*amount) desc;

-- 총구매액이 1000만원 이상만 보고싶다.
-- 조건이니 where를 쓰면 될꺼라고 생각하지만 오류가 난다.
-- 다시말해서 where절에서는 집계함수를 사용할수가 없다. <- 매우 중요하다.
-- 그룹함수를 가지고 조건을 줄수 있는 절이 having절이다

select userid as '아이디', sum(price*amount) as '총구매액'
from buytbl
group by userid
having sum(price*amount) >= 1000
order by sum(price*amount) desc;

-- with rollup에 대해 살펴보면  아래 쿼리의 결과를 보면
-- groupname별로 소합게를 내어주고 마지막에는 총합게를 보여준다.
-- 아주 유용한 키워드이다 기억하자
select num, groupname, (price*amount)
from buytbl
group by groupname,num
with rollup;

-- 만약 건 바이 건으로 보고싶지 않다면 num을 제외해주면된다
-- 요약해서 보고자한다면
select num, groupname, (price*amount)
from buytbl
group by groupname
with rollup;

  
    
    