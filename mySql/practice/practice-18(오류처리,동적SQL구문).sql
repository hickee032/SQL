-- 오류처리 다른 언어에서의 예외처리구문
-- 아래는 직접 오류코드를 처리하는 구문을 procedure로 만든것이다.

drop  procedure if exists errorproc1;
delimiter //
create procedure errorproc1()
begin
	-- 테이블이 없을 때의 오류 1146
    -- exit가 오면 begin~end사이에서 오류 코드가 발견되면 다음 구문을 실행하지 않고 handler 구문을 실행 함 -> 빠져 나간다.
    declare exit handler for 1146 select "테이블이 없습니다." as "오류메세지";
		begin
			select *
				from notable;
                
			select *
				from sqldb.usertbl;
		end;
	-- declare continue handler for 1146 select "테이블이 없습니다." as "오류메세지";
    -- declare continue handler for sqlstate "42S02" select "테이블이 없습니다." as "오류메세지";

end //
delimiter ;

call errorproc1();

drop  procedure if exists errorproc2;
delimiter //
create procedure errorproc2()
begin
	-- 테이블이 없을 때의 오류 1146
    -- continue 오면 begin end사이에서 오류 코드가 발견되더라도 handler구믄을 실행하고 다음 구문도 끝까지 실행 함 ->계속 실행한다.
    declare continue handler for 1146 select "테이블이 없습니다." as "오류메세지";
		begin
			select *
				from notable;
                
			select *
				from sqldb.usertbl;
		end;
	-- declare continue handler for 1146 select "테이블이 없습니다." as "오류메세지";
    -- declare continue handler for sqlstate "42S02" select "테이블이 없습니다." as "오류메세지";

end //
delimiter ;

call errorproc2();

select *
	from newtbl;