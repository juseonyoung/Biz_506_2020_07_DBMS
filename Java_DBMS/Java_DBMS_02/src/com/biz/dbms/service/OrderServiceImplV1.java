package com.biz.dbms.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.biz.dbms.config.DBConnection;
import com.biz.dbms.config.DBContract;
import com.biz.dbms.config.DBContract.ORDER;
import com.biz.dbms.domain.OrderVO;

public class OrderServiceImplV1 implements OrderService {

	DBContract.ORDER dBOrder;

	// 오라클과 연결할 통로 Connection 객체
	protected Connection dbConn;

	public OrderServiceImplV1() {
		this.dbConn = DBConnection.getDBConnection(); // 필드변수 선언
	}

	// throws SQLException
	// try-catch를 사용하여 자체적으로 exception을 handling을 하였는데
	// try-catch가 코드 내에 많아지면 코드 가독성이 매우 떨어진다.

	// 그런 경우 exception 처리를 직접 하지 않고 이 메서드를 호출 한 곳에
	// 대리 요청한다(exception을 던진다 라고 표현함)

	// insert를 호출하는 곳에서는 ordervo에 주문정보 데이터를 담고
	// 매개변수로 전달해야 하며 try-catch로 exception 처리를 하고
	// 결과값으로 정수값을 받아 insert유무를 처리해야 한다.
	@Override
	public int insert(OrderVO orderVO) throws SQLException {

		String sql = DBContract.ORDER_INSERT;
		PreparedStatement pSt = this.dbConn.prepareStatement(sql);

		// VO를 통해서 전달받은 데이터를 SQL명령문과 합성하기
		pSt.setString(1, orderVO.getO_num());
		pSt.setString(2, orderVO.getO_date());
		pSt.setString(3, orderVO.getO_cnum());
		pSt.setString(4, orderVO.getO_pcode());
		pSt.setInt(5, orderVO.getO_price());
		pSt.setInt(6, orderVO.getO_qty());

		int ret = pSt.executeUpdate();

		return ret;
	}

	// selectAll() method를 호출하는 곳에서는 아무런 매개변수 없이 method를 호출하고
	// exception처리를 수행해야 하며 return값으로 List<OrderVO> 형 변수에 받아서 처리한다.

	@Override
	public List<OrderVO> selectAll() throws SQLException {
		// TODO Auto-generated method stub

		List<OrderVO> orderList = new ArrayList<>();

		String sql = DBContract.ORDER_SELECT_ALL;
		PreparedStatement pSt = dbConn.prepareStatement(sql);

		ResultSet rSet = pSt.executeQuery();

		while (rSet.next()) {

			OrderVO orderVO = this.setOrderVO(rSet);
			orderList.add(orderVO);

		}
		pSt.close();
		return orderList;
	}

	// selectAll()과 findbyseq() method에서 resultset으로부터 데이터를 getter 하여
	// orderVO에 setter하는 부분을 별도 method로 분리하고 selectAll()과 findbyseq()에서
	// 호출하여 사용할 수 있도록 구현한다.

	private OrderVO setOrderVO(ResultSet rSet) throws SQLException {
		OrderVO orderVO = new OrderVO();
		// 문자열.trim() 문자열 앞과 뒤에 있는 공백을 제거하는 메서드
		orderVO.setO_seq(rSet.getLong(DBContract.ORDER.COL_O_SEQ_LONG.trim()));
		orderVO.setO_num(rSet.getNString(DBContract.ORDER.COL_O_NUM_STR.trim()));
		orderVO.setO_date(rSet.getNString(DBContract.ORDER.COL_O_DATE_STR.trim()));

		orderVO.setO_cnum(rSet.getNString(DBContract.ORDER.COL_O_CNUM_STR.trim()));
		orderVO.setO_pcode(rSet.getNString(DBContract.ORDER.COL_O_PCODE_STR.trim()));
		orderVO.setO_price(rSet.getInt(DBContract.ORDER.COL_O_PRICE_INT.trim()));
		orderVO.setO_qty(rSet.getInt(DBContract.ORDER.COL_O_QTY_INT.trim()));

		orderVO.setO_total(orderVO.getO_price() * orderVO.getO_qty());

		return orderVO;
	}

	@Override
	public OrderVO findBySeq(long seq) throws SQLException {

		String sql = DBContract.ORDER_FIND_BY_SEQ;

		PreparedStatement pSt = dbConn.prepareStatement(sql);
		pSt.setLong(1, seq);

		// rSet 에 담기게 될 테이블의 데이터는 단 1개의 데이터만 담기거나, 없는 상태가 된다.
		ResultSet rSet = pSt.executeQuery();

		if (rSet.next()) {

			OrderVO orderVO = this.setOrderVO(rSet);
			return orderVO;
		}
		return null;
	}

	@Override
	public int update(OrderVO orderVO) throws SQLException {
		String sql = DBContract.ORDER_UPDATE;
		
		PreparedStatement pSt = dbConn.prepareStatement(sql);
		
		pSt.setString(1,orderVO.getO_num());
		pSt.setString(2,orderVO.getO_date());
		pSt.setString(3,orderVO.getO_cnum()); 
		pSt.setString(4, orderVO.getO_pcode());
		pSt.setInt(5,orderVO.getO_price());
		pSt.setInt(6,orderVO.getO_qty());
		pSt.setLong(7,orderVO.getO_seq());
		
		int ret = pSt.executeUpdate();
		return ret;
		}

	@Override
	public int delete(long seq) throws SQLException {
		
		String sql = DBContract.ORDER_DELETE;
		PreparedStatement pSt = dbConn.prepareStatement(sql);
		
		pSt.setLong(1, seq);
		int ret =pSt.executeUpdate();
		return ret;
	}

}
