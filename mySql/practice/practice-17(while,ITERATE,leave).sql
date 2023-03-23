
-- 1~100까지의 합을 while문으로 구해보자
drop procedure if exists whileproc;
delimiter //
create procedure whileproc()
begin
declare i int;
declare hap int;
	set i = 0;
	set hap = 0;
    
while (i<=100) do
-- mysql에서는 복합대입연산자가 적용되지 않는 다
	set hap = hap+i;
-- mysql에서는 증감연산자가 적용되지 않는 다
    set i = i+1;
    end while;
    
    select hap;
end //
delimiter ;
call whileproc();

-- 합계를 구하는 데 7의 배수를 제외하고 1000을 넘기면 루프를 빠져나가는 쿼리문을 작성해보자
drop procedure if exists whileproc2;
delimiter //
create procedure whileproc2()
begin
	declare i int;
	declare hap int;
		set i = 0;
		set hap = 0;
-- while 문을 mywhile이란 라벨로 설정하였다.
mywhile: while (i <=100) do
	if(i%7) = 0 then
        set i = i+1;
        iterate mywhile;
        end if;
        set hap = hap+i;
       -- leave는 break문과 같다 떠나라는 뜻이다.루프를 종료하라는 뜻이다.
    if hap >= 1000 then
		leave mywhile;
        end if;
        set i = i+1;
        end while;
	select hap as "7의 배수를 제외후 합계";
end //
delimiter ;
call whileproc2();

