<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- Giao diện chính của nhân viên --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ nhân viên</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<div class="header"><b>LibMan 9 – Nhân viên</b> <a href="<%= request.getContextPath() %>/index.jsp">Đăng xuất</a></div>
<div class="content menu">
    <h2>Menu chính</h2>
    <a href="SelectStatPage9.jsp">Xem báo cáo thống kê</a>
</div>
</body>
</html>
