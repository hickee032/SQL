use indexdb;

# emp 테이블는 인덱스가 없다 
# 약 1000페이지를 읽은 것으로 나온다.
# 쿼리 코스트가 30975정도로 나온다.

# 페이지를 읽은 쿼리
# 인덱스가 없는 테이블
show global status like 'innodb_pages_read';
select *
	from emp
    where emp_no = 100000;
show global status like 'innodb_pages_read';

select *
	from emp
    where emp_no = 100000;

# 클러스터형 인덱스가 있는 테이블 
# 100배이상의 속도 차이가 있는 것을 알수있다.   query cost 1.00
show global status like 'innodb_pages_read';
select *
	from emp_c
    where emp_no = 100000;
show global status like 'innodb_pages_read';    

# 보조인덱스를 가지고있는 테이블 5페이지를 읽었다 query cost 1.10
# 하지만 같은 emp_no를 들고있기 때문이다. (위에 클러스터형으로 한번 읽었기 때문이다.)
# 서비스 종료후 다시 확인하면 달라진다. 
show global status like 'innodb_pages_read';
select *
	from emp_se
    where emp_no = 100000;
show global status like 'innodb_pages_read';    

# 검색시에는 인덱스가 있고 없고의 차이가 확실하다는 것을 알수있다.

# 범위 검색을 해보자
#인덱스가 없는 경우 1000페이지정도 읽었다 full scan
show global status like 'innodb_pages_read';
select *
	from emp
    where emp_no < 11000;
show global status like 'innodb_pages_read'; 

# 클러스터형 인덱스의 경우
show global status like 'innodb_pages_read';
select *
	from emp_c
    where emp_no < 11000;
show global status like 'innodb_pages_read'; 

# 보조인덱스의 경우 -- 범위 검색에는 보조인덱스가 좋지못하다.
show global status like 'innodb_pages_read';
select *
	from emp_se
    where emp_no < 11000;
show global status like 'innodb_pages_read'; 

# 범위 검색에는 보조 인덱스가 별 효용을 발휘하지 못한다. - full scan table 과 거의 차이가 없다.

# where 절이 없다면 인덱스를 사용하지않고 full table scan을 한다.
show global status like 'innodb_pages_read';
select *
	from emp_c
    limit 1000000;
show global status like 'innodb_pages_read'; 

# 보조 인덱스를 가지고 있음에도 불구하고 풀테이블 스캔을 사용하였다  이러한 보조인덱스는 있으나 마나하니 제거해주는 것이 좋다
# 물리적 공간을 차지하고 있기 때문이다.
# 테이블의 약 20%를 스캔하는 경우에는 인덱스를 사용하지 않는 다.
# 전체 데이터의 20%이상을 스캔 할 경우 에만 인덱스를 사용하자.
# 튜닝시 필요없는 인덱스를 제거만 하더라도 성능이 향상되는 것을 확인 할수있다.
show global status like 'innodb_pages_read';
select *
	from emp_se
    where emp_no < 400000
    limit 500000;
show global status like 'innodb_pages_read'; 

# where 조건절에 컬럼에 연산을 하면 어덯게 될까
# 조건절에 필드에 연산이 들어가면 풀테이블 스캔을 한다는 것을 알수있다.

# 바로 아래는 풀 테이블 스캔
show global status like 'innodb_pages_read';
select *
	from emp_se
    where emp_no*1 = 11000;
show global status like 'innodb_pages_read';

# 아래는 인덱스를 사용한다. 단순한 연산은 컬럼명에 하지 않도록 한다.
# 오퍼랜드에 연산은 인덱스를 사용한다. 꼭 기억하도록하자.
show global status like 'innodb_pages_read';
select *
	from emp_se
    where emp_no = 11000/1;
show global status like 'innodb_pages_read'; 

# 데이터의 중복도 (카디널리티와 반비례한다)
select*
from emp;

alter table emp add index idx_gender(gender);
alter table emp add primary key pk_emp_empno(emp_no);

analyze table emp;
# 여기서 유심히 볼 항목은 cardinality(관계대수) 테이블간의 릴레이션을 구성하는 행(row)의 수를 말한다.

show index from emp;

select *
	from emp
	where gender = 'M';

alter table emp
		drop index idx_gender;

select*
	from emp        
    ignore index (idx_gender)
    where gender = 'M';

-- 결론
-- 1. 인덱스는 열(컬럼) 단위에 생성해야 한다.
-- 2. WHERE절에서 자주 사용되는 열에 인덱스를 만들어야 효율성이 높다.
-- 3. 데이터의 중복도가 높은 열은 인덱스 만들어도  효과 없다.
-- 4. 외래 키 지정한 열의 경우는 자동 인덱스 생성된다.
-- 5. JOIN에 자주 사용되는 열의 경우는 인덱스를 생성해주자.
-- 6. 인덱스는 단지 읽기에서만 성능 향상되므로 얼마나 데이터의 변경이 일어나는지를
--    고려해야 된다.
-- 7. 클러스터형 인덱스는 테이블당 하나만 생성 가능하다.
-- 8. 사용하지 않는 인덱스는 과감이 제거하자.
--    (저장공간 확보 및 데이터 입력시 부하를 줄여준다)  