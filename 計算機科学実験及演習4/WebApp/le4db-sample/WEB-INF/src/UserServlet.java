import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.text.DecimalFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class UserServlet extends HttpServlet {

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
		
		String UserName = request.getParameter("UserName");

		out.println("<html>");
		out.println("<body>");
		Connection conn = null;
		Statement stmt = null;
		out.println("<h3>ユーザー情報</h3>");
		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection("jdbc:postgresql://" + _hostname
					+ ":5432/" + _dbname, _username, _password);
			stmt = conn.createStatement();
			out.println("<table border=\"1\">");
			out.println("<tr><th>ユーザー名</th><th>レビュー数</th><th>電話番号</th></tr>");

			ResultSet rs2 = stmt.executeQuery("SELECT * FROM Users WHERE UserName = '" + UserName + "'");
			while (rs2.next()) {
				String PhoneNumber= rs2.getString("PhoneNumber");
				String ReviewCount= rs2.getString("ReviewCount");

				out.println("<tr>");
				out.println("<td>" + UserName + "</td>");
				out.println("<td>" + ReviewCount + "</td>");
				out.println("<td>" + PhoneNumber + "</td>");
				out.println("</tr>");
			}
			rs2.close();
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

		out.println("<h3>評価一覧</h3>");

		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection("jdbc:postgresql://" + _hostname
					+ ":5432/" + _dbname, _username, _password);
			stmt = conn.createStatement();

			out.println("<table border=\"1\">");
			out.println("<tr><th>レストランID</th><th>レストラン名</th><th>評価</th><th>割引率</th></tr>");

			ResultSet rs1 = stmt.executeQuery("SELECT * FROM Restaurants NATURAL JOIN RatingsDiscounts WHERE UserName = '" + UserName + "'");
			while (rs1.next()) {
				String RestaurantID = rs1.getString("RestaurantID");
				String RestaurantName = rs1.getString("RestaurantName");
				String Rating  = rs1.getString("Rating");
				String DiscountRate  = rs1.getString("DiscountRate");

				out.println("<tr>");
				out.println("<td><a href=\"item?RestaurantID=" + RestaurantID + "\">" + RestaurantID
						+ "</a></td>");
				out.println("<td>" + RestaurantName + "</td>");
				out.println("<td>" + Rating + "</td>");
				out.println("<td>" + DiscountRate + "</td>");
				out.println("</tr>");
			}
			rs1.close();

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


		out.println("<h3>更新</h3>");
		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection("jdbc:postgresql://" + _hostname
					+ ":5432/" + _dbname, _username, _password);
			stmt = conn.createStatement();

			out.println("<form action=\"update\" method=\"GET\">");
			out.println("ユーザー名： " + UserName);
			out.println("<input type=\"hidden\" name=\"update_pid\" + value=\"" + UserName + "\"/>");
			out.println("<br/>");
			
			ResultSet rs = stmt.executeQuery("SELECT * FROM Users WHERE UserName = '" + UserName + "'");
			while (rs.next()) {
				String PhoneNumber = rs.getString("PhoneNumber");
				

				out.println("電話番号： ");
				out.println("<input type=\"text\" name=\"update_price\" value=\"" + PhoneNumber + "\"/>");
				out.println("<br/>");
			}
			rs.close();
			
			out.println("<input type=\"submit\" value=\"更新\"/>");
			out.println("</form>");

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

		out.println("<h3>削除</h3>");
		out.println("<form action=\"delete\" method=\"GET\">");
		out.println("<input type=\"hidden\" name=\"delete_UserName\" value=\"" + UserName + "\">");
		out.println("<input type=\"submit\" value=\"削除\"/>");
		out.println("</form>");

		out.println("<br/>");
		out.println("<a href=\"list\">トップページに戻る</a>");

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
