-- db생성
drop database if exists compressdb;
create database compressdb;
use compressdb;

drop table if exists normaltbl;
create table normaltbl (
	emp_no int,
	first_name varchar(14)
);

-- 통상 compresstbl 에 데이터 입력시간이 더 걸리는 이유는 테이터를 삽입하면서 동시에 압축을 하기 때문이다.

drop table if exists compresstbl;
create table compresstbl (
	emp_no int,
	first_name varchar(14)
)row_format = compressed; -- 이테이블은 압축하여 쓰겠다

alter table compresstbl avg_row_length = 29;

insert into compresstbl(
	select emp_no , first_name
    from employees.employees);
 
 insert into normaltbl(
	select emp_no , first_name
    from employees.employees);
  
show table status from compressdb;

-- <-- 이쪽의 테이블을 오른쪽 클릭하고 sand to sqlEditer -> create statment
CREATE TABLE `buytbl` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `userID` char(8) NOT NULL,
  `prodName` char(6) NOT NULL,
  `groupName` char(4) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `amount` smallint(6) NOT NULL,
  PRIMARY KEY (`num`),
  KEY `FK_usertbl_buytbl` (`userID`),
  CONSTRAINT `FK_usertbl_buytbl` FOREIGN KEY (`userID`) REFERENCES `usertbl` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



