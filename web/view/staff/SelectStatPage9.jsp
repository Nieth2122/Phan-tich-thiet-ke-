<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Đọc lựa chọn của nhân viên (ngày có dạng yyyy-MM-dd do ô input type=date gửi lên)
    String statType = request.getParameter("statType");
    String fromDate = request.getParameter("fromDate");
    String toDate = request.getParameter("toDate");
    if (statType == null) statType = "reader";

    String error = null;
    if (request.getParameter("view") != null) {
        // Kiểm tra dữ liệu (ngoại lệ 3.1, 3.2 của kịch bản)
        if (fromDate == null || fromDate.isEmpty() || toDate == null || toDate.isEmpty()) {
            error = "Vui lòng chọn khoảng thời gian thống kê";
        } else if (fromDate.compareTo(toDate) > 0) {
            error = "Ngày bắt đầu phải trước hoặc bằng ngày kết thúc";
        } else if (!statType.equals("reader")) {
            error = "Bài này chỉ xây dựng chức năng Thống kê độc giả theo lượt mượn";
        } else {
            // Hợp lệ: chuyển sang trang thống kê độc giả, truyền khoảng ngày
            response.sendRedirect("ReaderStatPage9.jsp?fromDate=" + fromDate + "&toDate=" + toDate);
            return;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xem báo cáo thống kê</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<div class="header"><b>LibMan 9 – Xem báo cáo thống kê</b> <a href="StaffHomePage9.jsp">Quay lại</a></div>
<div class="content">
    <form method="get" action="SelectStatPage9.jsp" class="filter">
        <h3>Loại thống kê</h3>
        <div><label><input type="radio" name="statType" value="reader" <%= statType.equals("reader") ? "checked" : "" %>> Thống kê độc giả theo lượt mượn</label></div>
        <div><label><input type="radio" name="statType" value="document" <%= statType.equals("document") ? "checked" : "" %>> Thống kê tình trạng tài liệu</label></div>
        <div><label><input type="radio" name="statType" value="import" <%= statType.equals("import") ? "checked" : "" %>> Thống kê tài liệu nhập</label></div>
        <div>
            Từ ngày: <input type="date" name="fromDate" value="<%= fromDate == null ? "" : fromDate %>">
            Đến ngày: <input type="date" name="toDate" value="<%= toDate == null ? "" : toDate %>">
        </div>
        <div>
            <button type="submit" name="view" value="1">Xem thống kê</button>
            <a class="button secondary" href="SelectStatPage9.jsp">Làm mới</a>
        </div>
    </form>
    <% if (error != null) { %>
        <p class="error"><%= error %></p>
    <% } %>
</div>
</body>
</html>
