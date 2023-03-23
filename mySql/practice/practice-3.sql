use sqldb;

select *
  from usertbl
    where name="김경호";
    
 -- 출생년도 가 1970이후이고 키가 182 이상인 조건을 만족하는 데이터   
select *
  from usertblusertbl
    where birthYear >= 1970
     and height >= 182;

-- 출생년도 가 1970이후이거나 키가 182 이상인 조건을 만족하는 데이터 
 select *
  from usertbl
    where birthYear >= 1970
     or height >= 182;    
   
-- 키가 180이상 183이하 조건을 만족하는 데이터   
-- 1.관계 연산자 사용
select*
 from usertbl
  where height >= 180
   and height <= 183;

-- 2.between 과 and를 사용
-- 위의 코드는 between ~ and 구문으로 바꿀수 있다. 위와 의미는 동일하다
-- between ~ and이 시각적으로 보기가 좋다. (현업에서 사용이 많다.)
-- 통상수치 데이터에 많이 사용된다.
select*
 from usertbl
  where height between 180 and 183;

-- addr 지역이 경남이거나 전남이거나 경북이거나 전북인것  
select name,addr
 from usertbl
	 where addr = '경남'
		or addr = '전남'
		or addr = '경북'
		or addr = '전북';
 
 select name, addr
  from usertbl
  where addr in('경남','전남','경북','전북');
 
-- 성이 김씨인 데이터를 추출 
select name, addr
	from usertbl
    where name like '김%';

-- 한글자에 대한것은 _(언더바)로 대체 할수 있다.
select name,addr
	from usertbl
    where name like '_종신';
    
-- like와 %구문은 통상적인 검색에 많이 쓰인다.  

select *
	from usertbl; 

desc usertbl;

-- update 테이블명 set 수정할 컬럼명 where 조건절
-- 테이블에 있는 데이터를 수정
-- pk(기본키 primery key)는 수정할수 없다.
update usertbl
	set addr = '부산'
	where userID = 'BBK';
    
create table test(
num int ,
name varchar(20)
);

insert into test values(1,'신은혁');

select *
 from test;

-- delete행을 하나씩 가져와서 삭제 truncate 한꺼번에 가져와서 삭제

-- 트랜잭션(누군가가 사용하고 있는 지를 테스트하는일)이 작동한다.
delete from test;
-- 트랜잭션(누군가가 사용하고 있는 지를 테스트하는일)이 작동하지 않는 다.
truncate test; 



    

   
   