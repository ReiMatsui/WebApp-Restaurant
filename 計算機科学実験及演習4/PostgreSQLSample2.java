import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class PostgreSQLSample2 {

	public static void main(String[] args) throws SQLException {
		String hostname = "localhost"; // 自分のものに書き換える
		String dbname = "postgres"; // 自分のものに書き換える
		String username = "postgres"; // 自分のものに書き換える
		String password = "123456789"; // 自分のものに書き換える
		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection("jdbc:postgresql://" + hostname
					+ ":5432/" + dbname, username, password);
			System.out.println("接続成功");

			stmt = conn.createStatement();
			stmt.executeUpdate("CREATE TABLE products (pid INTEGER, name VARCHAR(20), price INTEGER, PRIMARY KEY (pid))");
			System.out.println("テーブル作成");

			stmt.executeUpdate("INSERT INTO products VALUES(1, 'AAA', 100)");
			stmt.executeUpdate("INSERT INTO products VALUES(2, 'BBB', 80)");
			stmt.executeUpdate("INSERT INTO products VALUES(3, 'CCC', 220)");
			System.out.println("データ挿入");

			ResultSet rs = stmt
					.executeQuery("SELECT * FROM products WHERE price >= 100");
			System.out.println("選択");
			while (rs.next()) {
				int pid = rs.getInt("pid");
				String name = rs.getString("name");
				int price = rs.getInt("price");
				System.out.println(pid + "\t" + name + "\t" + price);
			}
			rs.close();

			stmt.executeUpdate("DROP TABLE products");
			System.out.println("テーブル削除");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (stmt != null) {
					stmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}

