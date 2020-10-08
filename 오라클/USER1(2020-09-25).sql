-- user1 독서록 프로젝트

Drop table tbl_member;
create table tbl_member (
    M_USERID	VARCHAR2(30)		PRIMARY KEY,
    M_PASSWORD	nVARCHAR2(225)	NOT NULL,	
    M_NAME	nVARCHAR2(30),		
    M_TEL	VARCHAR2(30),
    M_EMAIL	VARCHAR2(30),		
    M_ADDRESS	nVARCHAR2(125),		
    M_ROLL	VARCHAR2(20),		
    
    -- eable 칼럼에 문자열 0 또는 1 이외의 값은 저장하지 말라
    -- 체크 제약사항 등록
    ENABLED	CHAR(1)	DEFAULT '0' CONSTRAINT enabled_veri check(enabled = '0' or enabled = '1'),	
    AccountNonExpired	CHAR(1),		
    AccountNonLocked	CHAR(1),		
    CredentialsNonExpired	CHAR(1)		
);
drop table tbl_authority;
create table tbl_authority(
seq	NUMBER		PRIMARY KEY,	
M_USERID	VARCHAR2(30)	NOT NULL,		
M_ROLE	VARCHAR2(30)	NOT NULL		
);
create SEQUENCE seq_authority
start with 1 INCREMENT by 1;

select * from tbl_member;

delete from tbl_member;
commit;

select * from tbl_authority;
delete from tbl_authority;

-- 한개의 테이블에 여러개의 데이터를 insert 할 때 사용하는 다종 insert sql 이다
-- seq 값으로 PK 설정을 해두면 SQL 작동을 하지 않는다. 
insert all 
    into tbl_member (m_userid,m_password) values ('user1',1)
    into tbl_member (m_userid,m_password) values ('user2',1)
    into tbl_member (m_userid,m_password) values ('user3',1)
    into tbl_member (m_userid,m_password) values ('user4',1)
    into tbl_member (m_userid,m_password) values ('user5',1)
select * from dual;    


-- seq 값을 시퀀스의 nextval 값으로 설정하는 table의 경우 다종 insert 오류발생을 ㅎ낟. 
insert all into tbl_authority (m_userid,m_role) values ('admin','admin')
into tbl_authority (m_userid,m_role) values ('admin1','admin')
into tbl_authority (m_userid,m_role) values ('admin2','admin')
into tbl_authority (m_userid,m_role) values ('admin3','admin')
select * from dual;

delete from tbl_member;
delete from tbl_authority;
commit;
-- 오라클에서 SEQ PK 칼럼을 가진 테이블 다종 insert 문을 수행하기 위해서
-- 1. 추가할 데이터를 갖는 가상의 테이블을 생성
-- 2. 가상 테이블 생성 SQL을 서브쿼리로 묶는다
-- 3. 서브쿼리 부모 SQL에서 seq.nextval을 실행시켜서 unique한 seq값을 생성
-- 4. 생성된 가상테이블 데이터를 insert 문을 사용하여 table에 추가!
-- 5. 생성된 가상테이블의 데이터를 tbl_authority table에 복사하는 코드

-- 이건 가상 테이블
insert into tbl_authority (seq,m_userid,m_role)
select seq_authority.nextval, sub.* from 
(
select 'user11' as username,'ROLE_ADMIN' as authority from dual
union all
select 'user11' as username,'ROLE_USER' as authority from dual
union all
select 'user12' as username,'ROLE_ADMIN' as authority from dual
union all
select 'user12' as username,'ROLE_USER' as authority from dual
) SUB;
select * from tbl_authority;

select * from tbl_member;

update tbl_member set enabled = 1 where m_userid = 'user';
commit;

select * from tbl_member M
    left join tbl_authority A
    on M.m_userid = A.m_userid;


