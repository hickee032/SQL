use sqldb;

-- inner join은 on 조건에 맞는 행만 리턴

-- 10개
select *
from usertbl;

-- 12개
select *
from buytbl;

-- left outer
-- 어느 한쪽의 데이터를 다 긁어올때
select u.userid, u.name, b.prodname, u.addr, concat(u.mobile1,u.mobile2)
from usertbl as u
left outer join buytbl as b
	on u.userid = b.userid
    order by u.userid;
    
select u.userid, u.name, b.prodname, u.addr, concat(u.mobile1,u.mobile2)
from usertbl as u
right outer join buytbl as b
	on u.userid = b.userid
    order by u.userid;
    
select u.userid, u.name, b.prodname, u.addr, concat(u.mobile1,u.mobile2)
from usertbl as u
left outer join buytbl as b
			on u.userid = b.userid
-- prodName 이 null이면 구매한적이 없다는 뜻이다.           
    where b.prodName is null
	order by u.userid;
    
select *
from stdclubtbl;   

select *
from stdtbl;

-- 클럽에 가입한적이 없는 사람만 출력하는 쿼리
select s.stdname,s.addr,c.clubname, c.roomno
from stdtbl as s
left outer join stdclubtbl as sc
	on s.stdname = sc.stdname
left outer join clubtbl as c
	on c.clubName = sc.clubName
where c.clubName is null;

-- 한명도 가입하지 않은 동아리
select c.clubname
	from stdtbl as s
    left outer join stdclubtbl as sc
		on s.stdName = sc.stdName
    right outer join clubtbl as c
		on sc.clubName = c.clubName
    where s.stdName is null;
    
-- union 합집합 위의 두개의 결과을 동시에 보고싶을때
-- 클럽에 가입한적이 없는 사람과 한명도 가입하지 않은 동아리

select s.stdname,s.addr,c.clubname, c.roomno
from stdtbl as s
left outer join stdclubtbl as sc
	on s.stdname = sc.stdname
left outer join clubtbl as c
	on c.clubName = sc.clubName
where c.clubName is null

union -- 합집합

select s.stdname,s.addr,c.clubname, c.roomno
	from stdtbl as s
    left outer join stdclubtbl as sc
		on s.stdName = sc.stdName
    right outer join clubtbl as c
		on sc.clubName = c.clubName
    where s.stdName is null;

-- cross join 하나의 행이 또다른 테이블의 전체행과 엮이는 것
-- 결과 두 테이블의 개수를 곱한 개수가 되는 것
-- 카티션 곱(cartesion product)이라 한다 통산 대용량  데이터를 생성할 목적으로 사용을 한다.

use sqldb;

select *
	from buytbl
    cross join usertbl;

use employees;  
-- 300,024*443,308 = '데이터개수'
select count(*) as '데이터 개수'
from employees
cross join titles;

-- self join
-- 이조인은 테이블 하나로 두번이상 엮어서 결과값을 얻어오는 것을 말한다.
-- 우대리의 상관은 이부장, 이부장의 전화번호를 알고싶다. 어떻게 쿼리를 만들면 될까?
use sqldb;
drop table if exists emptbl;

create table emptbl (
emp varchar(10) not null,
manager varchar(10),
emptel varchar(10)
);

desc emptbl;

insert into emptbl values ('나사장',null,'0000'),('김재무','나사장','2222'),('김부장','김재무','2222-1'),('이부장','김부장','2222-2'),('우대리','이부장','2222-2-1'),
('지사원','이부장','2222-2-2'),('이영업','나사장','1111'),('한과장','이영업','1111-1'),('최정보','나사장','3333'),('윤차장','최정보','3333-1'),('이주임','윤차장','3333-1-1');

select *
 from emptbl;

-- self join 
-- 우대리의 상관인 이부장의 전화번호를 추출해보자
-- 하나의 테이블에 manager와 emp 필드가 같고 where절을 우대리로 주면 될것이다.
select a.emp as '부하직원',b.emp as '직속상관', b.emptel
	from emptbl as a
    inner join emptbl as b
		on a.manager = b.emp
        where a.emp = '우대리';

-- union, union all의 차이
-- union,union all은 갯수의 제한이 없다.
-- 9개 (중복된것이 없다) union은 중복제거
select *
from stdtbl
union
select *
from clubtbl;
-- 9개 (중복된것이 없다)
select *
from stdtbl
union all
select *
from clubtbl;

-- not in 은 제외 in은 포함
-- concat은 문자열을 연결하는 함수이다.
-- 핸드폰을 가지고 있는 사람만 추출
select name, concat(mobile1,mobile2) as '연락처'
	from usertbl
	where name not in (
		select name
			from usertbl
			where mobile1 is null
);
-- 핸드폰 번호가 없는 사람만 출력하게 된다.
select name, concat(mobile1,mobile2) as '연락처'
	from usertbl
	where name in (
		select name
			from usertbl
			where mobile1 is null
);



    
	

