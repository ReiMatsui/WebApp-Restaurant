import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SQLiteSample1 {

	public static void main(String[] args) throws SQLException {
		String dbname = "task.sqlite"; // 利用するデータベースファイル
		Connection conn = null;
		try {
			Class.forName("org.sqlite.JDBC");
			conn = DriverManager.getConnection("jdbc:sqlite:" + dbname);
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
