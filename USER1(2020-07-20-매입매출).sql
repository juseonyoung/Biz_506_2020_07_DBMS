-- user1 화면입니다

--------------------------------------------------------------------------------
-- 매입 매출 관리 프로젝트
--------------------------------------------------------------------------------

-- 00 회사의 매입매출 관리 프로젝트를 수행하고 있다. 
-- 이 회사는 기존에 엑셀을 이용하여 거래처별 매입매출 관리를 수행해 왔는데 최근 App를 개발하여
-- 데이터베이스 화 하여 관리를 수행하려 한다. 
-- 엑셀 데이터를 받아서 DB로 보내기 위해 변환 작업을 수행하고 있다. 

-- 엑셀 매입매출원장을 DB로 만들기 위해 매입, 매출을 분리하고, 날짜를 문자열화 하였다. 
-- 이 데이터를 DB에 저장하려고 봤더니 이 데이터에 PK칼럼으로 지정할 만한 칼럼을 찾을 수 가 없다. 
-- 이러한 경우(Work DB) 에는 실제 데이터와 별도로 임의의 PK 칼럼을 생성하여 관리 해주는 것이 좋다. 

--------------------------------------------------------------------------------
-- 매입매출 원장 테이블
--------------------------------------------------------------------------------
CREATE TABLE tbl_iolist(
        io_seq	NUMBER		PRIMARY KEY,
        io_date	VARCHAR2(10)	NOT NULL,	
        io_pname	nVARCHAR2(125)	NOT NULL,	
        io_dname	nVARCHAR2(125)	NOT NULL,	
        io_dceo	nVARCHAR2(125)	NOT NULL,
        io_inout	nVARCHAR2(2)	NOT NULL,	
        io_qty	NUMBER		DEFAULT 0,
        io_price	NUMBER		DEFAULT 0,
        io_amt	NUMBER		DEFAULT 0

);

-- 전체 데이터 개수
SELECT COUNT(*) FROM tbl_iolist;

-- 매입과 매출로 구분하여 개수 세기
SELECT io_inout, COUNT(*) FROM tbl_iolist
GROUP BY io_inout;

-- 매입데이터만 보고 싶을 때 
SELECT * FROM tbl_iolist
WHERE io_inout = '매입';

SELECT * FROM tbl_iolist
WHERE io_inout = '매출';

-- 거래 수량이 90개 이상인 데이터만 보고싶을 때
SELECT * FROM tbl_iolist
WHERE io_qty >=90;

-- 데이터를 확인하다 봤더니 단가와 금액이 0인 데이터가 보인다!
SELECT * FROM tbl_iolist
WHERE io_price =0 OR io_amt =0;

--투니스, 7+8칫솔, 레종블루
-- 이 3가지 데이터가 거래된 5번 10번 28번 일련번호의 데이터가 칼럼값이 0이다
-- 이 데이터의 단가, 금액을 수정하기 위해 동일한 상품 데이터가 있는지 확인작업을 거친다.
SELECT * FROM tbl_iolist
WHERE io_pname IN ('투니스', '7+8칫솔', '레종블루');

-- 검색을 해 보았더니 위 3가지 상품의 거래 내역이 전부이다.
-- 다른 곳에서 찾아서 값을 입력해야 할 것이다. 
-- 튜니스 : 1000, 칫솔 : 2500, 레종블루 : 4500 으로 변경하자

-- 투니스 거래 내용의 단가, 금액 변경하기 
-- WHERE io_pname ='투니스';와 같이 set하면 혹시 다른 매입, 매출데이터가 있을 경우 막대한 문제를 일으킬 수 있다.
-- 반드시 PK 칼럼값을 조회하고 PK 칼럼으로 where절을 사용하자 
UPDATE tbl_iolist
SET io_price = 1000, --단가
    io_amt = io_qty * 1000 --금액(수량*단가)
WHERE io_seq = 5; --io_pname 투니스로 해서 바꾼다면?? 매입/매출 구분 따라 단가 다를 수도 있기 때문에
-- PK를 기준으로 SET 해준다.


UPDATE tbl_iolist
SET io_price = 2500, --단가
    io_amt = io_qty * 2500 --금액(수량*단가)
WHERE io_seq = 10; --io_pname 투니스로 해서 바꾼다면?? 매입/매출 구분 따라 단가 다를 수도 있기 때문에


UPDATE tbl_iolist
SET io_price = 4500, --단가
    io_amt = io_qty * 4500 --금액(수량*단가)
WHERE io_seq = 28; --io_pname 투니스로 해서 바꾼다면?? 매입/매출 구분 따라 단가 다를 수도 있기 때문에

SELECT * FROM tbl_iolist
WHERE io_price =0 OR io_amt =0;

-- 원본데이터
--      수량, 매입단가, 매출단가, 매입금액, 매출금액으로 칼럼을 분리하여 사용해왔다. 
--      이러한 형태의 데이터는 각 칼럼에 NULL값이 존재하여, 다양한 연산을 수행할 때 문제를 일으킬 수 있다. 
-- 변환된 데이터
--      수량, 단가, 금액 형식으로 칼럼을 통합작업 수행했다. 
--      칼럼으로 분리된 값들을 공통 칼럼으로 선정하고 데이터를 통합하는 것을 보편적으로 제 3정규화라고 한다. 

-- 변환된 데이터를 참조하여
--      매입, 매출을 구분하여 보고싶은 경우 
--      (거래처  수량, 매입단 가, 매입금액, 매출단가, 매출금액 형식으로 보고 싶을 때)
--      이 데이터는 피벗 형태로 변환해야 한다. 


SELECT * FROM tbl_iolist
WHERE (io_seq >0 AND io_seq <=10) OR (io_seq >=300 AND io_seq <=310)
ORDER BY io_dname;



SELECT io_dname, io_inout, io_qty, io_price, io_amt FROM tbl_iolist
--WHERE (io_seq >0 AND io_seq <=10) OR (io_seq >=300 AND io_seq <=310)
ORDER BY io_dname;

-- PIVOT 으로 데이터 펼쳐보기 라고 한다. 
-- 매입 매출단가 가 단가(io_price) 칼럼에 같이 저장되어 있다.
-- 이 값은 io_inout 칼럼의 값을 모르면 매입인지 매출인지 구별이 어렵다.
-- 따라서 매번 io_inout 칼럼의 값을 표시해야만 매입인지 매출인지 구별할 수 있다. 
-- 그러한 불편을 막기위해서 io_inout 칼럼의 값을 조건으로 하는 DECODE 함수를 사용하여 
-- 단가 부분을 매입단가, 매출단가로 분리하여 보여주도록 쿼리를 작성하였따.

-- 이제 io_inout 칼럼의 값을 몰라도 현재 데이터가 매입데이터인지 매출데이터인지 알기 쉽게 되었다. 

SELECT io_dname, io_inout, io_qty, 

    -- 매입단가(보기위한 가상의 칼럼) 칼럼의 데이터를 보여주는데,
    --- 만약 io_inout 칼럼의 값이 '매입'이면 io_price 칼럼의 값을 표시하고
    -- 그렇지 않으면 0으로 표시하라
    DECODE(io_inout, '매입',io_price,0) AS 매입단가,
    DECODE(io_inout, '매출',io_price,0) AS 매출단가,
    DECODE(io_inout, '매입', io_amt,0) AS 매입합계,
    DECODE(io_inout, '매출', io_amt,0) AS 매출합계
    
FROM tbl_iolist
WHERE (io_seq >0 AND io_seq <=10) OR (io_seq >=300 AND io_seq <=310)
ORDER BY io_dname;





-- "거래처별로" 매입과 매출을 구분하여 볼 수 있는 쿼리를 완성했다.
-- 거래처별로 매입과 매출의 합계를 계산해 보고 싶다. 
-- 이 데이터(1년간 거래내역)에서 거래처별로 총 매입금액, 총 매출금액을 계산해보고 싶다. 

-- 1. 거래처별 거래내역이 여러번 반복 이루어 졌으므로 거래처명이 여러번 나타날 것이다. 
--     이 데이터를 거래처별로 묶어주어야 한다. 
--     GROUP BY io_dname
-- 2. 전체 매출금액과 매입금액을 표시하는 가상칼럼(매출금액, 매입금액을 계산한)을 통계함수로 묶어준다. 

SELECT io_dname,

    SUM(DECODE(io_inout, '매입', io_amt,0)) AS 매입합계,
    SUM(DECODE(io_inout, '매출', io_amt,0)) AS 매출합계
    
FROM tbl_iolist
--WHERE (io_seq >0 AND io_seq <=10) OR (io_seq >=300 AND io_seq <=310)
GROUP BY io_dname
ORDER BY io_dname;


-- 이제 거래처별로 매입합계와 매출합계를 보았으니
-- 각 거래처별로 얼마만큼의 이익을 얻었는지 살펴보자!
-- 이익금 : 매출합계-매입합계로 연산한다. 
SELECT io_dname,

    SUM(DECODE(io_inout, '매입', io_amt,0)) AS 매입합계,
    SUM(DECODE(io_inout, '매출', io_amt,0)) AS 매출합계,
    SUM(DECODE(io_inout, '매출', io_amt,0)) - SUM(DECODE(io_inout, '매입', io_amt,0)) AS 이익금
    
FROM tbl_iolist
--WHERE (io_seq >0 AND io_seq <=10) OR (io_seq >=300 AND io_seq <=310)
GROUP BY io_dname
ORDER BY io_dname;



-- 00회사에서 2019년 1년동안 총 매입, 총매출, 총 이익이 얼마나 발생했는지 알고싶다.
 
SELECT 
    SUM(DECODE(io_inout, '매입', io_amt,0)) AS 매입합계,
    SUM(DECODE(io_inout, '매출', io_amt,0)) AS 매출합계,
    SUM(DECODE(io_inout, '매출', io_amt,0)) - SUM(DECODE(io_inout, '매입', io_amt,0)) AS 이익금
    
FROM tbl_iolist
--WHERE (io_seq >0 AND io_seq <=10) OR (io_seq >=300 AND io_seq <=310) 
ORDER BY io_dname;



















