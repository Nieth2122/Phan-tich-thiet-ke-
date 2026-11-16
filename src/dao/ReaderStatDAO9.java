package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.ReaderStat9;

/** Thống kê độc giả theo lượt mượn (Module 2). */
public class ReaderStatDAO9 extends DAO9 {

    public ReaderStatDAO9() {
        super();
    }

    /**
     * Mỗi độc giả có phiếu mượn với ngày mượn trong [fromDate, toDate]:
     * loanCount = số phiếu đó; loanStatus = Quá hạn / Đang mượn / Đã trả hết.
     * Sắp xếp theo số lần mượn giảm dần.
     */
    public List<ReaderStat9> getReaderStat(Date fromDate, Date toDate) {
        String sql = "SELECT m.id, m.fullName, m.phone, r.readerCode, r.readerType,"
                + " COUNT(*) AS loanCount,"
                + " SUM(CASE WHEN s.returnDate IS NULL AND s.dueDate < ? THEN 1 ELSE 0 END) AS overdueCount,"
                + " SUM(CASE WHEN s.returnDate IS NULL THEN 1 ELSE 0 END) AS borrowingCount"
                + " FROM tblBookLoanSlip s"
                + " JOIN tblReader r ON r.memberId = s.readerId"
                + " JOIN tblMember m ON m.id = r.memberId"
                + " WHERE s.createdDate BETWEEN ? AND ?"
                + " GROUP BY m.id, m.fullName, m.phone, r.readerCode, r.readerType"
                + " ORDER BY loanCount DESC, m.fullName";
        List<ReaderStat9> result = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, getToday());
            ps.setDate(2, fromDate);
            ps.setDate(3, toDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReaderStat9 r = new ReaderStat9();
                    r.setId(rs.getInt("id"));
                    r.setFullName(rs.getString("fullName"));
                    r.setPhone(rs.getString("phone"));
                    r.setReaderCode(rs.getString("readerCode"));
                    r.setReaderType(rs.getString("readerType"));
                    r.setLoanCount(rs.getInt("loanCount"));
                    if (rs.getInt("overdueCount") > 0) {
                        r.setLoanStatus("Quá hạn");
                    } else if (rs.getInt("borrowingCount") > 0) {
                        r.setLoanStatus("Đang mượn");
                    } else {
                        r.setLoanStatus("Đã trả hết");
                    }
                    result.add(r);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return result;
    }
}
