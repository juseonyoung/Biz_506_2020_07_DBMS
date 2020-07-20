-- 여기는 user1
-- tbl_iolist에는 상품명, 거래처명, 거래처 CEO 칼럼의 데이터가 일반 문자열 형태로 저장되어 있다. 
-- 이 데이터는 같은 칼럼에 중복된 데이터가 있어서 데이터 관리측면에서 상당히 불편한 상황이다. 
--      만약 어떤 상품의 상품명이 변경이 필요한 경우 
--      상품명을 update 하여야 하는데, 2개 이상의 레코드를 대상으로 업데이트과정이 필요하다.
--      2개 이상의 레코드를 업데이트 수행하는 것은 데이터의 무결성을 해칠수 있는 수행이 된다. 
-- 이러한 문제를 방지하기 위해 아래와 같은 정규화를 실행한다.

-- 상품명 정보를 별도의 테이블로 분리하고, 상품정보에 상품코드를 부여한 후 
-- tbl_iolist와 연동하는 방식으로 정규화를 실행한다.

-- 1. tbl_iolist로부터 상품명 리스트를 추출하자
--      상품명 칼럼을 group by 하여 중복되지 않은 상품명 리스트만 추출한다. 
SELECT io_pname, 
    MIN(DECODE(io_inout,'매입', io_price,0)) AS 매입단가,
    MAX(DECODE(io_inout,'매출', io_price,0)) AS 매출단가
FROM tbl_iolist
GROUP BY io_pname
ORDER BY io_pname;


------------------------------
-- 상품정보 테이블
------------------------------
CREATE TABLE tbl_product(
        p_code	CHAR(5)		PRIMARY KEY,
        p_name	nVARCHAR2(125)		NOT NULL,
        p_iprice	NUMBER,		
        p_oprice	NUMBER,		
        p_vat	CHAR(1)		DEFAULT '1'
);


SELECT * FROM tbl_product;


/*
매입매출 테이블에서 상품정보(이름, 단가) 부분을 추출하여 상품정보테이블을 생성했다
매일매출 테이블에서 상품이름 칼럼을 제거하고 
상품정보 테이블과 join 할 수 있도록 설정해야 한다. 

현재 매입매출 테이블에는 상품이름이 들어있고 상품정보 테이블에는 
상품코드, 상품이름, 매입 매출단가가 있다. 
매입매출 테이블의 상품이름에 해당하는 상품코드를 매입매출 테이블에 update 하고 
매입매출 테이블의 상품이름 칼럼을 제거한 후 , join을 수행하여 데이터를 확인해야 한다. 
*/

-- 1.매입매출 테이블의 상품명과 상품정보 테이블의 상품명을 join해서 매입매출 테이블의 상품명이
--   상품정보에 모두 있는지 확인하는 절차 필요★★★★★★
SELECT IO.io_pname, P.p_name
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pname = P.p_name;

-- 위 쿼리를 실행하여 P.p_name 항목에 null값이 있다면 상품정보 테이블이 잘못 만들어졌다는 뜻!
-- 상품정보 테이블을 삭제하고 과정을 다시 수행해야 한다. 

-- 쿼리 결과중에 P.p_name 항목의 값이 null인 리스트만 보여라 
-- 쿼리 결과가 정상이라면 리스트는 한개도 없어야 한다. 
SELECT IO.io_pname, P.p_name
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pname = P.p_name
WHERE P.p_name IS NULL; --해당칼럼 값이 null이 아니냐? : is not null


-- 이제 상품데이터가 이상 없음을 알았으니 매입 매출 테이블에 상품코드를 저장할 "칼럼"을 추가
-- 테이블 새로 만드는 게 아님
-- ALTER TABLE : 테이블의 구조 (칼럼 추가, 삭제) 변경, 칼럼의 type변경 등 수행하는 명령
-- 상품 테이블의 pcode칼럼과 같은 타입으로 io_pcode 칼럼을 추가!
ALTER TABLE tbl_iolist ADD io_pcode CHAR(5);
ALTER TABLE tbl_iolist DROP COLUMN io_pcode;

-- alter table을 할 때 오류 나는 이유
-- 이미 많은 데이터가 insert 되어 있는 상태에서 칼럼을 추가하면 추가하는 칼럼은 당연히 초기값이 null이 된다. 
-- 이 방식으로 칼럼을 추가하면 절대 칼럼추가가 안된다. 
-- 이 방식은 아직 데이터가 1개도 없을 때는 가능하다. 
alter table tbl_iolist ADD (io_pcode CHAR(5) not null); 

-- not null 조건을 추가하기 
-- 1.p_code 칼럼 추가, 기본값으로 문자열이므로 빈칸 추가(숫자 칼럼 이라면 0을 추가)
ALTER TABLE tbl_iolist ADD (io_pcode CHAR(5) default ' ');

-- 2.p_code 칼럼의 제약조건을 not null로 설정
ALTER TABLE tbl_iolist modify (io_pcode constraint io_pcode not null);




-- 칼럼 추가
ALTER TABLE tbl_iolist ADD (io_pcode CHAR(5) default ' ');

-- 칼럼 삭제
ALTER TABLE tbl_iolist DROP COLUMN io_pcode;

-- 칼럼에 not null 조건 추가하기
ALTER TABLE tbl_iolist modify (io_pcode constraint io_pcode not null);

-- 칼럼의 타입 변경하기
ALTER TABLE tbl_iolist modify (io_pcode char(10));

-- 칼럼의 타입 변경하기 주의 사항!!!
-- 칼럼의 타입을 변경할 때 
-- 문자열 <-> 숫자 처럼 타입이 완전히 다른 경우는 오류가 발생하거나 데이터를 모두 잃을 수 있다. 
-- char <-> (n)varchar2 
--  문자열의 길이가 같으면 데이터 변환이 이루어 진다. 
-- char <-> (n)varchar2 는 저장된 문자열이 유니코드(한글 등)이면 매우 주의를 해야한다. 
-- 보통 길이가 다르면 오류가 나지만, 정상적으로 명령이 수행되더라도 데이터가 잘리거나 문자열이 알 수 없는 값으로 변형되는 경우가 발생한다. 



-- 칼럼의 이름변경하기
-- io_pcode 이름을 io_pcode1으로 변경하기 
ALTER TABLE tbl_iolist rename column io_pcode to io_pcode1;

-- 상품정보에서 매입매출장 각 레코드의 상품명과 일치하는 상품코드를 찾아서 
-- 매입매출장의 상품코드(io_pcode) 칼럼에 update해주기 

-- update 명령이 sub쿼리를 만나면 
-- 1. 서브쿼리에서 현재 iolist 의 io_pname 칼럼의 값을 요구하고 있다. 
-- 2. tbl_iolist의 레코드를 전체 select를 수행한다. 
-- 3. select 된 리스트에서 io_pname 칼럼 값을 서브 쿼리로 전달한다. 
-- 4. 서브쿼리는 전달받은 io_pname 값을 tbl_product 테이블에서 조회를 한다. 
--     이때 서브쿼리는 반드시 1개의 칼럼, 1개의 VO만 추출해야 한다. 
-- 5. 그 결과를 현재 iolist의 레코드의 io_pcode 칼럼에 update 를 수행한다. 

update tbl_iolist IO
set io_pcode =
(
    select p_code --반드시 1개만
    from tbl_product P
    where p_name = IO.io_pname
);

SELECT io_pcode from tbl_iolist;

--iolist에 pcode가 정상적으로 update 되었는지 검증
select io_pcode, io_pname, p.p_name
from tbl_iolist IO
    left join tbl_product P
        on IO.io_pcode = P.p_code
where p.p_name is null;

-----------------------------
--거래처데이터 정규화
-----------------------------
-- 거래처명, ceo 칼럼이 테이블에 들어 있다.
-- 이 칼럼을 추출하여 거래처 정보를 생성
-- 추출된 데이터 중 거래처명은 같고 ceo가 다르면 다른 회사로 보고
-- 거래처명과 ceo가 같으면 같은 회사로 보고 데이터를 만든다. 
select io_dname, io_dceo
from tbl_iolist
group by io_dname, io_dceo
order by io_dname;


create table tbl_buyer(
        b_code	CHAR(4)		PRIMARY KEY,
        b_name	nVARCHAR2(125)	NOT NULL,	
        b_ceo	nVARCHAR2(50)	NOT NULL,	
        b_tel	VARCHAR2(20)		
);

-- b_tel 칼럼의 값이 중복된 (2개 이상) 레코드가 있냐?
select * from tbl_buyer;
select b_tel, count(*) from tbl_buyer
group by b_tel
having count(*) > 1;

-- iolist에 저장된 dname, dceo 칼럼으로 거래처정보에서 데이터를 조회하고
-- iolist에 거래처 코드 칼럼으로 update 수행하기

alter table tbl_iolist add (io_bcode char(4) default ' ');
alter table tbl_iolist modify (io_bcode constraint io_bcode not null);

desc tbl_iolist;


 COMMIT ;

-- iolist 와 buyer 테이블간의 거래처명, 대표자명 칼럼으로 join을 수행하여 데이터검증
-- 데이터가 한개도 출력되지 않아야 한다.
select io.io_dname, b.b_name
from tbl_iolist IO
    left join tbl_buyer B
        on IO.io_dname = B.b_name
where B.b_name is null;



drop table tbl_buter cascade constraints;


-- iolist 에 거래처 코드 업데이트하기
-- 지금 생성한 tbl_buyer 테이블에는 거래처명은 같고 대표자가 다른 데이터가 있다.
-- 이 데이터에서 거래처명으로 조회를 하면 출력되는 레코드(row)가 2개 이상인 경우가 발생한다. 
-- 따라서 이 쿼리를 실행하면 single-row subquery returns more than one row 오류가 발생한다. 
-- 이 쿼리는 거래처명과 ceo 값을 동시에 제한하여 1개의 row값만 sub쿼리에서 만들어 지도록 해야 한다. 
update tbl_iolist IO
set io_bcode =
(
    select b_code
    from tbl_buyer B
    where B.b_name = IO.io_dname AND B.b_ceo = IO.io_dceo
);

select io_bcode, io_dname, b_code, b_name
from tbl_iolist IO
    left join tbl_buyer B
        on IO.io_bcode = B.b_code
where b_code is null or b_name is null;

-- 데이터를 tbl_product , tbl_buyer 테이블로 분리했으니
-- tbl_iolist에서 io_pname, io_dname, io_dceo 칼럼은 필요가 없으므로 제거한다. 

alter table tbl_iolist drop column io_pname;
alter table tbl_iolist drop column io_dname;
alter table tbl_iolist drop column io_dceo;

select * from tbl_iolist;

create view view_iolist
AS
(
select io_seq, io_date, 
    io_bcode, b_name, b_ceo, b_tel, 
    io_pcode, p_name, p_iprice, p_oprice, io_inout, 
    DECODE(io_inout,'매입',io_price,0) AS 매입단가,
    decode(io_inout,'매입',io_amt,0) AS 매입금액,
    DECODE(io_inout,'매출',io_price,0) AS 매출단가,
    DECODE(io_inout,'매출',io_amt,0) AS 매출금액
from tbl_iolist IO
    left join tbl_product P
        on io.io_pcode = p.p_code
    left join tbl_buyer B
        on io.io_bcode = b.b_code
);

select * from view_iolist
where io_date between '2019-01-01' and '2019-01-31'
order by io_date;





