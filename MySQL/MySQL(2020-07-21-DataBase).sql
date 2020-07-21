-- MySQL 에서 사용자는 기본적으로 root시작을 한다.
-- 오라클과 차이점 
---------------------------------------------------------
-- 구분             오라클                   MySQL
-- 저장소           TableSpace             DataBase
-- Scheme         User				   	 DataBase
-- 데이터저장        User.Table형식			Table
-- User의 개념       Scheme              login하는 account
---------------------------------------------------------

-- 1. MySQL 데이터를 저장하기 위해서 최초로 DataBase를 생성
-- 2. 생성된 Database를 사용가능하도록 open 절차 필요
-- 3. 사용자 login 권한과 접속하는 용도의 Account 

drop database myDB;

-- MySQL character set
-- 저장하는 문자열의 코드길이 (Byte)관련한 설정
-- MySQL 5.x(5.7)에서는 문자 locale 설정이 기본값이 Lathin이어서 한글과 같은 unicode저장에 상당히 문제가 되었던 적이 있다.
-- 최근에는 기분 문자 locale utf8M4 라는 방식으로 거의 통일되었다.
-- 따라서 별도로 character set을 지정하지 않아도 큰 문제가 없다.
-- 오래된 MySQL 버전에서는 database를 생성할 때 character set을 명시해 주었으나 최근 버전에서는 오히려 경고를 내고 있다. 

-- 현재 PC에 설치된 mysql서버에 myDB라고 하는 scheme(database)를 생성 
Create database myDB; -- default character set utf8;

-- mySQL 칼럼 type
-- 문자열 : char(개수), varchar(개수)
-- CHAR : 고정된 문자열을 저장하는 칼럼(코드 등의 데이터) 255자까지 가능
-- VARCHAR : 한글을 포함한 가변형 문자열을 저장하는 칼럼 : 65565까지 가능

-- 정수형 숫자 : INT(4byte, 2의 32승), BIGINT(8byte, 실제로는 무제한), TINYINT(1byte, -128~ +127,0 ~255),
--			  SMALLINT(0~65535), MEDIUMINT(0~1677215)
-- 정수형의 경우 자릿수를 명시하지 않으면 최대지원 크기까지 저장 가능하다. 
-- 실제 저장을 해보면 int형은 정수 11자리를 넘어가면 저장이 안된다. 

-- 실수형 : float(길이, 소수점, 4byte), decimal(길이, 소수점), double(길이, 소수점, 8byte) 

-- mysql에서는 데이터와 관련된 DDL, DML, DCL 등의 명령을 수행하기 전에 사용할 스키마를 open하는 절차가 반드시 필요하다.
-- myDB데이터 베이스 오픈 시키는 명령어 먼저 실행
USE myDB;
drop table tbl_student;
create table tbl_student(
		st_num	CHAR(5)		PRIMARY KEY,
		st_name	VARCHAR(20)	NOT NULL,	
		st_dept	VARCHAR(10),		
		st_grade	INT(1),		
		st_tel	VARCHAR(20),		
		st_addr	VARCHAR(125),		
		st_age	INT	
);

DESC tbl_student;
drop table tbl_score;
select * from tbl_student;
create table tbl_score(

	sc_num	CHAR(5)	NOT NULL,
	sc_scode	CHAR(4)	NOT NULL,
	sc_sname	VARCHAR(30),	
	sc_score	INT	
);

-- projection
select st_num, st_name, st_tel from tbl_student;

-- selection
select st_num, st_name
from tbl_stutbl_studentdent
where st_num between '20001' and '20010';


select * from tbl_dept;

select ST.st_num, ST.st_name, ST.st_tbl_studenttbl_studentdept, D.d_name, D.d_prof
from tbl_student ST
	left join tbl_dept D
		on ST.st_dept = D.d_code;
        
select count(*) from tbl_iolist;

select io_bcode from tbl_iolist;

-- decode()
select io_bcode,
	sum(case when io_inout = '매입' then io_amt else 0 end) AS '매입합계',
	sum(case when io_inout = '매출' then io_amt else 0 end) AS '매출합계'
from tbl_iolist
group by io_bcode;


select 
	sum(case when io_inout = '매입' then io_amt else 0 end) AS '매입합계',
	sum(case when io_inout = '매출' then io_amt else 0 end) AS '매출합계',
    sum(case when io_inout = '매출' then io_amt else 0 end) -
    sum(case when io_inout = '매입' then io_amt else 0 end) AS '이익금'
    
from tbl_iolist;

-- 현재 스키마의 table 리스트
show tables;

-- 현재 mysql server에 만들어진 스키마(database)리스트
show databases;


DESC tbl_score;
----------------------------------
-- tbl_score 테이블에 데이터 추가하기
----------------------------------
-- 만약 학번 20001인 학생의 국어(D001), 영어(D002), 수학(D003) 점수를 입력한다 라고 하면
insert into tbl_score(sc_num, sc_scode, sc_sname,sc_score)
values ('20001','D001','국어',80);

insert into tbl_score(sc_num, sc_scode, sc_sname,sc_score)
values ('20001','D002','영어',70);

insert into tbl_score(sc_num, sc_scode, sc_sname,sc_score)
values ('20001','D003','수학',75);

insert into tbl_score(sc_num, sc_scode, sc_sname,sc_score)
values ('20002','D001','국어',75);

insert into tbl_score(sc_num, sc_scode, sc_sname,sc_score)
values ('20002','D002','영어',70);

insert into tbl_score(sc_num, sc_scode, sc_sname,sc_score)
values ('20002','D003','수학',100);


select * from tbl_score;

-- 한개의 칼럼으로 PK를 만들 때는 설계할 때 고려를 하고 table 생성할 때 만드는 것이 편리하다.
-- 두개 이상의 복합키를 만들 때는 보통 테이블 설계가 완료되고 table을 만들고 데이터가 추가되는 과정에서 생성되는 경우가 많다.
-- 복합키인 경우 alter 이용해 PK설정
-- 두개 이상의 후보키를 묶어서 PK로 설정하는 복합키 PK가 된다. 
alter table tbl_score ADD primary key(sc_num, sc_scode);
alter table tbl_score drop primary key;
select * from tbl_score;

-- 어떤 테이블을 만들었는데, 이 테이블에 PK를 설정하려고 봤더니
-- 단일키로 pk를 설정하기가 매우 어렵게 되었다.
-- 복합키로 pk를 설정해야 하는데 왠지 그러기싫음
-- 임의 실제 데이터와는 관계가 없이 별도의 pk만을 위한 칼럼을 만들고, 그 칼럼에 일련번호와 같은 값을 채워서 pk로 삼고싶다. 
-- insert보다는 update, delete의 무결성을 위한 설정

-- auto_increment, auto increment 둘다 사용가능

-- 이미 사용중인 테이블에 일련번호를 채울 pk만을 위한 칼럼 생성하는 방법
alter table tbl_score ADD sc_seq bigint primary key auto_increment;
desc tbl_score;
select * from tbl_score;

-- 설계를 하면서 일련번호를 채울 pk만을 위한 칼럼을 생성하는 방법
drop table tbl_score;
create table tbl_score(
	sc_seq bigint primary key auto_increment,
	sc_num	CHAR(5)	NOT NULL,
	sc_scode	CHAR(4)	NOT NULL,
	sc_sname	VARCHAR(30),	
	sc_score	INT	
);

select * from tbl_score;
insert into tbl_score(sc_num, sc_scode, sc_sname, sc_score)
values ('20003','D001','국어',90);


insert into tbl_score(sc_seq,sc_num, sc_scode, sc_sname, sc_score)
values (10,'20003','D001','국어',90);




