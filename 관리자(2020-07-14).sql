-- Comment : 한줄 주석
/*

    여러줄 주석
    SQL 명령을 입력할 때 명령이 끝났다라는 것을 알리기 위해 ; 붙여준다
    
    Ctrl + Enter : 현재 커서가 있는 곳의 명령문을 DBMS로 보내고 결과를 받음
*/
--이렇게 여러줄로 나누어서 명령해도 됨
-- 현지 오라클에 접속된 사용자(sys)가 관리하는 테이블들이 있는데
-- 그 중에서 tab이라는 이름의 테이블정보를 가져와서 나에게 보여달라
-- *모든 정보
-- 오라클의 tab table은 현재 접속된 사용자가 관리하는 DB Object(객체)들의 정보를 보관하고 있는 table
SELECT * 
FROM tab;

--ALL-ALL-TABLES 오라클 system 데이터 사전의 자세한 정보들을 보관하는 테이블
SELECT *
FROM ALL_ALL_TABLES;

-- SELECT 키워드는 FROM 절을 포함하는 명령문 형태로 작성을 하며 
-- DBMS가 보관하고 있는 데이터를 TABLE형식으로 보여달라 라는 명령이다 
-- DBMS의 DMS(Database Manuplation Language) 중에서 
--      Read(조회)를 수행하는 명령
--      CRUD 중에서 R : Read, Retrive 를 수행하는 명령문)


SELECT *
FROM 주소록;

-- SQL 명령문을 통해서 DB 객체를 만들고 삭제하고, 데이터를 추가,변경, 삭제를 수행할 텐데
-- sys 사용자로 접속을 하게되면 중요한 정보들을 잘못 삭제, 변경 할 우려가 있기 때문에 
-- 실습을 위해서 사용자를 생성하여 수행을 할 것임

-- 사용자를 추가하는 순서
-- 1.(Table space) : 데이터를 저장할 물리적 공간을 설정
-- 2.(user) : 사용자를 생성하고, 물리적 저장공간과 연결

-- TableSpace생성 (Create)
-- TableSpace는 오라클에서 데이터를 저장할 물리적 공간을 설정하는 것
-- myTS: 앞으로 SQL문을 통해서 사용할 TableSpace의 Alias(이름/닉네임)
-- DATAFILE '.../myTS.dbf' : 저장할 파일 이름
-- SIZE : 오라클에서는 성능의 효율성을 높이기 위해 일단 빈 공간을 일정부분 설정하게 된다(여기서는 1M설정)
--        크기는 최초에 저장할 데이터의 크기 등을 계산하여 설계하여 설정한다.
--        너무 작으면 효율이 떨어지고 너무 크면 불필요한 공간을 낭비하게 된다
--        오라클 xe(Express Edition)에서는 table space의 최대 크기를 11G로 제한한다.
--        만약 size 10G로 지정하고, 용량이 초과되어 AUTO NEXT로 추가가 되는 경우
--        전체 사이즈가 11G를 넘어서면 오류가 나면서 더이상 데이터를 저장할 수 없게 된다.

-- AUTO..NEXT :만약 초기에 지정한 사이즈공간에 데이터가 가득차면 자동으로 용량을 늘려서 저장할 수 있게한다

-- SIZE의 1M : 기본크기를 1024 * 1024 byte 크기로 지정하라. 사이즈 지정할 때 1MB라고 하지 않기!
-- NEXT 500K : 자동으로 확장(늘리기)을 1024 * 500 크기로 설정
--             NEXT 지정 시 500KB라고 하지 않는다. 

-- CREATE로 시작되엉 명령문 : DDL(Data definition Language) 데이터 선언, 생성(추가와는 다름!)
CREATE TABLESPACE myTS
DATAFILE 'C:/bizwork/workspace/oracle_data/myTS.dbf'
SIZE 1M AUTOEXTEND ON NEXT 500K;

-- 질의작성기에서 코드를 작성할 때 약속!
-- DBMS의 SQL문은 특별한 일부 경우를 제외하고 대소문자 구별을 하지 않는다.
-- DBMS, SQL, 오라클과 관련된 "키워드"는 모두 대문자로 작성할 것
-- 변수, 값, 내용 등은 소문자로 사용하며 특별히 대소문자를 구분해야 하는 경우는 별도로 공지할 것

--DROP : DDL 명령의 CREATE와 반대되는 개념의 명령문
--DROP 명령은 데이터를 물리적으로 완전삭제하는 개념이므로 매우 신중하게 사용하여야 한다.
DROP TABLESPACE myTS --myTS TableSpace를 삭제하면서
INCLUDING CONTENTS AND DATAFILES --연관된 정보와 data file도 같이 삭제하고
CASCADE CONSTRAINTS; --그리고 설정된 권한, 역할 등이 있으면 그들도 같이 삭제하라

-- 위에서 생성한 TableSpace를 관리하며, 데이터를 조작할 사용자를 생성
CREATE USER user1 IDENTIFIED BY 1234 --사용자 ID를 USER1으로 설정하고 초기 비번을 1234로 하겠다
DEFAULT TABLESPACE myTS;

-- DCL : Data Control Language
-- 새로생성된 user1에게 권한을 부여하기
-- user1이 로그인만 할 수 있도록 권한(역할)을 부여하라
GRANT CONNECT TO user1;

-- user1이 로그인할 수 있는 권한을 제거
REVOKE CONNECT FROM user1;

-- user1이 로그인을 수행하고, 최소한으로 데이터들을 관리할 수 있도록 권한을 부여하라
-- RESOURCE : 오라클에서 USER에게 줄 수 있는 권한 중 상당히 많은 일을 수행할 수 있는 권한
-- 현재 시스템에 설치된 모든 Tablespace를 대상으로 무제한(TableSpace가 허용하는 범위까지) 저장이 가능한 권한
-- RESOURCE 권한은 standard, enterprice DBMS에서는 함부로 부여해서는 안된다.
-- CONNECT와 RESOURCE 권한을 부여하게 되면 거의 DBA 수준의 권한을 갖게 된다.
GRANT CONNECT, RESOURCE TO user1;

-- login권한과 table을 생성할 권한을 부여
GRANT CONNECT, CREATE TABLE TO user1;
-- login권한과 table을 생성할 권한, 학생정보 테이블에 데이터를 추가할 권한을 부여
GRANT CONNECT, CREATE TABLE, INSERT TABLE 학생정보 TO user1;

-- login권한과 table을 생성할 권한, 학생정보 테이블에 데이터를 추가, 학생정보 조회할 권한을 부여
GRANT CONNECT, CREATE TABLE, INSERT TABLE 학생정보, SELECT TABLE 학생정보 TO user1;


-- 권한을 세부적으로 부여하는 것은 매우 필요하며 중요한 일이다
-- 하지만 학습하는 입장에서 grant 부여하는데 너무 많은 노력을 보이면 피곤하니 
-- xe 버전에서는 사용자에게 DBA권한을 부여하고 실습을 수행한다.
GRANT DBA TO user1;

-- DBA 권한(Roll)은 sysDBA보다 한단계 낮은 권한 등급을 가지며
-- 일반적으로 자신이 생성한 Table 등 DB Object에만 접근하여 명령을 수행한다.

