package dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Date;
import java.util.Properties;

/**
 * Lớp cha của mọi DAO: giữ một kết nối CSDL dùng chung cho toàn hệ thống.
 * Thông tin kết nối đọc từ file db.properties (nằm trong WEB-INF/classes).
 */
public abstract class DAO9 {

    protected static Connection con;
    private static Properties config;

    public DAO9() {
        try {
            if (config == null) {
                config = new Properties();
                try (InputStream in = DAO9.class.getResourceAsStream("/db.properties")) {
                    config.load(in);
                }
            }
            if (con == null || con.isClosed()) {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                con = DriverManager.getConnection(config.getProperty("db.url"),
                        config.getProperty("db.user"), config.getProperty("db.password"));
            }
        } catch (Exception e) {
            throw new RuntimeException("Không kết nối được CSDL: " + e.getMessage(), e);
        }
    }

    /**
     * Ngày hôm nay, dùng để xét phiếu mượn có quá hạn hay không.
     * Nếu db.properties có app.today=yyyy-MM-dd thì dùng ngày đó (để demo đúng kịch bản).
     */
    protected java.sql.Date getToday() {
        String today = config.getProperty("app.today", "").trim();
        if (today.isEmpty()) {
            return new java.sql.Date(System.currentTimeMillis());
        }
        return java.sql.Date.valueOf(today);
    }

    /** Trạng thái phiếu mượn, tính từ ngày hẹn trả và ngày trả thực tế. */
    protected String getSlipStatus(Date dueDate, Date returnDate) {
        if (returnDate == null) {
            return dueDate.before(getToday()) ? "Quá hạn" : "Đang mượn";
        }
        return returnDate.after(dueDate) ? "Đã trả quá hạn" : "Đã trả đúng hạn";
    }
}
