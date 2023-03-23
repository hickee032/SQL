-- JSON javascript objects notation 언어에 종속 되지 않고 교환 할수있는 데이터 포멧이다.

use sqldb;

-- usertbl에서 height 180 초과된 키 와 값 형태로 json변환하는 쿼리

select json_object('name',name,'height',height) as 'json값'
	from usertbl
	where height >180;

-- {\"name\": \"임재범\", \"height\": 182} json 형태

set @json ='{"usertbl" : [
	{"name":"임재범","height":182},
	{"name":"이승기","height":182},
	{"name":"성시경","height":186}]}';

select @json;

-- 안에 들어간 값이 json값이 맞는 지 묻는다. 1을 리턴하면 true 0을 리턴하면 false
select json_valid(@json);
-- json 데이터에서 성시경이 몇번째 인덱스에 있는 지 확인 배열개념으로 되어있기 때문에 0~2를 리턴 인지값이 'one'이 있는 데 이것은 'all'바꿔도 상관 없다.
-- 문법이다 눈에 익히자
select json_search(@json,'one','성시경');

select json_extrace(@json,'$.usertbl[2].name');
select json_insert(@json,'$.usertbl[0].mdate','2009-10-25');
-- 0번째 인덱스의 이름을 홍길동으로 바꿔라
select json_replace(@json,'$.usertbl[2].name','홍길동');
-- 0번째 인덱스를 지워라
select json_remove(@json,'$.usertbl[0]');

select *
 from buytbl;
 -- 테이블에 있는 값을 json형태 배열로 바꿔서 데이터를 주고 받을수 있다.
 select json_array('usertbl',userid,'prodname',prodname,'groupname',groupname,'price',price,'amount',amount)
	from buytbl;
