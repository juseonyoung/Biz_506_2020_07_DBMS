-- ����� user1
-- tbl_iolist���� ��ǰ��, �ŷ�ó��, �ŷ�ó CEO Į���� �����Ͱ� �Ϲ� ���ڿ� ���·� ����Ǿ� �ִ�. 
-- �� �����ʹ� ���� Į���� �ߺ��� �����Ͱ� �־ ������ �������鿡�� ����� ������ ��Ȳ�̴�. 
--      ���� � ��ǰ�� ��ǰ���� ������ �ʿ��� ��� 
--      ��ǰ���� update �Ͽ��� �ϴµ�, 2�� �̻��� ���ڵ带 ������� ������Ʈ������ �ʿ��ϴ�.
--      2�� �̻��� ���ڵ带 ������Ʈ �����ϴ� ���� �������� ���Ἲ�� ��ĥ�� �ִ� ������ �ȴ�. 
-- �̷��� ������ �����ϱ� ���� �Ʒ��� ���� ����ȭ�� �����Ѵ�.

-- ��ǰ�� ������ ������ ���̺�� �и��ϰ�, ��ǰ������ ��ǰ�ڵ带 �ο��� �� 
-- tbl_iolist�� �����ϴ� ������� ����ȭ�� �����Ѵ�.

-- 1. tbl_iolist�κ��� ��ǰ�� ����Ʈ�� ��������
--      ��ǰ�� Į���� group by �Ͽ� �ߺ����� ���� ��ǰ�� ����Ʈ�� �����Ѵ�. 
SELECT io_pname, 
    MIN(DECODE(io_inout,'����', io_price,0)) AS ���Դܰ�,
    MAX(DECODE(io_inout,'����', io_price,0)) AS ����ܰ�
FROM tbl_iolist
GROUP BY io_pname
ORDER BY io_pname;


------------------------------
-- ��ǰ���� ���̺�
------------------------------
CREATE TABLE tbl_product(
        p_code	CHAR(5)		PRIMARY KEY,
        p_name	nVARCHAR2(125)		NOT NULL,
        p_iprice	NUMBER,		
        p_oprice	NUMBER,		
        p_vat	CHAR(1)		DEFAULT '1'
);


SELECT * FROM tbl_product;


/*
���Ը��� ���̺��� ��ǰ����(�̸�, �ܰ�) �κ��� �����Ͽ� ��ǰ�������̺��� �����ߴ�
���ϸ��� ���̺��� ��ǰ�̸� Į���� �����ϰ� 
��ǰ���� ���̺�� join �� �� �ֵ��� �����ؾ� �Ѵ�. 

���� ���Ը��� ���̺��� ��ǰ�̸��� ����ְ� ��ǰ���� ���̺��� 
��ǰ�ڵ�, ��ǰ�̸�, ���� ����ܰ��� �ִ�. 
���Ը��� ���̺��� ��ǰ�̸��� �ش��ϴ� ��ǰ�ڵ带 ���Ը��� ���̺� update �ϰ� 
���Ը��� ���̺��� ��ǰ�̸� Į���� ������ �� , join�� �����Ͽ� �����͸� Ȯ���ؾ� �Ѵ�. 
*/

-- 1.���Ը��� ���̺��� ��ǰ��� ��ǰ���� ���̺��� ��ǰ���� join�ؼ� ���Ը��� ���̺��� ��ǰ����
--   ��ǰ������ ��� �ִ��� Ȯ���ϴ� ���� �ʿ�ڡڡڡڡڡ�
SELECT IO.io_pname, P.p_name
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pname = P.p_name;

-- �� ������ �����Ͽ� P.p_name �׸� null���� �ִٸ� ��ǰ���� ���̺��� �߸� ��������ٴ� ��!
-- ��ǰ���� ���̺��� �����ϰ� ������ �ٽ� �����ؾ� �Ѵ�. 

-- ���� ����߿� P.p_name �׸��� ���� null�� ����Ʈ�� ������ 
-- ���� ����� �����̶�� ����Ʈ�� �Ѱ��� ����� �Ѵ�. 
SELECT IO.io_pname, P.p_name
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pname = P.p_name
WHERE P.p_name IS NULL; --�ش�Į�� ���� null�� �ƴϳ�? : is not null


-- ���� ��ǰ�����Ͱ� �̻� ������ �˾����� ���� ���� ���̺� ��ǰ�ڵ带 ������ "Į��"�� �߰�
-- ���̺� ���� ����� �� �ƴ�
-- ALTER TABLE : ���̺��� ���� (Į�� �߰�, ����) ����, Į���� type���� �� �����ϴ� ���
-- ��ǰ ���̺��� pcodeĮ���� ���� Ÿ������ io_pcode Į���� �߰�!
ALTER TABLE tbl_iolist ADD io_pcode CHAR(5);
ALTER TABLE tbl_iolist DROP COLUMN io_pcode;

-- alter table�� �� �� ���� ���� ����
-- �̹� ���� �����Ͱ� insert �Ǿ� �ִ� ���¿��� Į���� �߰��ϸ� �߰��ϴ� Į���� �翬�� �ʱⰪ�� null�� �ȴ�. 
-- �� ������� Į���� �߰��ϸ� ���� Į���߰��� �ȵȴ�. 
-- �� ����� ���� �����Ͱ� 1���� ���� ���� �����ϴ�. 
alter table tbl_iolist ADD (io_pcode CHAR(5) not null); 

-- not null ������ �߰��ϱ� 
-- 1.p_code Į�� �߰�, �⺻������ ���ڿ��̹Ƿ� ��ĭ �߰�(���� Į�� �̶�� 0�� �߰�)
ALTER TABLE tbl_iolist ADD (io_pcode CHAR(5) default ' ');

-- 2.p_code Į���� ���������� not null�� ����
ALTER TABLE tbl_iolist modify (io_pcode constraint io_pcode not null);




-- Į�� �߰�
ALTER TABLE tbl_iolist ADD (io_pcode CHAR(5) default ' ');

-- Į�� ����
ALTER TABLE tbl_iolist DROP COLUMN io_pcode;

-- Į���� not null ���� �߰��ϱ�
ALTER TABLE tbl_iolist modify (io_pcode constraint io_pcode not null);

-- Į���� Ÿ�� �����ϱ�
ALTER TABLE tbl_iolist modify (io_pcode char(10));

-- Į���� Ÿ�� �����ϱ� ���� ����!!!
-- Į���� Ÿ���� ������ �� 
-- ���ڿ� <-> ���� ó�� Ÿ���� ������ �ٸ� ���� ������ �߻��ϰų� �����͸� ��� ���� �� �ִ�. 
-- char <-> (n)varchar2 
--  ���ڿ��� ���̰� ������ ������ ��ȯ�� �̷�� ����. 
-- char <-> (n)varchar2 �� ����� ���ڿ��� �����ڵ�(�ѱ� ��)�̸� �ſ� ���Ǹ� �ؾ��Ѵ�. 
-- ���� ���̰� �ٸ��� ������ ������, ���������� ����� ����Ǵ��� �����Ͱ� �߸��ų� ���ڿ��� �� �� ���� ������ �����Ǵ� ��찡 �߻��Ѵ�. 



-- Į���� �̸������ϱ�
-- io_pcode �̸��� io_pcode1���� �����ϱ� 
ALTER TABLE tbl_iolist rename column io_pcode to io_pcode1;

-- ��ǰ�������� ���Ը����� �� ���ڵ��� ��ǰ��� ��ġ�ϴ� ��ǰ�ڵ带 ã�Ƽ� 
-- ���Ը������� ��ǰ�ڵ�(io_pcode) Į���� update���ֱ� 

-- update ����� sub������ ������ 
-- 1. ������������ ���� iolist �� io_pname Į���� ���� �䱸�ϰ� �ִ�. 
-- 2. tbl_iolist�� ���ڵ带 ��ü select�� �����Ѵ�. 
-- 3. select �� ����Ʈ���� io_pname Į�� ���� ���� ������ �����Ѵ�. 
-- 4. ���������� ���޹��� io_pname ���� tbl_product ���̺��� ��ȸ�� �Ѵ�. 
--     �̶� ���������� �ݵ�� 1���� Į��, 1���� VO�� �����ؾ� �Ѵ�. 
-- 5. �� ����� ���� iolist�� ���ڵ��� io_pcode Į���� update �� �����Ѵ�. 

update tbl_iolist IO
set io_pcode =
(
    select p_code --�ݵ�� 1����
    from tbl_product P
    where p_name = IO.io_pname
);

SELECT io_pcode from tbl_iolist;

--iolist�� pcode�� ���������� update �Ǿ����� ����
select io_pcode, io_pname, p.p_name
from tbl_iolist IO
    left join tbl_product P
        on IO.io_pcode = P.p_code
where p.p_name is null;

-----------------------------
--�ŷ�ó������ ����ȭ
-----------------------------
-- �ŷ�ó��, ceo Į���� ���̺� ��� �ִ�.
-- �� Į���� �����Ͽ� �ŷ�ó ������ ����
-- ����� ������ �� �ŷ�ó���� ���� ceo�� �ٸ��� �ٸ� ȸ��� ����
-- �ŷ�ó��� ceo�� ������ ���� ȸ��� ���� �����͸� �����. 
select io_dname, io_dceo
from tbl_iolist
group by io_dname, io_dceo
order by io_dname;


create table tbl_buyer(
        b_code	CHAR(4)		PRIMARY KEY,
        b_name	nVARCHAR2(125)	NOT NULL,	
        b_ceo	nVARCHAR2(50)	NOT NULL,	
        b_tel	VARCHAR2(20)		
);

-- b_tel Į���� ���� �ߺ��� (2�� �̻�) ���ڵ尡 �ֳ�?
select * from tbl_buyer;
select b_tel, count(*) from tbl_buyer
group by b_tel
having count(*) > 1;

-- iolist�� ����� dname, dceo Į������ �ŷ�ó�������� �����͸� ��ȸ�ϰ�
-- iolist�� �ŷ�ó �ڵ� Į������ update �����ϱ�

alter table tbl_iolist add (io_bcode char(4) default ' ');
alter table tbl_iolist modify (io_bcode constraint io_bcode not null);

desc tbl_iolist;


 COMMIT ;

-- iolist �� buyer ���̺��� �ŷ�ó��, ��ǥ�ڸ� Į������ join�� �����Ͽ� �����Ͱ���
-- �����Ͱ� �Ѱ��� ��µ��� �ʾƾ� �Ѵ�.
select io.io_dname, b.b_name
from tbl_iolist IO
    left join tbl_buyer B
        on IO.io_dname = B.b_name
where B.b_name is null;



drop table tbl_buter cascade constraints;


-- iolist �� �ŷ�ó �ڵ� ������Ʈ�ϱ�
-- ���� ������ tbl_buyer ���̺��� �ŷ�ó���� ���� ��ǥ�ڰ� �ٸ� �����Ͱ� �ִ�.
-- �� �����Ϳ��� �ŷ�ó������ ��ȸ�� �ϸ� ��µǴ� ���ڵ�(row)�� 2�� �̻��� ��찡 �߻��Ѵ�. 
-- ���� �� ������ �����ϸ� single-row subquery returns more than one row ������ �߻��Ѵ�. 
-- �� ������ �ŷ�ó��� ceo ���� ���ÿ� �����Ͽ� 1���� row���� sub�������� ����� ������ �ؾ� �Ѵ�. 
update tbl_iolist IO
set io_bcode =
(
    select b_code
    from tbl_buyer B
    where B.b_name = IO.io_dname AND B.b_ceo = IO.io_dceo
);

select io_bcode, io_dname, b_code, b_name
from tbl_iolist IO
    left join tbl_buyer B
        on IO.io_bcode = B.b_code
where b_code is null or b_name is null;

-- �����͸� tbl_product , tbl_buyer ���̺�� �и�������
-- tbl_iolist���� io_pname, io_dname, io_dceo Į���� �ʿ䰡 �����Ƿ� �����Ѵ�. 

alter table tbl_iolist drop column io_pname;
alter table tbl_iolist drop column io_dname;
alter table tbl_iolist drop column io_dceo;

select * from tbl_iolist;

create view view_iolist
AS
(
select io_seq, io_date, 
    io_bcode, b_name, b_ceo, b_tel, 
    io_pcode, p_name, p_iprice, p_oprice, io_inout, 
    DECODE(io_inout,'����',io_price,0) AS ���Դܰ�,
    decode(io_inout,'����',io_amt,0) AS ���Աݾ�,
    DECODE(io_inout,'����',io_price,0) AS ����ܰ�,
    DECODE(io_inout,'����',io_amt,0) AS ����ݾ�
from tbl_iolist IO
    left join tbl_product P
        on io.io_pcode = p.p_code
    left join tbl_buyer B
        on io.io_bcode = b.b_code
);

select * from view_iolist
where io_date between '2019-01-01' and '2019-01-31'
order by io_date;





