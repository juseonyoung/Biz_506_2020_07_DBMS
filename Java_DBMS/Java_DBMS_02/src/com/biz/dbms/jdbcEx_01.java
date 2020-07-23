package com.biz.dbms;

import java.sql.SQLException;

import com.biz.dbms.domain.OrderVO;
import com.biz.dbms.service.OrderService;
import com.biz.dbms.service.OrderServiceImplV1;

public class jdbcEx_01 {

	public static void main(String[] args) {
	
		OrderService orderService = new OrderServiceImplV1();
		
		OrderVO orderVO = new OrderVO();
		
		orderVO.setO_num("O00055");
		orderVO.setO_date("2020-07-23");
		orderVO.setO_cnum("C0012");
		orderVO.setO_pcode("P0003"); //pk
		orderVO.setO_price(3000);
		orderVO.setO_qty(10);
	
		int ret=0;
		try {
			ret = orderService.insert(orderVO);
			if(ret>0) {
				System.out.println("데이터 추가가 정상적으로 수행!");
			}else {
				// sql 등에는 아무런 문제가 없는데 insert가 수행되고도 데이터가 추가되지않았을 때
				
				System.out.println("데이터 추가할 수 없음");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			// oracle DBMS에서 오류를 보내왔을 때 
			System.out.println("SQL 전달과정에서 오류 발생");
			e.printStackTrace();
		}
	}
}
