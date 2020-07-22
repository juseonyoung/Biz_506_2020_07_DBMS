-- ����� user2 ȭ���Դϴ�


-- �ֹ���ȣ,   ����ȣ,    ��ǰ�ڵ�   ����͵� PK�� ������ �� ���� ����/ Į���߰��ϱ�
-- O00001       C0032       P00001
-- O00001       C0032       P00002
-- O00001       C0032       P00003


select * from tbl_�ֹ�������;


-----------------------------------------------
-- �ֹ��� ����
-----------------------------------------------
create table tbl_order(
        O_SEQ	NUMBER		PRIMARY KEY,
        O_NUM	CHAR(6)	NOT NULL,	
        O_DATE	CHAR(10)	NOT NULL,	
        O_CNUM	CHAR(5)	NOT NULL,	
        O_PCODE	ChAR(6)	NOT NULL,	
        O_PNAME	nVARCHAR2(125),		
        O_PRICE	NUMBER,		
        O_QTY	NUMBER,		
        O_TOTAL	NUMBER		
);



-- tbl_order table�� ���� ���⿡ �߰��� �����͵� �߿� 1���� Į�����δ� pk�� ���� �� ���
-- ������ �Ϸù�ȣ Į���� �ϳ� �߰��ϰ� �� Į���� PK�� �����Ͽ���. 
-- �� ��Ȳ�� �Ǹ� �����͸� �߰��� �� ������ O_SEQ Į���� ����� �����͵��� ���캸��
-- ��ϵ��� ���� ���ڸ� ������� �� ������ SEQ�� ���ϰ� insert�� �����ؾ� �Ѵ�. 
-- �̷������ �ڵ带 �ſ� �����ϰ� ����� ����� �ʷ��Ѵ�. 


-- �̷��� ������ �����ϱ� ���� SEQUENCE ��� ��ü�� ����Ͽ�, �ڵ����� �Ϸù�ȣ�� ����� ����� ����Ѵ�. 

create sequence seq_order
start with 1 increment by 1;


-- ǥ�� SQL���� ������ ����� �� �� 
-- select 3 + 4; ��� �ڵ��� �ϸ� 3+4�� ����� Ȯ���� �� �ִ�. 
-- �׷��� ����Ŭ������ select ��ɹ��� from [table] ���� ������ ���������� ����. 
-- �̷��� �ڵ尡 �ʿ��� �� �ý��ۿ� �̹� �غ�Ǿ� �ִ� dual�̶�� dummy ���̺��� ����ؼ� �ڵ��Ѵ�. 
select 3+4 from dual;

-- seq_order ��ü�� NEXTVAL �̶�� ���(�Լ�����)�� ȣ���Ͽ� ��ȭ�Ǵ� �Ϸù�ȣ�� �����޶�
select seq_order.nextval from dual;

-- �� seq_order�� nextval ����� ����Ͽ� insert ������ �� �Ϸù�ȣ�� �ڵ����� �ο��� �� �ִ�. 


-- �ֹ���ȣ,   ����ȣ,    ��ǰ�ڵ�
-- O00001       C0032       P00001
-- O00001       C0032       P00002
-- O00001       C0032       P00003
drop table tbl_order;

insert into tbl_order(o_seq,O_date,o_num, o_cnum, o_pcode) values (seq_order.nextval,'2020-07-22','O00001', 'C0032', 'P00001');
insert into tbl_order(o_seq,O_date,o_num, o_cnum, o_pcode) values (seq_order.nextval,'2020-07-22','O00001', 'C0032', 'P00002');
insert into tbl_order(o_seq,O_date,o_num, o_cnum, o_pcode) values (seq_order.nextval,'2020-07-22','O00001', 'C0032', 'P00003');

-- ���� tbl_order ���̺� ���� ���� �����Ͱ� ���� �� 
-- O00001      C0031      P00001 �� ���� �����͸� �߰��Ѵٸ� �ƹ��� ������� ���� �߰��Ǿ� ���� ���̴�. 
-- �ߺ��� �ȵǵ��� unique

select o_num, o_cnum,o_pcode from tbl_order;

-- �ֹ���ȣ, ����ȣ, ��ǰ�ڵ� �� 3���� Į�� ������ ���� �ߺ��Ǹ� insert�� ���� �ʵ��� ���������� �����ؾ� �Ѵ�. 
-- unique : Į���� ���� �ߺ��Ǿ insert �� �Ǵ� ���� �����ϴ� ��������
-- �ֹ����̺� unique ���������� �߰�����

alter table tbl_order 
    add constraint uq_order 
        unique (o_num, o_cnum, o_pcode);
        
        
-- unique�� �߰��ϴµ� �̹� unique ���ǿ� ����Ǵ� ���� ������ ���������� �߰����� �ʴ´�. 
-- duplicate keys found : 
-- PK, unique�� ������ Į���� ���� �߰��ϰų� �Ǵ� �̹� �ߺ��� ���� �ִµ� pk�� unique�� �����Ϸ� ���� �� ��Ÿ���� ����
-- �������� �߰��� ���� delete���ֱ�
-- unique ���������� �߰��ϱ� ���� �������� �߰��� �����͸� �����Ϸ��� ������ ���� SQL�� �����Ѵ�. 
-- �� SQL�� �����ϸ�, �����Ǿ�� �ȵǴ� �߿��� �ֹ����� 1���� ���� �����Ǿ� ���� ���̴�. 
-- �� table�� �����ʹ� ���Ἲ�� �Ұ� �ȴ�. => �����̻�

delete from tbl_order
    where o_num = 'O00001' AND o_cnum='C0032' AND o_pcode = 'P00001';

-- ������ �Ϸù�ȣ Į���� ������� �ֱ� ������ PK�� �������� ���� ������ �� �ִ�. 
select * from tbl_order;

delete from tbl_order
    where o_seq = 64; --�̷�������;;;


-- �ĺ�Ű �߿� ����Į������ pk�� ������ �� ���� ��Ȳ�� �߻��ϸ� ������ Į������ pk�� �����ϴµ�
-- update, delete�� ������ �� where Į��1 = �� and Į��2 = �� and Į��3 = ��... ������ ������ �ο��ؾ� �Ѵ�. 
-- �̰��� ������ ���Ἲ�� �����ϴ� �� �ſ� ���� ���� ȯ���̴�. 
-- �̷� �� �����Ϳ� ������� seq Į���� ����� pk�� �������� 

select * from tbl_order;



insert into tbl_order(o_seq,O_date,o_num, o_cnum, o_pcode)
values (seq_order.nextval,'2020-07-22','O00022', 'C0055', 'P00067');
commit;





