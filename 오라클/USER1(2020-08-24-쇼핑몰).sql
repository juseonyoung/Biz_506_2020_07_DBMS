-- d\여기는 user1화면

select * from tbl_product;

select min(p_code) from tbl_product;
select max(p_code) from tbl_product;

insert into tbl_product (p_code, p_name)
values ('P001', '테스트상품');

select * from tbl_product where p_code =rpad('P001',6,' ');
commit;

select rpad('가',10,'p') from dual;

/*

테이블에서 1개의 칼럼을 기본키로 설정할 수 없을 경우 2개이상의 칼럼을 묶어서 기본키로 설정한다
하지만 아래 테이블에서 sc_num, sc_subject를 묶어서 기본키로 설정할 경우
sc_subject 칼럼이 가변문자열인 관계로 나중에 문제를 일으킬 수 있다.
이러한 테이블에서는 데이터와 별도로 seq 또는 아이디라는 칼럼을 생성하고
해당 칼럼을 일련번호 등을 부여하여 기본키로 만드는 것이 좋다. 
*/

create table tbl_score(
    sc_num char(5),
    sc_subject nvarchar2(20),
    sc_score number
);


