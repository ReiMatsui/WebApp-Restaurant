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
public class ItemServlet extends HttpServlet {

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
		
		String RestaurantID = request.getParameter("RestaurantID");

		out.println("<html>");
		out.println("<body>");
		Connection conn = null;
		Statement stmt = null;
		out.println("<h3>総合評価</h3>");
		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection("jdbc:postgresql://" + _hostname
					+ ":5432/" + _dbname, _username, _password);
			stmt = conn.createStatement();
			out.println("<table border=\"1\">");
			out.println("<tr><th>レストラン名</th><th>総合評価</th></tr>");

			ResultSet rs2 = stmt.executeQuery("SELECT AVG(RatingsDiscounts.Rating) AS AvgRating, Restaurants.RestaurantName FROM RatingsDiscounts JOIN Restaurants ON RatingsDiscounts.RestaurantID = Restaurants.RestaurantID WHERE Restaurants.RestaurantID = " + RestaurantID + " GROUP BY Restaurants.RestaurantName");
			while (rs2.next()) {
				String RestaurantName = rs2.getString("RestaurantName");
				String AvgRating = rs2.getString("AvgRating");
				
				double avgRating = Double.parseDouble(AvgRating);

				DecimalFormat df = new DecimalFormat("#.###");
				avgRating = Double.parseDouble(df.format(avgRating));

				out.println("<tr>");
				out.println("<td>" + RestaurantName + "</td>");
				out.println("<td>" + avgRating + "</td>");
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
			out.println("<tr><th>ユーザー名</th><th>評価</th><th>割引率</th></tr>");

			ResultSet rs1 = stmt.executeQuery("SELECT * FROM Restaurants INNER JOIN RatingsDiscounts ON Restaurants.RestaurantID = RatingsDiscounts.RestaurantID WHERE Restaurants.RestaurantID = " + RestaurantID );
			while (rs1.next()) {
				String UserName = rs1.getString("UserName");
				String Rating  = rs1.getString("Rating");
				String DiscountRate  = rs1.getString("DiscountRate");

				out.println("<tr>");
				out.println("<td><a href=\"user?UserName=" + UserName+ "\">" + UserName
						+ "</a></td>");
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
			out.println("レストランID： " + RestaurantID);
			out.println("<input type=\"hidden\" name=\"update_pid\" + value=\"" + RestaurantID + "\"/>");
			out.println("<br/>");
			
			ResultSet rs = stmt.executeQuery("SELECT * FROM Restaurants WHERE RestaurantID = " + RestaurantID);
			while (rs.next()) {
				String RestaurantName = rs.getString("RestaurantName");
				String PhoneNumber = rs.getString("PhoneNumber");
				String Address = rs.getString("Address");
				
				out.println("レストラン名： ");
				out.println("<input type=\"text\" name=\"update_name\" value=\"" + RestaurantName + "\"/>");
				out.println("<br/>");
				out.println("電話番号： ");
				out.println("<input type=\"text\" name=\"update_price\" value=\"" + PhoneNumber + "\"/>");
				out.println("<br/>");
				out.println("住所： ");
				out.println("<input type=\"text\" name=\"update_price\" value=\"" + Address + "\"/>");
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
		out.println("<input type=\"hidden\" name=\"delete_RestaurantID\" value=\"" + RestaurantID + "\">");
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
