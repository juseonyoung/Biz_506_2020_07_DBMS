drop table tbl_iolist;

create table tbl_iolist(
    	seq number primary key,
	io_date varchar2(10),
	 io_time varchar2(10),
	
	 io_input char(1),
	
	 io_pname nvarchar2(30) not null,
	
	 io_price number,
	 io_quan number,
	 io_total number,
     
     io_iprice number,
     io_oprice number,
     io_input_sum number,
     io_output_sum number
);

create sequence seq_iolist
start with 1 increment by 1;

commit;

drop table tbl_iolist;