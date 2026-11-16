<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat, dao.*, model.*" %>
<%@ include file="/WEB-INF/jspf/checkStaff.jspf" %>
<%
    // Nhận mã độc giả và khoảng ngày từ ReaderStatPage9
    int readerId = Integer.parseInt(request.getParameter("readerId"));
    java.sql.Date from = java.sql.Date.valueOf(request.getParameter("fromDate"));
    java.sql.Date to = java.sql.Date.valueOf(request.getParameter("toDate"));

    Reader9 reader = new ReaderDAO9().getReader(readerId);
    List<BookLoanSlip9> slips = new BookLoanSlipDAO9().getLoanSlipsOfReader(readerId, from, to);
    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch sử mượn của độc giả</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<div class="header"><b>LibMan 9 – Lịch sử mượn của độc giả</b> <a href="javascript:history.back()">Quay lại</a></div>
<div class="content">
<% if (reader == null) { %>
    <p class="error">Không tìm thấy độc giả</p>
<% } else { %>
    <h3>Thông tin độc giả</h3>
    <table class="info">
        <tr><td>Mã độc giả</td><td><%= reader.getReaderCode() %></td></tr>
        <tr><td>Họ tên</td><td><%= reader.getFullName() %></td></tr>
        <tr><td>Ngày sinh</td><td><%= reader.getDob() == null ? "" : df.format(reader.getDob()) %></td></tr>
        <tr><td>Phân loại</td><td><%= reader.getReaderType() %></td></tr>
        <tr><td>Email</td><td><%= reader.getEmail() %></td></tr>
        <tr><td>Số điện thoại</td><td><%= reader.getPhone() %></td></tr>
    </table>

    <h3>Danh sách các lần mượn (<%= df.format(from) %> – <%= df.format(to) %>)</h3>
    <table>
        <tr><th>STT</th><th>Mã phiếu mượn</th><th>Ngày mượn</th><th>Ngày hẹn trả</th>
            <th>Số sách mượn</th><th>Trạng thái</th><th></th></tr>
        <% int stt = 1;
           for (BookLoanSlip9 s : slips) {
               // Số sách mượn = tổng số lượng các tài liệu trong phiếu
               int bookCount = 0;
               for (DetailBookLoan9 d : s.getDetailBookLoans()) bookCount += d.getQuantity(); %>
        <tr>
            <td><%= stt++ %></td>
            <td><%= s.getSlipCode() %></td>
            <td><%= df.format(s.getCreatedDate()) %></td>
            <td><%= df.format(s.getDueDate()) %></td>
            <td><%= bookCount %></td>
            <td><%= s.getStatus() %></td>
            <td><a href="LoanSlipDetailPage9.jsp?loanSlipId=<%= s.getId() %>">Chi tiết phiếu</a></td>
        </tr>
        <% } %>
    </table>
<% } %>
</div>
</body>
</html>
