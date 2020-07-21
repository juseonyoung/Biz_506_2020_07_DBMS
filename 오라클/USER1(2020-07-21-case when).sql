-- ����� user1 ȭ���Դϴ�


-- ǥ��SQL�� : case when ���ǹ� then true �϶� �� else false �϶� �� end
-- ����Ŭ : decode(Į��, ���ǰ�, true�� �� , false�� ��)
select io_bcode,
	sum(case when io_inout = '����' then io_amt else 0 end) AS �����հ�,
	sum(case when io_inout = '����' then io_amt else 0 end) AS �����հ�
from tbl_iolist
group by io_bcode;


-- ����Ŭ���� ���Ŀ� pk�� �����ϴ� ���!
-- ������ pk�� ������ �ߺ� �������� �ʴ´�. 
-- pk_iolist : ����Ŭ������ ���Ǵ� pk�� ã�� ����
-- Ȥ�� pk�� ������ ���� ���� �� �ʿ��� �̸�
alter table tbl_iolist add constraint PK_iolist primary key (io_seq, io_date);
alter table tbl_iolist drop primary key; 


create table tbl_test (
    t_seq number primary key,
    t_name nVARchar2(20)
);

-- ����Ŭ���� table�� auto_increment ������ ����.
-- ���� �Ϸù�ȣ�� ���� Į���� ����Ͽ� PK�� ����� ���� ���� ����� ����� ��Ȳ�� �ȴ�. 
-- insert�� ������ ������ ������ ����� �Ϸù�ȣ ���� ��ȸ�ϰ� +1�� �����Ͽ� �ٽ� insert�� �����ϴ� ���� �ݺ��ؾ� �ϱ� ����

-- ������ ����Ŭ���� sequence��� �ٸ� DBMS�� ���� Ư���� ��ü�� �ִ�. 
-- �� ��ü�� ��ü.nextval �̶�� Ư���� ȣ���ڰ� �ִµ� �� ȣ���ڸ� ȣ�� �� ������
-- select, insert ��� ���ο� ������ �ִ� �������� ������ ������ ��Ģ�� ���� �ڵ� �����Ͽ� �����ϰԵȴ�. 
-- �� ��ü.nextval �� ������ �ִ� ����
-- insert ������ �� pk�� seqĮ���� �����ϸ� auto_increment ȿ���� �� �� �ִ�. 

create sequence seq_test
start with 1 increment by 1; --����Ŭ�� auto ��ɾ�� �̷��� �� ���� ���۰�/ ȣ�� �� ������ �����ϴ� ��

insert into tbl_test(t_seq, t_name)
values (seq_test.nextval, 'ȫ�浿');

select * from tbl_test;