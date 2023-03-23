-- index 3

create database if not exists indexdb; 
use indexdb;
# 약 30만건
select count(*)
	from employees.employees;

# 인덱스가 없는 테이블
      drop table if exists emp;
create table emp
		select*
        from employees.employees
        order by rand(); #순서를 임의로 가져와라
# 클러스터형 인덱스가 있는 테이블
drop table if exists emp_c;
create table emp_c
		select*
        from employees.employees
        order by rand(); 	
# 보조인덱스가 있는 테이블
drop table if exists emp_se;
create table emp_se
		select*
        from employees.employees
        order by rand();  

# 테이블 별로 잘 섞여있는 지 확인
select * from emp limit 5;
select * from emp_c limit 5;
select * from emp_se limit 5;
# 같은 3개의 테이블이 준비되었다.
show table status;

# emp_c 에 클러스터형 인덱스 (pk) 추가
alter table emp_c
	add constraint primary key (emp_no);
# emp_se 에 보조형 인덱스 추가    
alter table emp_se
	add index idx_emp_no(emp_no);
# emp는 인덱스가 없으므로 그대로 출력 
# emp_c는 클러스터 형 인덱스가 추가 되었으므로 emp_no로 오름차순으로 정렬이 될것이다.
# (인덱스 페이지와 리프페이지를 만든다고 시간이 좀 걸릴것임을 짐작할수 있다.)
# emp_se 는 보조형 인덱스 이므로 페이지를 만드는 데 데이터의 주소값을
# 지니고 있는 부분만 정렬이 될것이고 책의 내용은 그대로 남아있을 것이다.

analyze table emp, emp_c,emp_se;

show index from emp;    
show index from emp_c;    
show index from emp_se;    
# 클러스터형 인덱스는 그자체가 인덱스를 내포해있다
# data_free가 인덱스를 차지하고 있는 것이 줄어든것을 확인할수있다.

show table status;
# 이제 성능테스트를 하도록하자 mysql을 잠시 종료하였다가 다시 실행하자