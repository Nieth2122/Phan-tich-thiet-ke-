package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.DocumentStat9;

/** Truy cập dữ liệu tài liệu (Module 1). */
public class DocumentDAO9 extends DAO9 {

    /** Phần SELECT dùng chung: mọi cột của tài liệu + số bản có sẵn. */
    private static final String SELECT_DOCUMENT =
            "SELECT d.*, d.totalCopies - ISNULL((SELECT SUM(dl.quantity)"
            + "   FROM tblDetailBookLoan dl JOIN tblBookLoanSlip s ON s.id = dl.bookLoanSlipId"
            + "   WHERE dl.documentId = d.id AND s.returnDate IS NULL), 0) AS availableCopies"
            + " FROM tblDocument d";

    public DocumentDAO9() {
        super();
    }

    /** Danh sách thể loại (không trùng) để hiện trong ô chọn Thể loại. */
    public List<String> getGenres() {
        List<String> result = new ArrayList<>();
        String sql = "SELECT DISTINCT genre FROM tblDocument WHERE genre IS NOT NULL ORDER BY genre";
        try (PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                result.add(rs.getString("genre"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    /** limit tài liệu có lượt xem cao nhất. */
    public List<DocumentStat9> getMostViewedDocuments(int limit) {
        List<DocumentStat9> result = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM (" + SELECT_DOCUMENT + ") x ORDER BY viewCount DESC";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    result.add(toDocument(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    /**
     * Tìm tài liệu có tên chứa keyword và thỏa bộ lọc.
     * documentTypes rỗng hoặc chứa "Tất cả" thì không lọc theo loại;
     * genre rỗng thì không lọc thể loại; fromYear/toYear = 0 thì không lọc năm.
     */
    public List<DocumentStat9> searchDocument(String keyword, List<String> documentTypes,
                                              String genre, int fromYear, int toYear) {
        StringBuilder sql = new StringBuilder("SELECT * FROM (" + SELECT_DOCUMENT + ") x WHERE title LIKE ?");
        List<Object> params = new ArrayList<>();
        params.add("%" + keyword + "%");

        if (documentTypes != null && !documentTypes.isEmpty() && !documentTypes.contains("Tất cả")) {
            sql.append(" AND documentType IN (");
            for (int i = 0; i < documentTypes.size(); i++) {
                sql.append(i == 0 ? "?" : ", ?");
                params.add(documentTypes.get(i));
            }
            sql.append(")");
        }
        if (genre != null && !genre.isEmpty()) {
            sql.append(" AND genre = ?");
            params.add(genre);
        }
        if (fromYear > 0) {
            sql.append(" AND publishYear >= ?");
            params.add(fromYear);
        }
        if (toYear > 0) {
            sql.append(" AND publishYear <= ?");
            params.add(toYear);
        }
        sql.append(" ORDER BY viewCount DESC, title");  // tài liệu được xem nhiều hiện trước

        List<DocumentStat9> result = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    result.add(toDocument(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    /** Tăng lượt xem của tài liệu thêm 1. Trả true nếu cập nhật được. */
    public boolean increaseViewCount(int id) {
        String sql = "UPDATE tblDocument SET viewCount = viewCount + 1 WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /** Thông tin đầy đủ của một tài liệu kèm số bản có sẵn; null nếu không có. */
    public DocumentStat9 getDocumentDetail(int id) {
        String sql = SELECT_DOCUMENT + " WHERE d.id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? toDocument(rs) : null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /** Đóng gói một dòng kết quả thành đối tượng DocumentStat9. */
    private DocumentStat9 toDocument(ResultSet rs) throws SQLException {
        DocumentStat9 d = new DocumentStat9();
        d.setId(rs.getInt("id"));
        d.setDocumentCode(rs.getString("documentCode"));
        d.setTitle(rs.getString("title"));
        d.setAuthor(rs.getString("author"));
        d.setDocumentType(rs.getString("documentType"));
        d.setGenre(rs.getString("genre"));
        d.setPublisher(rs.getString("publisher"));
        d.setPublishYear(rs.getInt("publishYear"));
        d.setPageCount(rs.getInt("pageCount"));
        d.setLanguage(rs.getString("language"));
        d.setDescription(rs.getString("description"));
        d.setTotalCopies(rs.getInt("totalCopies"));
        d.setLocation(rs.getString("location"));
        d.setViewCount(rs.getInt("viewCount"));
        d.setAvailableCopies(rs.getInt("availableCopies"));
        return d;
    }
}
