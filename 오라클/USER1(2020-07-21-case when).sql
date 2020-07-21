-- 여기는 user1 화면입니다


-- 표준SQL문 : case when 조건문 then true 일때 값 else false 일때 값 end
-- 오라클 : decode(칼럼, 조건값, true일 때 , false일 때)
select io_bcode,
	sum(case when io_inout = '매입' then io_amt else 0 end) AS 매입합계,
	sum(case when io_inout = '매출' then io_amt else 0 end) AS 매출합계
from tbl_iolist
group by io_bcode;


-- 오라클에서 차후에 pk를 생성하는 방법!
-- 기존의 pk가 있으면 중복 생성되지 않는다. 
-- pk_iolist : 오라클에서만 사용되는 pk를 찾는 별명
-- 혹시 pk를 삭제할 일이 있을 때 필요한 이름
alter table tbl_iolist add constraint PK_iolist primary key (io_seq, io_date);
alter table tbl_iolist drop primary key; 


create table tbl_test (
    t_seq number primary key,
    t_name nVARchar2(20)
);

-- 오라클에는 table에 auto_increment 설정이 없다.
-- 만약 일련번호와 같은 칼럼을 사용하여 PK로 만들고 싶을 때는 상당히 곤란한 상황이 된다. 
-- insert를 수행할 때마다 이전에 저장된 일련번호 값을 조회하고 +1을 수행하여 다시 insert를 수행하는 일을 반복해야 하기 때문

-- 다행히 오라클에는 sequence라는 다른 DBMS에 없는 특별한 객체가 있다. 
-- 이 객체는 객체.nextval 이라는 특별한 호출자가 있는데 이 호출자를 호출 할 때마다
-- select, insert 등에서 내부에 가지고 있는 변수값을 사전에 정의한 규칙에 따라 자동 증가하여 보관하게된다. 
-- 이 객체.nextval 이 가지고 있는 값을
-- insert 수행할 때 pk인 seq칼럼에 주입하면 auto_increment 효과를 낼 수 있다. 

create sequence seq_test
start with 1 increment by 1; --오라클에 auto 기능없어서 이렇게 씀 최초 시작값/ 호출 될 때마다 증가하는 수

insert into tbl_test(t_seq, t_name)
values (seq_test.nextval, '홍길동');

select * from tbl_test;