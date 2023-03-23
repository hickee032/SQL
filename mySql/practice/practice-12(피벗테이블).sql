-- 피벗테이블 구현하기
use sqldb;
drop table if exists pivottbl;
create table pivottbl(
uname varchar(10),
season varchar(10),
amount int);

select *
from pivottbl;

-- 데이터 삽입의 또 다른 방법
insert into pivottbl values('김범수','겨울',10),('윤종신','여름',15),('김범수','가을',25),('김범수','봄',5),('김범수','봄',37),('윤종신','겨울',40),('김범수','여름',14),('김범수','겨울',22),('윤종신','여름',64);

-- 피벗테이블을 만들때 집계함수 sum()과 if()문을 사용하면 쉽다

-- season이 봄이라면 amount를 sum해라

select uname,
	   sum(if(season='봄',amount,0)) as '봄',
       sum(if(season='여름',amount,0)) as '여름',
       sum(if(season='가을',amount,0)) as '가을',
       sum(if(season='겨울',amount,0)) as '겨울',
       sum(amount) as '합계'
from pivottbl
group by uname;   

select season,
	   sum(if(uname='윤종신',amount,0)) as '윤종신',
       sum(if(uname='김범수',amount,0)) as '김범수',
       sum(amount) as '합계'
from pivottbl
group by season
order by sum(amount);  