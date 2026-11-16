<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.SimpleDateFormat, dao.BookLoanSlipDAO9, model.*" %>
<%@ include file="/WEB-INF/jspf/checkStaff.jspf" %>
<%
    // Nhận mã phiếu mượn từ ReaderLoanPage9
    int loanSlipId = Integer.parseInt(request.getParameter("loanSlipId"));
    BookLoanSlip9 slip = new BookLoanSlipDAO9().getLoanSlip(loanSlipId);
    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết phiếu mượn</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<div class="header"><b>LibMan 9 – Chi tiết phiếu mượn</b> <a href="javascript:history.back()">Quay lại</a></div>
<div class="content">
<% if (slip == null) { %>
    <p class="error">Không tìm thấy phiếu mượn</p>
<% } else { %>
    <table class="info">
        <tr><td>Mã phiếu mượn</td><td><%= slip.getSlipCode() %></td></tr>
        <tr><td>Ngày lập phiếu</td><td><%= df.format(slip.getCreatedDate()) %></td></tr>
        <tr><td>Nhân viên lập</td><td><%= slip.getStaff().getStaffCode() %> – <%= slip.getStaff().getFullName() %></td></tr>
        <tr><td>Mã độc giả</td><td><%= slip.getReader().getReaderCode() %></td></tr>
        <tr><td>Tên độc giả</td><td><%= slip.getReader().getFullName() %></td></tr>
        <tr><td>Ngày hẹn trả</td><td><%= df.format(slip.getDueDate()) %></td></tr>
        <tr><td>Ngày trả thực tế</td><td><%= slip.getReturnDate() == null ? "" : df.format(slip.getReturnDate()) %></td></tr>
        <tr><td>Trạng thái</td><td><%= slip.getStatus() %></td></tr>
        <tr><td>Ghi chú</td><td><%= slip.getNote() == null ? "—" : slip.getNote() %></td></tr>
    </table>

    <h3>Danh sách tài liệu mượn</h3>
    <table>
        <tr><th>STT</th><th>Mã tài liệu</th><th>Tên tài liệu</th><th>Tác giả</th><th>Loại</th>
            <th>Số lượng</th><th>Tình trạng khi trả</th></tr>
        <% int stt = 1;
           for (DetailBookLoan9 d : slip.getDetailBookLoans()) { %>
        <tr>
            <td><%= stt++ %></td>
            <td><%= d.getDocument().getDocumentCode() %></td>
            <td><%= d.getDocument().getTitle() %></td>
            <td><%= d.getDocument().getAuthor() %></td>
            <td><%= d.getDocument().getDocumentType() %></td>
            <td><%= d.getQuantity() %></td>
            <td><%= d.getReturnCondition() == null ? "" : d.getReturnCondition() %></td>
        </tr>
        <% } %>
    </table>
<% } %>
</div>
</body>
</html>
