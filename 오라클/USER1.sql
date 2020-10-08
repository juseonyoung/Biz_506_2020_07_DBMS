--여기는 user1의 작업 화면입니다.

-- 블로그 테이블 생성
create table tbl_blogs (

        bl_seq	NUMBER		PRIMARY KEY,
        bl_user	nVARCHAR2(20)	NOT NULL,	
        bl_date	VARCHAR(10)	NOT NULL,	
        bl_time	VARCHAR(10)	NOT NULL,	
        bl_title	nVARCHAR2(125)	NOT NULL,	
        bl_contents	nVARCHAR2(2000)	NOT NULL	
);

--일련번호 생성을 위하여 sequence를 생성
-- 시작값을 1로 그리고 1씩 증가하는 조건
create sequence seq_blog
start with 1 INCREMENT by 1

/*
sql developer와 기타 다른 프로그래밍 프로젝트와 연동할 때 sql developer에서 
CRUD 수행했음에도 불구하고 프로젝트에서 조회되는 데이터에 반영이 안되는 경우가 있다. 

원인은???
sql developer에서 cud(create, update, delete) 를 수행하면
실제 로컬스토리지의 data는 직접 적용이 안된다.
변경한 데이터는 메모리 기억장소에 저장되어 있을 뿐이다.

프로그래밍 프로젝트에서 반영된 결과를 가져다 사용하려면 커밋 명령을 수행해 주어야 한다. 

*/
insert into tbl_blogs(bl_seq, bl_user, bl_date, bl_time, bl_title, bl_contents)
values(SEQ_BLOG.NEXTVAL, '홍길동','2020-08-14','09:47:00','나의 블로그','블로그를 만들자');

insert into tbl_blogs(bl_seq, bl_user, bl_date, bl_time, bl_title, bl_contents)
values(SEQ_BLOG.NEXTVAL, '이몽룡','2020-08-14','09:47:01','블로그 축하','블로그 개설 축하합니다');

insert into tbl_blogs(bl_seq, bl_user, bl_date, bl_time, bl_title, bl_contents)
values(SEQ_BLOG.NEXTVAL, '성춘향','2020-08-14','09:47:02','블로그 개설 축하','축하!');
commit;

select * from tbl_blogs;




