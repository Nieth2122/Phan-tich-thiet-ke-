<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat, dao.ReaderStatDAO9, model.ReaderStat9" %>
<%@ include file="/WEB-INF/jspf/checkStaff.jspf" %>
<%
    // Nhận khoảng ngày từ SelectStatPage9 (dạng yyyy-MM-dd)
    String fromDate = request.getParameter("fromDate");
    String toDate = request.getParameter("toDate");
    if (fromDate == null || toDate == null) {
        response.sendRedirect("SelectStatPage9.jsp");
        return;
    }
    java.sql.Date from = java.sql.Date.valueOf(fromDate);
    java.sql.Date to = java.sql.Date.valueOf(toDate);

    List<ReaderStat9> stats = new ReaderStatDAO9().getReaderStat(from, to);
    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thống kê độc giả theo lượt mượn</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<div class="header"><b>LibMan 9 – Thống kê độc giả theo lượt mượn</b> <a href="javascript:history.back()">Quay lại</a></div>
<div class="content">
    <p>Khoảng thời gian: <b><%= df.format(from) %> – <%= df.format(to) %></b></p>
    <% if (stats.isEmpty()) { %>
        <p class="empty">Không có dữ liệu mượn trong khoảng thời gian này</p>
    <% } else { %>
    <table>
        <tr><th>STT</th><th>Mã độc giả</th><th>Họ và tên</th><th>Phân loại</th><th>Số điện thoại</th>
            <th>Số lần mượn</th><th>Tình trạng</th><th></th></tr>
        <% int stt = 1;
           for (ReaderStat9 r : stats) { %>
        <tr>
            <td><%= stt++ %></td>
            <td><%= r.getReaderCode() %></td>
            <td><%= r.getFullName() %></td>
            <td><%= r.getReaderType() %></td>
            <td><%= r.getPhone() %></td>
            <td><%= r.getLoanCount() %></td>
            <td><%= r.getLoanStatus() %></td>
            <td><a href="ReaderLoanPage9.jsp?readerId=<%= r.getId() %>&fromDate=<%= fromDate %>&toDate=<%= toDate %>">Xem chi tiết</a></td>
        </tr>
        <% } %>
    </table>
    <% } %>
</div>
</body>
</html>
