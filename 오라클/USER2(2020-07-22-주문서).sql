-- 여기는 user2 화면입니다


-- 주문번호,   고객번호,    상품코드   어느것도 PK로 설정할 수 없는 상태/ 칼럼추가하기
-- O00001       C0032       P00001
-- O00001       C0032       P00002
-- O00001       C0032       P00003


select * from tbl_주문서원장;


-----------------------------------------------
-- 주문서 원장
-----------------------------------------------
create table tbl_order(
        O_SEQ	NUMBER		PRIMARY KEY,
        O_NUM	CHAR(6)	NOT NULL,	
        O_DATE	CHAR(10)	NOT NULL,	
        O_CNUM	CHAR(5)	NOT NULL,	
        O_PCODE	ChAR(6)	NOT NULL,	
        O_PNAME	nVARCHAR2(125),		
        O_PRICE	NUMBER,		
        O_QTY	NUMBER,		
        O_TOTAL	NUMBER		
);



-- tbl_order table을 만들어서 여기에 추가될 데이터들 중에 1개의 칼럼으로는 pk를 만들 수 없어서
-- 임의의 일련번호 칼럼을 하나 추가하고 이 칼럼을 PK로 선언하였다. 
-- 이 상황이 되면 데이터를 추가할 때 일일이 O_SEQ 칼럼에 저장된 데이터들을 살펴보고
-- 등록되지 않은 숫자를 만든다음 그 값으로 SEQ를 정하고 insert를 수행해야 한다. 
-- 이런방식은 코드를 매우 불편하게 만드는 결과를 초래한다. 


-- 이러한 불편을 방지하기 위해 SEQUENCE 라는 객체를 사용하여, 자동으로 일련번호를 만드는 방법을 사용한다. 

create sequence seq_order
start with 1 increment by 1;


-- 표준 SQL에서 간단한 계산을 할 때 
-- select 3 + 4; 라고 코딩을 하면 3+4의 결과를 확인할 수 있다. 
-- 그런데 오라클에서는 select 명령문에 from [table] 절이 없으면 문법오류가 난다. 
-- 이러한 코드가 필요할 때 시스템에 이미 준비되어 있는 dual이라는 dummy 테이블을 사용해서 코딩한다. 
select 3+4 from dual;

-- seq_order 객체의 NEXTVAL 이라는 모듈(함수역할)을 호출하여 변화되는 일련번호를 보여달라
select seq_order.nextval from dual;

-- 이 seq_order의 nextval 모듈을 사용하여 insert 수행할 때 일련번호를 자동으로 부여할 수 있다. 


-- 주문번호,   고객번호,    상품코드
-- O00001       C0032       P00001
-- O00001       C0032       P00002
-- O00001       C0032       P00003
drop table tbl_order;

insert into tbl_order(o_seq,O_date,o_num, o_cnum, o_pcode) values (seq_order.nextval,'2020-07-22','O00001', 'C0032', 'P00001');
insert into tbl_order(o_seq,O_date,o_num, o_cnum, o_pcode) values (seq_order.nextval,'2020-07-22','O00001', 'C0032', 'P00002');
insert into tbl_order(o_seq,O_date,o_num, o_cnum, o_pcode) values (seq_order.nextval,'2020-07-22','O00001', 'C0032', 'P00003');

-- 지금 tbl_order 테이블에 위와 같은 데이터가 있을 때 
-- O00001      C0031      P00001 과 같은 데이터를 추가한다면 아무런 제약없이 값이 추가되어 버릴 것이다. 
-- 중복이 안되도록 unique

select o_num, o_cnum,o_pcode from tbl_order;

-- 주문번호, 고객번호, 상품코드 이 3개의 칼럼 묶음의 값이 중복되면 insert가 되지 않도록 제약조건을 설정해야 한다. 
-- unique : 칼럼에 값이 중복되어서 insert 가 되는 것을 방지하는 제약조건
-- 주문테이블에 unique 제약조건을 추가하자

alter table tbl_order 
    add constraint uq_order 
        unique (o_num, o_cnum, o_pcode);
        
        
-- unique를 추가하는데 이미 unique 조건에 위배되는 값이 있으면 제약조건이 추가되지 않는다. 
-- duplicate keys found : 
-- PK, unique로 설정된 칼럼에 값을 추가하거나 또는 이미 중복된 값이 있는데 pk나 unique를 설정하려 했을 때 나타나는 오류
-- 마지막에 추가한 행을 delete해주기
-- unique 제약조건을 추가하기 위해 마지막에 추가된 데이터를 제거하려고 다음과 같은 SQL을 실행한다. 
-- 이 SQL을 실행하면, 삭제되어서는 안되는 중요한 주문정보 1건이 같이 삭제되어 버릴 것이다. 
-- 이 table의 데이터는 무결성을 잃게 된다. => 삭제이상

delete from tbl_order
    where o_num = 'O00001' AND o_cnum='C0032' AND o_pcode = 'P00001';

-- 다행히 일련번호 칼럼이 만들어져 있기 때문에 PK를 기준으로 값을 삭제할 수 있다. 
select * from tbl_order;

delete from tbl_order
    where o_seq = 64; --이런식으로;;;


-- 후보키 중에 단일칼럼으로 pk를 설정할 수 없는 상황이 발생하면 복수의 칼럼으로 pk를 설정하는데
-- update, delete를 수행할 때 where 칼럼1 = 값 and 칼럼2 = 값 and 칼럼3 = 값... 과같은 조건을 부여해야 한다. 
-- 이것은 데이터 무결성을 유지하는 데 매우 좋지 않은 환경이다. 
-- 이럴 때 데이터와 상관없는 seq 칼럼을 만들어 pk로 설정하자 

select * from tbl_order;



insert into tbl_order(o_seq,O_date,o_num, o_cnum, o_pcode)
values (seq_order.nextval,'2020-07-22','O00022', 'C0055', 'P00067');
commit;





