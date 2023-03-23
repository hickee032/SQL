use sqldb;

-- dual은 가상의 테이블이다.
select 1+3;
-- from dual;

-- cast문은 현재 문자열을 date타입으로 캐스팅
select cast("2020-10-12 12:22:22:456" as datetime) as "시각"
	from dual;
    
-- 변수에 대해 알아보자
use sqldb;
-- 변수는 set변수로 시작하여 @변수명으로 지정할수 있다.
set @myvar1 = 5;
set @myvar2 = 3;
set @myvar3 = 4.25;
set @myvar4 = "가수이름==>";

select @myvar1;
select @myvar2+@myvar3;

select name
	from usertbl
    where height >180;
-- 보기좋게 출력하기 위해서 변수를 이용    
select @myvar4,name
	from usertbl
    where height >180;   
    
select @myvar4,name
		from usertbl
        where height>180
        -- limit은 변수를 사용할수 없다.
        -- limit @myvar2;

select @myvar4,name
		from usertbl
        where height>180
        -- limit은 변수를 사용할수 없다.
        limit 2;

set @myvar1 = 3;

-- 동적으로 실행
-- prepare.. execute.. using문을 사용하면 된다
-- 일단 아래 쿼리는 변수를 지정 myquery명으로 ""안에 쿼리문을 준비를 하는 것이다alter근데 ?가 있다 이 ?는 @myvar1변수값이 저장이되어 execute문이 실행되는 것이다.
-- 예를 들어 응용프로그램에서 사용자로 부터 입력을 받아서 출력한다면 이렇게 변수를 사용하면 좋을 것이다. 중요하니 잘 알아보도록하자
prepare myquery
   from "select name, height
			from usertbl
            order by height
            limit ?";

-- @myvar1는 와일드 카드 ?에 들어가게 된다.
execute myquery using @myvar1;    

select avg(amount) as "평균 구매 횟수"
		from buytbl;    
        
-- cast 사용
select cast(avg(amount) as decimal) as "평균 구매 횟수"
		from buytbl; 
-- integer를 사용하기 위해선
select cast(avg(amount) as signed integer) as "평균 구매 횟수"
		from buytbl;   

-- convert()사용   
select convert(avg(amount) , signed integer) as "평균 구매 횟수"
		from buytbl;   
        
--  cast는 as, convert는 ,(콤마) 사용  
-- 날짜 형식 안에는 어떤 구분자가 들어가도 상관없이 date타입으로 casting된다
select cast("12@12@12" as date);             
select cast("12#12#12" as date);
select cast("12#12@12" as date);

-- concat()은 문자를 연결해주는 함수이다
select num, concat(cast(price as char(10)),"*",cast(amount as char(4))) as "단가 * 수량" ,price*amount as "구매액"
	from buytbl;        

        