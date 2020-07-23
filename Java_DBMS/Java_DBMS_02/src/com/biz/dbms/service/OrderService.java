package com.biz.dbms.service;

import java.sql.SQLException;
import java.util.List;

import com.biz.dbms.domain.OrderVO;

public interface OrderService {

	// Java에서 DBMS와 관련된 App만들 때 최소한으로 구현해야 할 method
	public int insert(OrderVO orderVO)throws SQLException; //orderVO에 값을 담아서 전달받아 insert 수행
	
	public  List<OrderVO> selectAll() throws SQLException; // 조건에 관계없이 모든 데이터를 추출하여 return 하는 메시지
	public OrderVO findBySeq(long seq)throws SQLException; // findById(), PK칼럼을 기준으로 데이터를 select
	// pk값 받으ㄹㅕ면 매개변수 이용
	
	public int update(OrderVO orderVO)throws SQLException; //vo에 담겨있는 변수를 update에게 보내 수행
	public int delete(long seq)throws SQLException; //pk가 설정된 타입쓰고 변수
	
	// where pk 조건으로 할 때 1개 아니면 0의 값이 나오므로 리스트가 아닌 vo 타입
	// select from 은 리스트 타입 
	
}
