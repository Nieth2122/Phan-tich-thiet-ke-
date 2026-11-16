<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat, dao.*, model.*" %>
<%@ include file="/WEB-INF/jspf/checkReader.jspf" %>
<%!
    // In ngày dạng dd/MM/yyyy, ngày trống thì in "—"
    String fmt(Date d) { return d == null ? "—" : new SimpleDateFormat("dd/MM/yyyy").format(d); }
    int toInt(String s) {
        try { return Integer.parseInt(s.trim()); } catch (Exception e) { return 0; }
    }
%>
<%
    int documentId = toInt(request.getParameter("documentId"));

    // Gọi DAO theo đúng thứ tự trong kịch bản v3:
    // tăng lượt xem -> lấy chi tiết -> lấy nhà cung cấp -> lấy lịch sử mượn
    DocumentDAO9 documentDAO = new DocumentDAO9();
    documentDAO.increaseViewCount(documentId);
    DocumentStat9 doc = documentDAO.getDocumentDetail(documentId);
    List<Supplier9> suppliers = new SupplierDAO9().getSuppliersOfDocument(documentId);
    List<BookLoanSlip9> history = new BookLoanSlipDAO9().getLoanHistoryOfDocument(documentId, 5);

    // Ghép tên các nhà cung cấp thành một dòng
    StringBuilder supplierNames = new StringBuilder();
    for (Supplier9 s : suppliers) {
        if (supplierNames.length() > 0) supplierNames.append(", ");
        supplierNames.append(s.getName());
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết tài liệu</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<div class="header"><b>LibMan 9 – Chi tiết tài liệu</b> <a href="javascript:history.back()">Quay lại</a></div>
<div class="content">
<% if (doc == null) { %>
    <p class="error">Không tìm thấy tài liệu</p>
<% } else { %>
    <h2><%= doc.getTitle() %></h2>
    <table class="info">
        <tr><td>Mã tài liệu</td><td><%= doc.getDocumentCode() %></td></tr>
        <tr><td>Loại tài liệu</td><td><%= doc.getDocumentType() %></td></tr>
        <tr><td>Tên tài liệu</td><td><%= doc.getTitle() %></td></tr>
        <tr><td>Tác giả</td><td><%= doc.getAuthor() %></td></tr>
        <tr><td>Mô tả</td><td><%= doc.getDescription() %></td></tr>
        <tr><td>Nhà xuất bản</td><td><%= doc.getPublisher() %></td></tr>
        <tr><td>Năm xuất bản</td><td><%= doc.getPublishYear() %></td></tr>
        <tr><td>Số trang</td><td><%= doc.getPageCount() %> trang</td></tr>
        <tr><td>Thể loại</td><td><%= doc.getGenre() %></td></tr>
        <tr><td>Ngôn ngữ</td><td><%= doc.getLanguage() %></td></tr>
        <tr><td>Nhà cung cấp</td><td><%= supplierNames %></td></tr>
        <tr><td>Tổng số bản</td><td><%= doc.getTotalCopies() %> cuốn</td></tr>
        <tr><td>Vị trí</td><td>Kệ <%= doc.getLocation() %></td></tr>
        <tr><td>Có sẵn trên kệ</td><td><%= doc.getAvailableCopies() %> cuốn</td></tr>
    </table>

    <h3>Lịch sử mượn gần đây</h3>
    <% if (history.isEmpty()) { %>
        <p class="empty">Chưa có lượt mượn nào</p>
    <% } else { %>
    <table>
        <tr><th>STT</th><th>Ngày mượn</th><th>Ngày trả</th><th>Phiếu mượn</th><th>Trạng thái</th></tr>
        <% int stt = 1;
           for (BookLoanSlip9 s : history) { %>
        <tr>
            <td><%= stt++ %></td>
            <td><%= fmt(s.getCreatedDate()) %></td>
            <td><%= fmt(s.getReturnDate()) %></td>
            <td><%= s.getSlipCode() %></td>
            <td><%= s.getStatus() %></td>
        </tr>
        <% } %>
    </table>
    <% } %>
<% } %>
</div>
</body>
</html>
