--관리자 화면


-- 블로그를 위한 테이블 스페이스 생성
create tablespace blogTS
datafile 'C:/bizwork/oracle_dbms/blog.dbf'
size 1m AUTOEXTEND on next 1k; 

-- user1 사용자 생성
create user user1 IDENTIFIED by user1
default tablespace blogTS;

--user1에 권한부여
grant dba to user1;



