

----------poslist매입매출원장--

create table tbl_poslist(
seq NUMBER NOT NULL PRIMARY KEY,
io_date VARCHAR2(10) NOT NULL,
io_time VARCHAR2(10) NOT NULL,
io_dcode VARCHAR2(5) NOT NULL,
io_inout CHAR(1) NOT NULL, 
io_pcode VARCHAR2(13) NOT NULL,
io_vat CHAR(1) NOT NULL, 
io_qty NUMBER NOT NULL,
io_price NUMBER NOT NULL, 
io_amt NUMBER, 
io_tax NUMBER,
io_total NUMBER,
P_NOT_USE	CHAR(1)	DEFAULT NULL
);

create sequence seq_pos
start with 1 increment by 1;

drop table tbl_poslist;
drop table tbl_depts;
drop table tbl_products;

select * from tbl_poslist;

select * from tbl_depts;

select * from tbl_products;


------------거래처 원장---
create table tbl_depts(
d_code VARCHAR2(5) NOT NULL PRIMARY KEY,
d_name nVARCHAR2(20) NOT NULL,
d_sid VARCHAR2(13) NOT NULL,
d_ceo nVARCHAR2(20) NOT NULL,
d_tel VARCHAR2(20) NOT NULL,
d_addr nVARCHAR2(125),
d_product nVARCHAR2(125),
P_NOT_USE	CHAR(1)	DEFAULT NULL
);

-----------상품원장
create table tbl_products(
 p_code VARCHAR2(13) NOT NULL PRIMARY KEY,
 p_name nVARCHAR2(50) NOT NULL,
 p_item nVARCHAR2(50),
 p_menuf nVARCHAR2(50),
 p_dcode VARCHAR2(5),
 p_vat CHAR(1) NOT NULL,
p_iprice NUMBER NOT NULL,
p_oprice NUMBER NOT NULL,
P_NOT_USE	CHAR(1)	DEFAULT NULL
);


