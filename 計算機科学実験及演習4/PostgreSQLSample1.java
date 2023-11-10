import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class PostgreSQLSample1 {

	public static void main(String[] args) throws SQLException {
		String hostname = "localhost"; // 自分のものに書き換える
		String dbname = "postgres"; // 自分のものに書き換える
		String username = "postgres"; // 自分のものに書き換える
		String password = "123456789"; // 自分のものに書き換える
		Connection conn = null;
		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection("jdbc:postgresql://" + hostname
					+ ":5432/" + dbname, username, password);
			System.out.println("接続成功");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}

