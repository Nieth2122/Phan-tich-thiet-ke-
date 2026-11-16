<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- Giao diện chính của độc giả --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ độc giả</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<div class="header"><b>LibMan 9 – Độc giả</b> <a href="<%= request.getContextPath() %>/index.jsp">Đăng xuất</a></div>
<div class="content menu">
    <h2>Menu chính</h2>
    <a href="SearchDocumentPage9.jsp">Tìm kiếm tài liệu</a>
</div>
</body>
</html>
