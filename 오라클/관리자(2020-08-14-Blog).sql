--������ ȭ��


-- ��α׸� ���� ���̺� �����̽� ����
create tablespace blogTS
datafile 'C:/bizwork/oracle_dbms/blog.dbf'
size 1m AUTOEXTEND on next 1k; 

-- user1 ����� ����
create user user1 IDENTIFIED by user1
default tablespace blogTS;

--user1�� ���Ѻο�
grant dba to user1;



