package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Member9;
import model.Reader9;
import model.Staff9;

/** Truy cập dữ liệu thành viên: đăng nhập. */
public class MemberDAO9 extends DAO9 {

    public MemberDAO9() {
        super();
    }

    /**
     * Kiểm tra tên đăng nhập và mật khẩu.
     * Đúng thì trả về Reader9 (nếu là độc giả) hoặc Staff9 (nếu là nhân viên); sai thì trả null.
     */
    public Member9 checkLogin(String username, String password) {
        String sql = "SELECT m.*, r.readerCode, r.readerType, s.staffCode, s.position"
                + " FROM tblMember m"
                + " LEFT JOIN tblReader r ON r.memberId = m.id"
                + " LEFT JOIN tblStaff s ON s.memberId = m.id"
                + " WHERE m.username = ? AND m.password = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }
                Member9 member;
                if (rs.getString("readerCode") != null) {
                    Reader9 reader = new Reader9();
                    reader.setReaderCode(rs.getString("readerCode"));
                    reader.setReaderType(rs.getString("readerType"));
                    member = reader;
                } else if (rs.getString("staffCode") != null) {
                    Staff9 staff = new Staff9();
                    staff.setStaffCode(rs.getString("staffCode"));
                    staff.setPosition(rs.getString("position"));
                    member = staff;
                } else {
                    return null;  // tài khoản không gắn với độc giả hay nhân viên nào
                }
                member.setId(rs.getInt("id"));
                member.setUsername(rs.getString("username"));
                member.setFullName(rs.getString("fullName"));
                member.setDob(rs.getDate("dob"));
                member.setEmail(rs.getString("email"));
                member.setPhone(rs.getString("phone"));
                return member;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
