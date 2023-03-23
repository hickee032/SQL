-- index
use sqldb;
# 외래키 제거
alter table buytbl
	drop foreign key buytbl_ibfk_1;

# pk 때문에 userid(pk)순으로 정렬이 되어있다. 즉 다시말해 클러스터형 인덱스가 만등어 졌다.
# pk 설정을 해주면 자동으로 인덱스가 추가되어 정렬된다 (클러스터형 인덱스)
select *
	from usertbl;
show index from usertbl;
desc buytbl;
# index_length = 보조 인덱스 data_length = 클러스터형 인덱스
show table status; 

# 테이블 생성
drop table if exists tbl1;
create table tbl1(
	a int primary key,
    b int ,
    c int
);
# Non_unique 가 0이다 Non_unique가 아니다란 뜻이다.
# PRIMARY 클러스트형 인덱스란 뜻이다.
show index from tbl1;

drop table if exists tbl2;
create table tbl2(
	a int primary key,
    -- unique 중복 허용 하지 않는 다 하지만 null은 허용하고 중복도 허용한다
    -- b,c는 보조인덱스이다.
    b int unique,
    c int unique
);

# tbl2에서 a는 클러스터형 인덱스 
# b,c는 둘다 보조인덱스
show index from tbl2;
show table status;

drop table if exists tbl3;
create table tbl3(
	a int unique,
    -- unique 중복 허용 하지 않는 다 하지만 null은 허용하고 중복도 허용한다
    -- b,c는 보조인덱스이다.
    b int unique,
    c int unique
); 
# 클러스터형 인덱스가 필수가 아니다란 사실을 알수 있다.
show index from tbl3;
show table status;

drop table if exists tbl4;
create table tbl4(
	a int unique not null,
    -- unique 중복 허용 하지 않는 다 하지만 null은 허용하고 중복도 허용한다
    -- b,c는 보조인덱스이다.
    b int unique,
    c int unique,
    d int
); 
show index from tbl4;    
insert into tbl4 values (3,3,3,3),(1,1,1,1),(10,10,10,10),(5,5,5,5);
# 클러스터형 인덱스가 될수있는 경우는 primary key 와 unique not null 이 될수있다는 것을 알수있다.
# unique not null이 primary key와 동일한 역할을 하고있는 것을 알수있다.
select *
	from tbl4;
    
# primary key과 unique not null 이 같이 존재하는 경우에는 primary key가 클러스터형 인덱스가 된다.
drop table if exists tbl5;
create table tbl5(
	a int unique not null,
    -- unique 중복 허용 하지 않는 다 하지만 null은 허용하고 중복도 허용한다
    -- b,c는 보조인덱스이다.
    b int unique,
    c int unique,
    d int primary key
);  
show index from tbl5; 
insert into tbl5 values (3,3,3,7),(1,1,1,2),(10,10,10,1),(5,5,5,3);
select *
	from tbl5;    

alter table usertbl 
		drop primary key;
show index from usertbl;    
select *
	from usertbl;    
    
-- name을 기본키 설정
# 현업에서는 절대로 pk를 날리는 행위를 해서는 안된다.
alter table usertbl
		add constraint pk_name primary key(name);
show index from usertbl;    
select *
	from usertbl;          