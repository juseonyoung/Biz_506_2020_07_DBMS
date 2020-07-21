-- 여기는 관리자 화면입니다. 
-- 새로운 tablespace와 사용자를 등록하기
--TableSpace user2Ts,
--user : user2, pw : user2
-- C:\bizwork\workspace\oracle_data

create tablespace user2Ts
datafile 'C:/bizwork/workspace/oracle_data/user2.dbf'
size 1m AUTOEXTEND on next 10k;

-- 테이블과 연결한 사용자 등록
create user user2 identified by user2
default tablespace user2Ts;

-- 내가만든 사용자에게 권한 부여
grant dba to user2;

