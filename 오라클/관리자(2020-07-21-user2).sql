-- ����� ������ ȭ���Դϴ�. 
-- ���ο� tablespace�� ����ڸ� ����ϱ�
--TableSpace user2Ts,
--user : user2, pw : user2
-- C:\bizwork\workspace\oracle_data

create tablespace user2Ts
datafile 'C:/bizwork/workspace/oracle_data/user2.dbf'
size 1m AUTOEXTEND on next 10k;

-- ���̺�� ������ ����� ���
create user user2 identified by user2
default tablespace user2Ts;

-- �������� ����ڿ��� ���� �ο�
grant dba to user2;

