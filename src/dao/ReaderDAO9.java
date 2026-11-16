package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.LibraryCard9;
import model.Reader9;

/** Truy cập dữ liệu độc giả (Module 2). */
public class ReaderDAO9 extends DAO9 {

    public ReaderDAO9() {
        super();
    }

    /** Thông tin một độc giả (ghép bảng tblMember và tblReader); null nếu không có. */
    public Reader9 getReader(int id) {
        String sql = "SELECT m.*, r.* FROM tblMember m JOIN tblReader r ON r.memberId = m.id WHERE m.id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }
                Reader9 r = new Reader9();
                r.setId(rs.getInt("id"));
                r.setUsername(rs.getString("username"));
                r.setFullName(rs.getString("fullName"));
                r.setDob(rs.getDate("dob"));
                r.setEmail(rs.getString("email"));
                r.setPhone(rs.getString("phone"));
                r.setReaderCode(rs.getString("readerCode"));
                r.setReaderType(rs.getString("readerType"));

                LibraryCard9 card = new LibraryCard9();
                card.setIssuanceDate(rs.getDate("cardIssuanceDate"));
                card.setExpiryDate(rs.getDate("cardExpiryDate"));
                card.setStatus(rs.getString("cardStatus"));
                r.setLibraryCard(card);
                return r;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
