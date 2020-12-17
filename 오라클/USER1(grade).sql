
-- oneday grade

create table tbl_grade (
 seq	NUMBER	NOT NULL	PRIMARY KEY,
g_id    CHAR(4) NOT NULL, 
g_name	nVARCHAR2(225)	NOT NULL,	
g_kor	nVARCHAR2(30)	,	
g_eng	nVARCHAR2(30)	,	
g_math	nVARCHAR2(30)	,	
g_sum	nVARCHAR2(30)	,	
g_avg	nVARCHAR2(30)		
);

create SEQUENCE seq_grade
start WITH 1 INCREMENT by 1;

select * from tbl_grade;


commit;

drop table tbl_grade;

