--------------------------------------------------------
--  파일이 생성됨 - 화요일-7월-21-2020   
--------------------------------------------------------
use myDB;
-- 만약 tbl_dept 가 있으면 삭제하고 다시 만들어라 
drop table if exists TBL_DEPT;
-- 테이블이 없으면 새로 만들어라 
create table if not exists TBL_DEPT(
	D_CODE char(4) primary key,
	D_NAME varchar(30) not null,
	D_PROF varchar(30)
);
Insert into TBL_DEPT (D_CODE,D_NAME,D_PROF) values ('D001','관광학','홍길동');
Insert into TBL_DEPT (D_CODE,D_NAME,D_PROF) values ('D002','국어국문','이몽룡');
Insert into TBL_DEPT (D_CODE,D_NAME,D_PROF) values ('D003','법학','성춘향');
Insert into TBL_DEPT (D_CODE,D_NAME,D_PROF) values ('D004','전자공학','임꺽정');
Insert into TBL_DEPT (D_CODE,D_NAME,D_PROF) values ('D005','컴퓨터공학','장영실');
