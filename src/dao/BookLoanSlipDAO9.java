package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.BookLoanSlip9;
import model.DetailBookLoan9;
import model.Document9;
import model.Reader9;
import model.Staff9;

/** Truy cập dữ liệu phiếu mượn (dùng ở cả Module 1 và Module 2). */
public class BookLoanSlipDAO9 extends DAO9 {

    public BookLoanSlipDAO9() {
        super();
    }

    /** Module 1: limit phiếu mượn gần nhất có chứa tài liệu, xếp theo ngày mượn tăng dần. */
    public List<BookLoanSlip9> getLoanHistoryOfDocument(int documentId, int limit) {
        String sql = "SELECT * FROM ("
                + "   SELECT TOP (?) s.* FROM tblBookLoanSlip s"
                + "   WHERE EXISTS (SELECT 1 FROM tblDetailBookLoan dl"
                + "                 WHERE dl.bookLoanSlipId = s.id AND dl.documentId = ?)"
                + "   ORDER BY s.createdDate DESC) x"
                + " ORDER BY createdDate";
        List<BookLoanSlip9> result = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ps.setInt(2, documentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    result.add(toSlip(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    /** Module 2: các phiếu mượn của độc giả có ngày mượn trong [fromDate, toDate], kèm chi tiết. */
    public List<BookLoanSlip9> getLoanSlipsOfReader(int readerId, Date fromDate, Date toDate) {
        String sql = "SELECT * FROM tblBookLoanSlip"
                + " WHERE readerId = ? AND createdDate BETWEEN ? AND ?"
                + " ORDER BY createdDate";
        List<BookLoanSlip9> result = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, readerId);
            ps.setDate(2, fromDate);
            ps.setDate(3, toDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    result.add(toSlip(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        for (BookLoanSlip9 slip : result) {
            slip.setDetailBookLoans(getDetails(slip.getId()));
        }
        return result;
    }

    /** Module 2: một phiếu mượn kèm độc giả, nhân viên lập và danh sách tài liệu; null nếu không có. */
    public BookLoanSlip9 getLoanSlip(int id) {
        String sql = "SELECT s.*,"
                + " rm.fullName AS readerName, r.readerCode,"
                + " sm.fullName AS staffName, st.staffCode"
                + " FROM tblBookLoanSlip s"
                + " JOIN tblReader r ON r.memberId = s.readerId"
                + " JOIN tblMember rm ON rm.id = r.memberId"
                + " JOIN tblStaff st ON st.memberId = s.staffId"
                + " JOIN tblMember sm ON sm.id = st.memberId"
                + " WHERE s.id = ?";
        BookLoanSlip9 slip;
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }
                slip = toSlip(rs);

                Reader9 reader = new Reader9();
                reader.setId(rs.getInt("readerId"));
                reader.setFullName(rs.getString("readerName"));
                reader.setReaderCode(rs.getString("readerCode"));
                slip.setReader(reader);

                Staff9 staff = new Staff9();
                staff.setId(rs.getInt("staffId"));
                staff.setFullName(rs.getString("staffName"));
                staff.setStaffCode(rs.getString("staffCode"));
                slip.setStaff(staff);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        slip.setDetailBookLoans(getDetails(id));
        return slip;
    }

    /** Các tài liệu trong một phiếu mượn, mỗi dòng kèm đối tượng Document9. */
    private List<DetailBookLoan9> getDetails(int slipId) {
        String sql = "SELECT dl.id, dl.quantity, dl.returnCondition,"
                + " d.id AS documentId, d.documentCode, d.title, d.author, d.documentType"
                + " FROM tblDetailBookLoan dl JOIN tblDocument d ON d.id = dl.documentId"
                + " WHERE dl.bookLoanSlipId = ? ORDER BY dl.id";
        List<DetailBookLoan9> result = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, slipId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Document9 doc = new Document9();
                    doc.setId(rs.getInt("documentId"));
                    doc.setDocumentCode(rs.getString("documentCode"));
                    doc.setTitle(rs.getString("title"));
                    doc.setAuthor(rs.getString("author"));
                    doc.setDocumentType(rs.getString("documentType"));

                    DetailBookLoan9 detail = new DetailBookLoan9();
                    detail.setId(rs.getInt("id"));
                    detail.setQuantity(rs.getInt("quantity"));
                    detail.setReturnCondition(rs.getString("returnCondition"));
                    detail.setDocument(doc);
                    result.add(detail);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    /** Đóng gói các cột của tblBookLoanSlip thành đối tượng, tính luôn trạng thái. */
    private BookLoanSlip9 toSlip(ResultSet rs) throws SQLException {
        BookLoanSlip9 s = new BookLoanSlip9();
        s.setId(rs.getInt("id"));
        s.setSlipCode(rs.getString("slipCode"));
        s.setCreatedDate(rs.getDate("createdDate"));
        s.setDueDate(rs.getDate("dueDate"));
        s.setReturnDate(rs.getDate("returnDate"));
        s.setNote(rs.getString("note"));
        s.setStatus(getSlipStatus(s.getDueDate(), s.getReturnDate()));
        return s;
    }
}
