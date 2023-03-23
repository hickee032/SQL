use mydb;

-- 143 emp테이블이 이용하여 emp_index테이블 만들어보시오
drop table if exists emp_index;
create table emp_index(
 select*
 from emp
);

-- 144 만들어진 emp_index테이블에 제약조건이 걸려있는지 직접 확인하는 코드를 작성하시오.
show table status;
show index from emp_index;
	# 제약조건이 없음
select *
		from emp_index;

-- 145 emp_index에서 emp_no에 pk제약조건을 추가하시오 인덱스명은 PK_emp_index_pk로 지정하세요  이렇게 만든 인덱스를 무엇이라고 칭하나?
alter table emp_index
		add constraint PK_emp_index_pk primary key(empno);
        # 클러스터형 인덱스
-- 146 ename에 unique제약조건을 걸어 보조인덱스를 생성해보자 인덱스명은 UK_emp_index_name으로 하자
alter table emp_index
			add constraint UK_emp_index_name unique(ename);
            # 이병헌이 두명이라 적용할수 없다.
# 그래서 이병헌 두명중 한명을 이병현으로 바꿔주었다.
update emp_index
set ename = '이병현'
where job = '부장' and ename = '이병헌';

-- 147 이렇게 만든 인덱스를 확인해보면 나타나지 않은것이 있을것이다.  테이블에 인덱스를 적용시키고 다시 인덱스를 조회해보자
show table status;
show index from emp_index;
analyze table emp_index;
-- 148 다시 job컬럼에 unique제약조건을 걸어 보조인덱스를 생성해보자 인덱스명은 UK_emp_index_job으로 하자.(생성이 되나? 안될것이다.)
-- 안되는 이유가 무엇인지 서술하시오
alter table emp_index
	add constraint UK_emp_index_job unique(job);
    # 안되는 이유는 unique key는 중복을 허용하지 않기 때문이다 job에는 직책이 중복 되어있다. 
-- 149 지금까지 만든 인덱스를 다 제거하시오
alter table emp_index
		drop index UK_emp_index_name;
alter table emp_index
		drop  primary key;
        
show index from emp_index;        
-- 150 인덱스를 만들어야 하는 경우는 언제인가? 아는데로 서술하시오
#1. 전체 테이블의 20%이상을 스캔할 경우
#2. 데이터가 삭제 추가가 자주 일어나는 경우에는 인덱스를 자제하도록하자.
#	성능 저하
#3. where 절을 자주 사용하는 경우에 인덱스를 만들어 주도록 하자.
#4. 중복도가 적고 카디널리티가 높은 경우 열에 만들어 주면 좋다.
#5. 클러스터형 인덱스 (primary key) 는 자동정렬이 이루어진다. 테이블당 하나만 지정가능
#6. 인덱스는 데이터베이스의 공간을 차지한다 (10%정도) 
	   
