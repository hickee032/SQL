-- inner Join
use sqldb;

desc buytbl;
desc usertbl;
-- inner join 통상조인 조인은 2테이블 이상을 결합하여 결과를 출력하는 sql고급부분 현업에서도 많이 씀
select *
from usertbl
	inner join buytbl
	on usertbl.userID = buytbl.userID
    -- usertbl.userID , buytbl.userID 가 같은 것만 조인 한것이다.
    -- 그걸 대상으로 조건을 주었는데 buytbl.userID가 JYP인것만 출력한것이다.
where buytbl.userID = "JYP";

select* 
from usertbl;   

select* 
from buytbl;  
-- userID가 buytbl,usertbl 둘다 있다.  어디에 userID를 가져올지 모호하다
-- clumn의 모호성 ambiguous
select userid,name,prodname,addr,mobile1+mobile2 as '연락처'
from buytbl
inner join usertbl
on usertbl.userID = buytbl.userID;

-- 아래와 같이 쓴다면 코드가 상당히 난잡해진다.
select buytbl.userid,usertbl.name,buytbl.prodname,usertbl.addr,usertbl.mobile1+usertbl.mobile2 as '연락처'
from buytbl
inner join usertbl
on usertbl.userID = buytbl.userID;

-- 테이블에도 alias가 먹힌다는 것을 알아둬라
select U.userid,U.name,B.prodname,U.addr,U.mobile1+U.mobile2 as '연락처'
from buytbl as B
inner join usertbl as U
on U.userID = B.userID;

-- 아래 쿼리는 전체를 구할려는 쿼리를 구할려고 했다.
-- 하지만 이승기 조관우 임재범이 없다. inner join은 
select U.userid,U.name,B.prodname,U.addr,U.mobile1+U.mobile2 as '연락처'
from buytbl as B
inner join usertbl as U
on U.userID = B.userID
order by U.userID;

-- 위 조인 코드들은 buytbl에 의존적이다.

select *
 from buytbl;
 
select U.userid,U.name,B.prodname,U.addr,U.mobile1+U.mobile2 as '연락처'
from usertbl as U
left outer join buytbl as B 
-- left outer join앞에 있는 테이블이 left테이블이다. 왼쪽 테이블을 다 출력하란 뜻이다 
-- left table = from usertbl as U , right table = buytbl
on U.userID = B.userID
order by U.userID; 

-- 구매한 내역이 있는 사람만 출력한다.허나 중복되었다.
select U.userid,U.name,B.prodname,U.addr,U.mobile1+U.mobile2 as '연락처'
from buytbl as B
inner join usertbl as U
on U.userID = B.userID;

-- 아래는 구매한 사람들을 출력 distinct써서 중복을 제거한것이다.
select distinct U.userid,U.name,B.prodname,U.addr,U.mobile1+U.mobile2 as '연락처'
from buytbl as B
inner join usertbl as U
on U.userID = B.userID;
-- 아래 쿼리는 distinct와 같은 것을 출력 exists는 서브쿼리에 필드가 존재하는 지만 확인하여 리턴
-- exists는 존재하는 지만 묻고 boolean값으로 리턴해준다. where exists의 select를 비교해서 맞는 행이 있다면 리턴하여 출력하므로
-- 결과적으로 distinct와 같은 역할을 한다.
select U.userid, U.name, U.addr
from usertbl as U
where exists(
	select*
		from buytbl as B
		where U.userID=B.userID
);

use sqldb;

drop table if exists stdtbl;
create table stdtbl(
stdName varchar(10) not null primary key,
addr varchar(10) not null
);

drop table if exists clubtbl;
create table clubtbl(
clubName varchar(10) not null primary key,
roomNo varchar(10) not null
);

-- stdclubtbl은 외래키를 설정했다 이부분을 눈여겨 보자 외래키는 기본키와 함께 조인을 위해 사용한다
drop table if exists stdclubtbl;
create table stdclubtbl(
num int auto_increment not null primary key,
stdName varchar(10) not null,
clubName varchar(10) not null,
foreign key (stdName) references stdtbl(stdName),
foreign key (clubName) references clubtbl(clubName)
);

insert into stdtbl values('김범수','경남'),('성시경','경남'),('은지원','경기'),('조용필','경북'),('바비킴','서울');
insert into clubtbl values('수영','101호'),('바둑','102호'),('축구','103호'),('봉사','104호');
insert into stdclubtbl values(null,'김범수','바둑'),(null,'김범수','축구'),(null,'조용필','축구'),(null,'은지원','축구'),(null,'은지원','봉사'),(null,'바비킴','봉사');

select s.stdname,s.addr,c.clubName,c.roomNo
	from stdtbl as s -- 기준이 되는 테이블 
inner join stdclubtbl as sc 
	on s.stdName = sc.stdName
inner join clubtbl as c
	on sc.clubName = c.clubName
    order by s.stdName;

-- 동아리 명을 기준으로 조인하였다.
select c.clubname, c.roomno, s.stdname, s.addr
 from clubtbl as c
 inner join stdclubtbl as sc
 on c.clubName = sc.clubName
 inner join stdtbl as s
 on sc.stdName = s.stdName
 order by c.clubName;
		
