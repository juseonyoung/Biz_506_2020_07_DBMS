-- 여기는 user1 화면입니다
-- 상품정보의 삭제기능을 구현하기 위해 삭제 Flag 칼럼을 추가!
drop table tbl_product;
create table tbl_product (
    P_CODE	CHAR(6)		PRIMARY KEY, 
P_NAME	nVARCHAR2(30)	NOT NULL,	
P_DCODE	CHAR(4),		
P_STD	nVARCHAR2(20),		
P_IPRICE	NUMBER,		
P_OPRICE	NUMBER,		
P_IMAGE	nVARCHAR2(125),		
P_NOT_USE	CHAR(1)	DEFAULT NULL	
);

-- 삭제표시가 되지 않은 데이터만 조회!
select * from tbl_product;
select * from tbl_product where p_not_use is null;
select * from tbl_dept;

commit;


drop table tbl_dept;
create table tbl_dept (
D_CODE	CHAR(4)		PRIMARY KEY,
D_NAME	nVARCHAR2(50)	NOT NULL,	
D_CEO	nVARCHAR2(30)	NOT NULL,	
D_TEL	VARCHAR(20),		
D_ADDRESS	nVARCHAR2(255),		
D_MANAGER	nVARCHAR2(50),		
D_MN_TEL	VARCHAR(20),	
D_NOT_USE	CHAR(1)	DEFAULT NULL	
);