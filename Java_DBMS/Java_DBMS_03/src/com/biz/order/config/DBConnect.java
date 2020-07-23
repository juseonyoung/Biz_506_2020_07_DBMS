package com.biz.order.config;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class DBConnect {

	private static String configFile;
	private static SqlSessionFactory sqlSessionFactory;

	static {

		configFile = "com/biz/order/config/mybatis-context.xml";
		InputStream inputStream = null;

		try {
			inputStream = Resources.getResourceAsStream(configFile);

			SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder(); // 팩토리 공장........

			if (sqlSessionFactory == null) { // 아직 공장이 없으면
				sqlSessionFactory = builder.build(inputStream); // inputStream설계도 이용하여 공장 지어라..

			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	
	public static SqlSessionFactory getSqlSessionFactory() {
		
		return sqlSessionFactory;
	}
	
	
}
