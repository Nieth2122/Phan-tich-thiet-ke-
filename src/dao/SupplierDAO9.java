package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Supplier9;

/** Truy cập dữ liệu nhà cung cấp (Module 1). */
public class SupplierDAO9 extends DAO9 {

    public SupplierDAO9() {
        super();
    }

    /** Các nhà cung cấp đã từng cung cấp tài liệu này (qua phiếu nhập). */
    public List<Supplier9> getSuppliersOfDocument(int documentId) {
        String sql = "SELECT DISTINCT s.* FROM tblSupplier s"
                + " JOIN tblBookReceipt r ON r.supplierId = s.id"
                + " JOIN tblDetailBookReceipt dr ON dr.bookReceiptId = r.id"
                + " WHERE dr.documentId = ?";
        List<Supplier9> result = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, documentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Supplier9 s = new Supplier9();
                    s.setId(rs.getInt("id"));
                    s.setName(rs.getString("name"));
                    s.setAddress(rs.getString("address"));
                    s.setPhone(rs.getString("phone"));
                    s.setEmail(rs.getString("email"));
                    result.add(s);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return result;
    }
}
