import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class ListServlet extends HttpServlet {

	private String _hostname = null;
	private String _dbname = null;
	private String _username = null;
	private String _password = null;

	public void init() throws ServletException {
		// iniファイルから自分のデータベース情報を読み込む
		String iniFilePath = getServletConfig().getServletContext()
				.getRealPath("WEB-INF/le4db.ini");
		try {
			FileInputStream fis = new FileInputStream(iniFilePath);
			Properties prop = new Properties();
			prop.load(fis);
			_hostname = prop.getProperty("hostname");
			_dbname = prop.getProperty("dbname");
			_username = prop.getProperty("username");
			_password = prop.getProperty("password");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		out.println("<html>");
		out.println("<body>");

		out.println("<h3>検索</h3>");
		out.println("<form action=\"search\" method=\"GET\">");
		out.println("レストラン名： ");
		out.println("<input type=\"text\" name=\"search_name\"/>");
		out.println("<br/>");
		out.println("<input type=\"submit\" value=\"検索\"/>");
		out.println("</form>");

		out.println("<h3>一覧</h3>");
		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection("jdbc:postgresql://" + _hostname
					+ ":5432/" + _dbname, _username, _password);
			stmt = conn.createStatement();

			out.println("<table border=\"1\">");
			out.println("<tr><th>レストランID</th><th>レストラン名</th><th>電話番号</th><th>住所</th></tr>");

			ResultSet rs = stmt.executeQuery("SELECT * FROM Restaurants");
			while (rs.next()) {
				int RestaurantID = rs.getInt("RestaurantID");
				String RestaurantName = rs.getString("RestaurantName");
				String PhoneNumber = rs.getString("PhoneNumber");
				String Address  = rs.getString("Address");


				out.println("<tr>");
				out.println("<td><a href=\"item?RestaurantID=" + RestaurantID + "\">" + RestaurantID
						+ "</a></td>");
				out.println("<td>" + RestaurantName + "</td>");
				out.println("<td>" + PhoneNumber + "</td>");
				out.println("<td>" + Address + "</td>");
				out.println("</tr>");
			}
			rs.close();

			out.println("</table>");

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

		out.println("<h3>追加</h3>");
		out.println("<form action=\"add\" method=\"GET\">");
		out.println("レストラン名： ");
		out.println("<input type=\"text\" name=\"add_RestaurantName\"/>");
		out.println("<br/>");
		out.println("電話番号： ");
		out.println("<input type=\"text\" name=\"add_Phonenumber\"/>");
		out.println("<br/>");
		out.println("住所： ");
		out.println("<input type=\"text\" name=\"add_Address\"/>");
		out.println("<br/>");
		out.println("<input type=\"submit\" value=\"追加\"/>");
		out.println("</form>");

		out.println("</body>");
		out.println("</html>");
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	public void destroy() {
	}

}
