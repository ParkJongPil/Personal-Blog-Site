package conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GetConn {
	private Connection conn = null;
	private PreparedStatement pstmt=null;
	private ResultSet rs =null;
	
	private String driver = "com.mysql.jdbc.Driver";
	private String url = "jdbc:mysql://localhost:3306/javagreen_pjp";
	private String user = "root";
	private String password ="1234";
	
	private static GetConn instance = new GetConn();
	
	private GetConn() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패~~");
		} catch (SQLException e) {
			System.out.println("DB연동 실패~~");
			e.printStackTrace();
		}
	}

	public Connection getConn() {
		return conn;
	}

	public static GetConn getInstance() {
		return instance;
	}
	
	public void pstmtClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {}
		}
	}
	public void rsClose() {
		if(pstmt !=null) {
		try {
			rs.close();
		} catch (SQLException e) {
		}
	}
}
}
