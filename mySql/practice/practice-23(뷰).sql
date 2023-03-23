use sqldb;

-- inner join - > view로 만드는 쿼리 select의 내용을 view로 만들어서 이용하겠다
-- 한번 만들고 view를 이용하면 편하다.
create or replace view v_userbuytbl 
	as 
		select u.userid as 'USERID',u.name as 'USERNAME',b.prodname as "PRODNAME", u.addr as "주소", concat(u.mobile1,u.mobile1) as "연락처"
		from usertbl u
		inner join buytbl b
			on u.userid = b.userid
		order by u.userid;   

select *
	from v_userbuytbl
where `USERID` = "BBK";

select *
	from v_userbuytbl
where USERID = "BBK";

select *
	from v_userbuytbl
where 주소 = "서울";

-- 필드별로 조회하고싶으면 알리아스 준걸로 
-- 필드명을 주고 공백이 있다면 백틱을 사용해 감싸야한다.
-- 공백이 없다면 그냥 알리아스로 한영 상관 없이 select를 하면된다.
-- 왠만하면 view 를 select 할때는 ``를 쓰도록하자.
-- 왠만하면 한글을 쓰지 않도록 하자

select USERID,USERNAME,주소,연락처
	from v_userbuytbl;
    
-- 뷰를 수정해보자

alter view v_userbuytbl 
	as 
		select u.userid as '사용자아이디',u.name as '이름',b.prodname as "제품명", u.addr as "주소", concat(u.mobile1,u.mobile1) as "연락처"
		from usertbl u
		inner join buytbl b
			on u.userid = b.userid
		order by u.userid;     

select *
from v_userbuytbl;

-- view를 삭제시 drop를 사용한다.
drop view v_userbuytbl; 

-- 또다른 view를 생성
create or replace view v_usertbl
as
	select userid,name,addr
		from usertbl;
-- view는 테이블과 유사하게 되어있다 하지만 제약조건은 보이지 않는 다.
desc usertbl;
desc v_usertbl;

-- 뷰를 통해서 수정을 하니 수정이 되었다. 그리고 실제테이블을 확인해봐도 변경이 되었다.
select *
	from v_usertbl;

update v_usertbl
	set addr = "부산"
    where userid = "EJW";
-- 삽입이 되지 않는 이유는?
-- usertbl에 birthYear가 not null이기 때문이다.
-- 꼭 데이터를 삽입하고 싶다면 birthyear를 추가다던가 birthYear에 디폴트 값을 주던가 아니면 null로 설정해야할것이다.
desc usertbl;
insert into v_usertbl(userid,name,birthYear,addr)values("KBM","김병만",1970,"충북");

-- 뷰를 수정
create or replace view v_usertbl
as
	select userid,name,addr,birthyear
		from usertbl;

insert into v_usertbl(userid,name,addr,birthYear) values("KBM","김병만","충북","1975");
-- 뷰를 생성할때 필요 없는 데이터라도 not null 속성을 가지고 있다면 뷰에 포함을 시켜줘야 할것이다.

-- 집계함수와 group by, order by를 이용하는 view
create or replace view v_sum
as
	select userid as "USER ID", sum(price*amount) as "합계"
    from buytbl
    group by userid
    order by sum(price*amount) desc;

-- 집계함수시 조회는 가능    
select *
	from v_sum;
-- 집계함수가 들어있는 view는 데이터를 변경할수 없음을 기억하자.
update v_sum
	set 합계  = 2000
    where `USER ID` = "BBK";
-- view가 업데이트가 가능한지 알아보는 구문

-- information_schema 시스템 데이터 베이스 is_updatable을 보면 no로 설정되어있다.
-- 집계함수를 적용한 테이블은 수정 삭제가 불가능하다
-- union all , distict ,group by,join 도 불가능 하다.
select *
	from information_schema.views;

create or replace view v_height177
as
	select *
		from usertbl
        where height >= 177;

select *
	 from v_height177;
     
-- 실행은 되지만 키가 177미만인 사람은 view에 존재하지 않는 다.
delete from v_height177
	where height < 177;

select *
 from usertbl;    
-- view 는 테이블에 의존적이기 때문에 테이블을 삭제하면 다 삭제된다. 

-- 이렇게 하면 실제 테이블에 영향을 미치게된다
insert into v_height177 values("SEH","신은혁",2008,"구미",null,null,147,"20100505");
delete from usertbl where userid = "SEH";

alter view v_height177
as
	select *
		from usertbl
        where height >= 177
        with check option; -- 177이하는 삽입을 안하겠다라는 뜻이다.

-- 이렇게 하면 들어가지 않는 다.
insert into v_height177 values("SEH","신은혁",2008,"구미",null,null,147,"20100505");       
insert into v_height177 values("SEH","신은혁",2008,"구미",null,null,187,"20100505");  

select *
	from v_height177;

-- join view를 만든다.
create or replace view v_userbuytbl 
	as 
		select u.userid as 'USERID',u.name as 'USERNAME',b.prodname as "PRODNAME", u.addr as "주소", concat(u.mobile1,u.mobile1) as "연락처"
		from usertbl u
		inner join buytbl b
			on u.userid = b.userid
		order by u.userid;
-- concat 어떤 테이블에 저장될것인지 모호하다 (userid가 usertbl,buytbl에 존재한다.)
insert into v_userbuytbl values("PKL","박경리","경기","000000","20191010");         

drop table buytbl,usertbl;    
-- 참조할 테이블이 삭제되어서 view가 실행되지 않는 다.
select *
	from v_userbuytbl;
-- 뷰가 어떤테이블을 참조하고 있는 지 확인하는 방법
check table v_userbuytbl;
show create view v_userbuytbl;
desc v_userbuytbl;
show tables;

SHOW FULL TABLES;
    
    
	