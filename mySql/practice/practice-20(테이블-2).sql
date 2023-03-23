use tabledb;

drop table if exists prodtbl;
create table prodtbl(
	prodcode char(3) not null,
    prodid char(4) not null,
    proddate datetime not null,
	prodcur char(10) null
  --  constraint PK_prodtbl_prodcode_prodid
  --  primary key(prodcode,prodid)
    );
    
select *
  from prodtbl;
  
insert into prodtbl values('aaa','0001','20191010','판매완료'),('ccc','0001','20191013','판매완료'),
('aaa','0002','20191010','매장진열'),('bbb','0001','20191012','재고창고'),('ccc','0002','20191014','판매완료');

-- 아래와 같이 테이블을 수정한는 구문을 넣어줄수있다.
-- 여기서는 pk를 직접 이름을 주어서 만들었고 아울러 2개의 필드를 합쳐서 하나의 pk로 설정한것이다. 어느 필드가 pk가 될수 있겠는 가 
-- 이런경우 아래와 같이 합친다.

alter table prodtbl
	add constraint PK_prodtbl_prodcode_prodid primary key(prodcode,prodid);
-- 생성된 제약조건을 확인해보자   
show index from prodtbl;    
