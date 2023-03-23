use sqldb;

-- SQL 프로그래밍 기본적 방법
-- 1. if문, case문
-- int형 변수 var1을 선언하였다(즉 메모리에 4바이트 만큼 할당했다)
-- 만약, var1이 100이라면 아래 문장을 실행해라
-- var1에 100을 대입했다.
-- 아니라면 아래문장을 실행해라.
-- 구분자이다. 앞에서 배웠다.

drop procedure if exists ifProc;
delimiter //
create procedure ifProc()
-- @@시스템 변수
-- @ 전역변수
begin
 -- var int; declare를 안붙이면 오류
 declare var1 int; -- 지역변수
 set var1 = 100;
 
 if var1 = 100 then
	select '100입니다.';
 else 
	select '100이 아닙니다.';
end if;

end //
delimiter ;

call ifproc();

-- 입사한지 5년이 지났는지 직접확인하는 것을 프로그래밍 해보자.
-- 먼저 변수를 date타입 2개(현재, 입사년도)를 선언하고, 날짜계산
-- 하기 위해 days를 int형으로 선언한다.
-- select hire_date into hiredate는 hire_date를 hiredate에 대입하라는 쿼리문이다.
-- 그리고 hiredate라는 변수를 이용해서 계산을 하면 된다.
-- 근무일수는 현재날짜 - 입사년월일이니깐 datediff()를 이용하여 구하고
-- 그것을 다시 365로 나누면 근무년수가 나온다.
-- 그걸로 결과를 출력하는 것이다.

drop procedure if exists ifProc2;
delimiter $$
create procedure ifProc2()
begin
	declare hiredate date;
    declare curdate date;
    declare days int;
    
    select hire_date into hiredate
		from employees.employees
        where emp_no = 1001;
        
        set curdate = curdate();
        set days = datediff(curdate,hiredate);
        
        if(days/365) >= 5 then
			select concat("입시한지",days/365,"년이 넘었군요") as "입사경과 년수";
        else
			select concat("입시한지",days/365,"년밖에 되지않았군요") as "입사경과 년수";
        end if;
        end $$
        delimiter ;

call ifProc2();

-- 학점을 출력하는 프로그래밍을 해보자.
drop procedure if exists ifProc3;
delimiter //
create procedure ifProc3()
begin
	declare point int;
    declare credit char(1);
    set point =77;
    
    if point>90 then
     set credit = "A";
	elseif point >80 then
	 set credit = "B";
    elseif point >70 then
	 set credit = "C";
    elseif point >60 then
	 set credit = "D";
    else
	 set credit = "F";
    end if ;   
     select concat("취득점수",point) as "점수", concat("학생->",credit) as "취득학점";
     
end //
delimiter ;
call ifProc3();

-- 위와 결과는 동일하게 나타내는 구문 중 case문을 이용해보자.
drop procedure if exists caseproc;
delimiter //
create procedure caseproc()
begin
	declare point int;
    declare credit char(1);
    set point =77;
    
    case 
		when point>=90 then
        set credit = "A";
        when point>=80 then
        set credit = "B";
        when point>=70 then
        set credit = "C";
        when point>=60 then
        set credit = "D";
        else
        set credit = "F";
        end case;
        
        select concat("취득점수",point) as "점수", concat("학생->",credit) as "취득학점";
        
	end //
	delimiter ;
    
call caseproc();

-- userid와 총구매액이 나오지만 고개 이름이 없다 -> join을 하도록 해보자
-- 결과를 보면 userid, 총구매액이 나온다.
-- 근데 고객이름이 없다. 

select userid,sum(price*amount) as "총구매액"
	from buytbl
    group by userid
    order by sum(price*amount) desc;
    
-- 고객이름이 없으니 조인을 이용해 usertbl과 엮도록 하자
-- 결과를 보면 총구매액별로 내림차순 정렬이 되었고, 구매하지 않는 사람도 
-- 있다. 이것을 case문을 이용해서 고객분류를 한번 해보자.    

select u.userid,u.name,sum(price*amount) as "총구매액"
	from buytbl as b
    right outer join usertbl as u
			on u.userid = b.userid
 group by u.userid,u.name
 order by sum(price*amount) desc;
 
-- select문 안에 하나의 필드처럼 고객등급을 
-- case when then문으로 설정을 하는 쿼리문이다.
 
 select u.userid, u.name ,sum(price*amount) as "총구매액" ,
	case 
		when sum(price*amount)  >=1500 then "최우수 고객"
        when sum(price*amount)  >=1000 then "우수 고객"
        when sum(price*amount)  >=1 then "일반 고객"
        else "유령고객"
        end as "고객 등급"
from buytbl as b
right outer join usertbl as u
	on u.userid = b.userid
group by u.userid,u.name
order by sum(price*amount) desc; 
   
        
	
