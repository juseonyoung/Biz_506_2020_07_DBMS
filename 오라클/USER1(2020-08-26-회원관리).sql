-- user1

create table tbl_member(
        M_USERID	VARCHAR2(20)		PRIMARY KEY,
        M_PASSWORD	VARCHAR2(125)	NOT NULL,	
        M_NAME	nVARCHAR2(30)	NOT NULL,	
        M_TEL	VARCHAR(20),		
        M_ADDRESS	nVARCHAR2(255),		
        M_ROLL	VARCHAR(20)		
);

select * from tbl_member;

drop table t
