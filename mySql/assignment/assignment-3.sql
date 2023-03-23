use mydb;

create table videotbl(
video_id int not null primary key auto_increment,
title varchar(20) not null,
genre varchar(8) not null,
star varchar(10)
);
-- 확인
describe videotbl;

insert into videotbl values(null,'태극기 휘날리며','전쟁','장동건');
insert into videotbl values(null,'대부','액션',null);
insert into videotbl values(null,'반지의제왕','액션','일라이저우드');
insert into videotbl values(null,'친구','액션','유오성');
insert into videotbl values(null,'해리포터','판타지','다니엘');
insert into videotbl values(null,'형','코미디','조정석');

-- 확인
select*
	from videotbl;

-- 문제9
select*
	from videotbl
		where star is null;
        
-- 문제10    
select *
	from videotbl
    where genre='액션';
    
-- 문제11    
delete
 from videotbl
	where star='유오성';
-- 문제12  
update videotbl
	set title='동생'
    where title ='형';
 
 -- 문제13
 -- 데이터삭제
delete from videotbl;   
truncate videotbl; 

-- 문제14
-- 테이블 삭제
drop table videotbl;
    
    
    
