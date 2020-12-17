-- 프로젝트 ems 테이블 만드는곳 ㅗㅗ

create table tbl_ems (
    
    id	NUMBER	NOT NULL	PRIMARY KEY,
from_email	nVARCHAR2(30)	NOT NULL,	
to_email	nVARCHAR2(30)	NOT NULL,	
s_date	nVARCHAR2(10),		
s_time	nVARCHAR2(10),		
s_subject	nVARCHAR2(125),		
s_content	nVARCHAR2(2000),		
s_file1	nVARCHAR2(125),		
s_file2	nVARCHAR2(125)
);

select * from tbl_ems;


create SEQUENCE seq_ems
start with 1 increment by 1;

delete from tbl_ems;
commit;
-- image table

create table tbl_emsimages (
i_seq	NUMBER		PRIMARY KEY,
i_b_seq	NUMBER	NOT NULL,	
i_org_name	nVARCHAR2(255)	NOT NULL,
i_file_name	nVARCHAR2(255)	NOT NULL,	
i_down	NUMBER		
);

create SEQUENCE seq_emsimages
start with 1 increment by 1;

select * from tbl_emsimages;