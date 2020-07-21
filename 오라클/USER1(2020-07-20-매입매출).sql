-- user1 ȭ���Դϴ�

--------------------------------------------------------------------------------
-- ���� ���� ���� ������Ʈ
--------------------------------------------------------------------------------

-- 00 ȸ���� ���Ը��� ���� ������Ʈ�� �����ϰ� �ִ�. 
-- �� ȸ��� ������ ������ �̿��Ͽ� �ŷ�ó�� ���Ը��� ������ ������ �Դµ� �ֱ� App�� �����Ͽ�
-- �����ͺ��̽� ȭ �Ͽ� ������ �����Ϸ� �Ѵ�. 
-- ���� �����͸� �޾Ƽ� DB�� ������ ���� ��ȯ �۾��� �����ϰ� �ִ�. 

-- ���� ���Ը�������� DB�� ����� ���� ����, ������ �и��ϰ�, ��¥�� ���ڿ�ȭ �Ͽ���. 
-- �� �����͸� DB�� �����Ϸ��� �ô��� �� �����Ϳ� PKĮ������ ������ ���� Į���� ã�� �� �� ����. 
-- �̷��� ���(Work DB) ���� ���� �����Ϳ� ������ ������ PK Į���� �����Ͽ� ���� ���ִ� ���� ����. 

--------------------------------------------------------------------------------
-- ���Ը��� ���� ���̺�
--------------------------------------------------------------------------------
CREATE TABLE tbl_iolist(
        io_seq	NUMBER		PRIMARY KEY,
        io_date	VARCHAR2(10)	NOT NULL,	
        io_pname	nVARCHAR2(125)	NOT NULL,	
        io_dname	nVARCHAR2(125)	NOT NULL,	
        io_dceo	nVARCHAR2(125)	NOT NULL,
        io_inout	nVARCHAR2(2)	NOT NULL,	
        io_qty	NUMBER		DEFAULT 0,
        io_price	NUMBER		DEFAULT 0,
        io_amt	NUMBER		DEFAULT 0

);

-- ��ü ������ ����
SELECT COUNT(*) FROM tbl_iolist;

-- ���԰� ����� �����Ͽ� ���� ����
SELECT io_inout, COUNT(*) FROM tbl_iolist
GROUP BY io_inout;

-- ���Ե����͸� ���� ���� �� 
SELECT * FROM tbl_iolist
WHERE io_inout = '����';

SELECT * FROM tbl_iolist
WHERE io_inout = '����';

-- �ŷ� ������ 90�� �̻��� �����͸� ������� ��
SELECT * FROM tbl_iolist
WHERE io_qty >=90;

-- �����͸� Ȯ���ϴ� �ô��� �ܰ��� �ݾ��� 0�� �����Ͱ� ���δ�!
SELECT * FROM tbl_iolist
WHERE io_price =0 OR io_amt =0;

--���Ͻ�, 7+8ĩ��, �������
-- �� 3���� �����Ͱ� �ŷ��� 5�� 10�� 28�� �Ϸù�ȣ�� �����Ͱ� Į������ 0�̴�
-- �� �������� �ܰ�, �ݾ��� �����ϱ� ���� ������ ��ǰ �����Ͱ� �ִ��� Ȯ���۾��� ��ģ��.
SELECT * FROM tbl_iolist
WHERE io_pname IN ('���Ͻ�', '7+8ĩ��', '�������');

-- �˻��� �� ���Ҵ��� �� 3���� ��ǰ�� �ŷ� ������ �����̴�.
-- �ٸ� ������ ã�Ƽ� ���� �Է��ؾ� �� ���̴�. 
-- Ʃ�Ͻ� : 1000, ĩ�� : 2500, ������� : 4500 ���� ��������

-- ���Ͻ� �ŷ� ������ �ܰ�, �ݾ� �����ϱ� 
-- WHERE io_pname ='���Ͻ�';�� ���� set�ϸ� Ȥ�� �ٸ� ����, ���ⵥ���Ͱ� ���� ��� ������ ������ ����ų �� �ִ�.
-- �ݵ�� PK Į������ ��ȸ�ϰ� PK Į������ where���� ������� 
UPDATE tbl_iolist
SET io_price = 1000, --�ܰ�
    io_amt = io_qty * 1000 --�ݾ�(����*�ܰ�)
WHERE io_seq = 5; --io_pname ���Ͻ��� �ؼ� �ٲ۴ٸ�?? ����/���� ���� ���� �ܰ� �ٸ� ���� �ֱ� ������
-- PK�� �������� SET ���ش�.


UPDATE tbl_iolist
SET io_price = 2500, --�ܰ�
    io_amt = io_qty * 2500 --�ݾ�(����*�ܰ�)
WHERE io_seq = 10; --io_pname ���Ͻ��� �ؼ� �ٲ۴ٸ�?? ����/���� ���� ���� �ܰ� �ٸ� ���� �ֱ� ������


UPDATE tbl_iolist
SET io_price = 4500, --�ܰ�
    io_amt = io_qty * 4500 --�ݾ�(����*�ܰ�)
WHERE io_seq = 28; --io_pname ���Ͻ��� �ؼ� �ٲ۴ٸ�?? ����/���� ���� ���� �ܰ� �ٸ� ���� �ֱ� ������

SELECT * FROM tbl_iolist
WHERE io_price =0 OR io_amt =0;

-- ����������
--      ����, ���Դܰ�, ����ܰ�, ���Աݾ�, ����ݾ����� Į���� �и��Ͽ� ����ؿԴ�. 
--      �̷��� ������ �����ʹ� �� Į���� NULL���� �����Ͽ�, �پ��� ������ ������ �� ������ ����ų �� �ִ�. 
-- ��ȯ�� ������
--      ����, �ܰ�, �ݾ� �������� Į���� �����۾� �����ߴ�. 
--      Į������ �и��� ������ ���� Į������ �����ϰ� �����͸� �����ϴ� ���� ���������� �� 3����ȭ��� �Ѵ�. 

-- ��ȯ�� �����͸� �����Ͽ�
--      ����, ������ �����Ͽ� ������� ��� 
--      (�ŷ�ó  ����, ���Դ� ��, ���Աݾ�, ����ܰ�, ����ݾ� �������� ���� ���� ��)
--      �� �����ʹ� �ǹ� ���·� ��ȯ�ؾ� �Ѵ�. 


SELECT * FROM tbl_iolist
WHERE (io_seq >0 AND io_seq <=10) OR (io_seq >=300 AND io_seq <=310)
ORDER BY io_dname;



SELECT io_dname, io_inout, io_qty, io_price, io_amt FROM tbl_iolist
--WHERE (io_seq >0 AND io_seq <=10) OR (io_seq >=300 AND io_seq <=310)
ORDER BY io_dname;

-- PIVOT ���� ������ ���ĺ��� ��� �Ѵ�. 
-- ���� ����ܰ� �� �ܰ�(io_price) Į���� ���� ����Ǿ� �ִ�.
-- �� ���� io_inout Į���� ���� �𸣸� �������� �������� ������ ��ƴ�.
-- ���� �Ź� io_inout Į���� ���� ǥ���ؾ߸� �������� �������� ������ �� �ִ�. 
-- �׷��� ������ �������ؼ� io_inout Į���� ���� �������� �ϴ� DECODE �Լ��� ����Ͽ� 
-- �ܰ� �κ��� ���Դܰ�, ����ܰ��� �и��Ͽ� �����ֵ��� ������ �ۼ��Ͽ���.

-- ���� io_inout Į���� ���� ���� ���� �����Ͱ� ���Ե��������� ���ⵥ�������� �˱� ���� �Ǿ���. 

SELECT io_dname, io_inout, io_qty, 

    -- ���Դܰ�(�������� ������ Į��) Į���� �����͸� �����ִµ�,
    --- ���� io_inout Į���� ���� '����'�̸� io_price Į���� ���� ǥ���ϰ�
    -- �׷��� ������ 0���� ǥ���϶�
    DECODE(io_inout, '����',io_price,0) AS ���Դܰ�,
    DECODE(io_inout, '����',io_price,0) AS ����ܰ�,
    DECODE(io_inout, '����', io_amt,0) AS �����հ�,
    DECODE(io_inout, '����', io_amt,0) AS �����հ�
    
FROM tbl_iolist
WHERE (io_seq >0 AND io_seq <=10) OR (io_seq >=300 AND io_seq <=310)
ORDER BY io_dname;





-- "�ŷ�ó����" ���԰� ������ �����Ͽ� �� �� �ִ� ������ �ϼ��ߴ�.
-- �ŷ�ó���� ���԰� ������ �հ踦 ����� ���� �ʹ�. 
-- �� ������(1�Ⱓ �ŷ�����)���� �ŷ�ó���� �� ���Աݾ�, �� ����ݾ��� ����غ��� �ʹ�. 

-- 1. �ŷ�ó�� �ŷ������� ������ �ݺ� �̷�� �����Ƿ� �ŷ�ó���� ������ ��Ÿ�� ���̴�. 
--     �� �����͸� �ŷ�ó���� �����־�� �Ѵ�. 
--     GROUP BY io_dname
-- 2. ��ü ����ݾװ� ���Աݾ��� ǥ���ϴ� ����Į��(����ݾ�, ���Աݾ��� �����)�� ����Լ��� �����ش�. 

SELECT io_dname,

    SUM(DECODE(io_inout, '����', io_amt,0)) AS �����հ�,
    SUM(DECODE(io_inout, '����', io_amt,0)) AS �����հ�
    
FROM tbl_iolist
--WHERE (io_seq >0 AND io_seq <=10) OR (io_seq >=300 AND io_seq <=310)
GROUP BY io_dname
ORDER BY io_dname;


-- ���� �ŷ�ó���� �����հ�� �����հ踦 ��������
-- �� �ŷ�ó���� �󸶸�ŭ�� ������ ������� ���캸��!
-- ���ͱ� : �����հ�-�����հ�� �����Ѵ�. 
SELECT io_dname,

    SUM(DECODE(io_inout, '����', io_amt,0)) AS �����հ�,
    SUM(DECODE(io_inout, '����', io_amt,0)) AS �����հ�,
    SUM(DECODE(io_inout, '����', io_amt,0)) - SUM(DECODE(io_inout, '����', io_amt,0)) AS ���ͱ�
    
FROM tbl_iolist
--WHERE (io_seq >0 AND io_seq <=10) OR (io_seq >=300 AND io_seq <=310)
GROUP BY io_dname
ORDER BY io_dname;



-- 00ȸ�翡�� 2019�� 1�⵿�� �� ����, �Ѹ���, �� ������ �󸶳� �߻��ߴ��� �˰�ʹ�.
 
SELECT 
    SUM(DECODE(io_inout, '����', io_amt,0)) AS �����հ�,
    SUM(DECODE(io_inout, '����', io_amt,0)) AS �����հ�,
    SUM(DECODE(io_inout, '����', io_amt,0)) - SUM(DECODE(io_inout, '����', io_amt,0)) AS ���ͱ�
    
FROM tbl_iolist
--WHERE (io_seq >0 AND io_seq <=10) OR (io_seq >=300 AND io_seq <=310) 
ORDER BY io_dname;



















