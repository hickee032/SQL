-- 실습-20(대용량데이터삽입,파일입출력)
use sqldb;
-- 대용량 데이터 삽입해보기
-- 일단, 먼저 maxtbl을 만들자. 근데 필드의 데이터 타입이 longtext이다. 
-- longtext는 4GB만큼 text데이터를 넣을수 있는것을 이미 배웠다.
-- 확인해보자.
drop table if exists maxtbl;
create table maxtbl (col1 longtext, col2 longtext);
desc maxtbl;

 -- 아래 내용은 버전업이 되면 my.ini파일을 수정하게 되면 버그 발생으로 수정이 되지 않는 다.
 
-- 'A'라는 문자를 10만번 반복해서 col1에 넣고, '가'라는 한글을 10만번 col2에 삽입하자.
insert into maxtbl values (repeat('A', 100000), repeat('가', 100000));
-- 앞에서 배운 length()는 필드의 바이트수를 리턴한다. col1은 영어라서 1바이트를
-- 가진다고했다. 하지만 한글은 3바이트이다. UTF-8문자셋에서는 말이다.  
select length(col1), length(col2)   -- col1은 약 0.1MB, col2은 약 0.3MB 차지
 from maxtbl;
-- 분면 longtext는 4GB저장할 수 있다고 했는데 1000만바이트가 안들어간다고 에러나 난다.
-- 기본적으로 mysql은 4MB까지만 저장을 허용한다. 이때는 워크벤치의 설정을 바꿔줘야 한다.
-- C:\ProgramData\MySQL\MySQL Server 5.7\my.ini파일에 max_allow부분이 기본적으로 
-- 4MB로 설정되어 있는걸 확인할수 있다. 이것을 1000MB로 바꿔주면 된다.
-- 설정이 바뀌면 재부팅을 하는것이 원칙이나, cmd창을 관리자모드로 열고
-- net stop mysql을 치자. 그럼 mysql서버가 중지되고, net start mysql을 치면 서비스를 
-- 시작하여 적용이 된다.이제 아래코드를 치면 에러가 발생하지 아니한다.
insert into maxtbl values (repeat('A', 10000000), repeat('가', 10000000));
-- 방금 수정한 my.ini의 시스템변수들을 보는 쿼리문이다.
show variables like 'max%';

-- 다시 말하지만 my.ini파일을 수정하게 되면 mysql서비스를 중단했다가 다시 시작해야 한다.
-- 명심하자. 설정이 되었는지 확인해보자.
show variables like 'secure%';
-- ---------------------사용하지 마시오----------------------------

use sqldb;
-- 버전이 바뀌면서 책과는 다르게 역슬래쉬 2개를 표시해야만 경로를 인식을 한다.
-- into outfile 경로 는 usertbl의 내용을 텍스트 파일로 내보내겠다는 것이다.
-- 파일을 열어보면 깨지는 경우도 있고 한데 ms-word에서 열면 잘 보이는 것을 확인할수 있다.

-- 텍스트파일로 내보내기(5.7 version 까지)
-- select * from usertbl 
--   into outfile 'C:\\TEMP\\userTBL.txt' character set utf8  
--   FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
--   ESCAPED BY '\\' 
--   LINES TERMINATED BY "\n"; 
 
-- 텍스트파일로 내보내기(8.0 version 까지) 
  select * 
  into outfile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/userTBL.txt' 
  character set euckr  
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
  ESCAPED BY '\\' 
  LINES TERMINATED BY "\r\n"
  from usertbl;
  
-- 엑셀파일로 내보내기(5.7 version 까지)
-- select * from employees.employees
--   into outfile 'C:\\TEMP\\employees.csv' character set euckr
--   FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
--   ESCAPED BY '\\' 
--   LINES TERMINATED BY "\n";

-- 엑셀파일로 내보내기(8.0 version 까지)
  select * 
  into outfile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/userTBL.csv' 
  character set euckr  
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
  ESCAPED BY '\\' 
  LINES TERMINATED BY "\r\n"
  from usertbl;
  
select *
  from usertbl;  

select *
  from membertbl;
    
-- 이제는 외부데이터를 가져와보자. 먼저 기존에 썻던 membertbl을 날리자
drop table if exists membertbl;
-- 그리고 하기 쿼리는 테이블의 구조를 복사해오는 것이다(물론 PK까지 복사해온다)
create table membertbl like usertbl;
desc membertbl;
-- 이제 불러와서 import를 해보자

-- 텍스트파일 테이블로 읽어들이기
load data local infile 'C:\\TEMP\\userTBL.txt' into table membertbl character set utf8
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- 엑셀파일 테이블로 읽어들이기
load data local infile 'C:\\TEMP\\userTBL.csv' into table membertbl character set euckr
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- 잘 불러온걸 확인 할수가 있다.
select *
  from membertbl;
truncate membertbl;  
-- 위의 파일로 내보는 것, 파일로부터 테이블로 데이터 옮기는 것 정말 중요하다.
-- 현업에서 너무 많이 쓰니깐 명령어 잊지 않도록하자.
-- 1. 파일내보내기 : select * into outfile '파일경로' from 내보낼 테이블명
-- 2. 파일 테이블로 가져오기 : load data local infile '가져올 파일 경로' into table 
--    데이터 넣을 테이블명