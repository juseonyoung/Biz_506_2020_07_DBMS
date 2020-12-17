


drop table tbl_navimember;



CREATE TABLE tbl_navimember(
seq	NUMBER PRIMARY KEY,
n_userid	VARCHAR2(30) NOT NULL	UNIQUE,
n_password	nVARCHAR2(255)	NOT NULL,	
n_email	VARCHAR2(125)	NOT NULL,	
n_roll	nVARCHAR2(20),	
n_file	nVARCHAR2(125),
n_date	VARCHAR2(10)
);

CREATE SEQUENCE SEQ_NAVIMEMBER
START WITH 1 INCREMENT BY 1;

SELECT * FROM tbl_navimember;

