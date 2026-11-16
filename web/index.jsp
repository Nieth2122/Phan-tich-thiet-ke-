<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- Trang vào hệ thống. Kịch bản giả định người dùng đã đăng nhập,
     nên ở đây chỉ chọn vai trò để vào giao diện chính tương ứng. --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>LibMan 9</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<div class="header"><b>LibMan 9 – Hệ thống quản lý thư viện</b></div>
<div class="content menu">
    <h2>Chọn vai trò</h2>
    <a href="view/reader/ReaderHomePage9.jsp">Độc giả</a>
    <a href="view/staff/StaffHomePage9.jsp">Nhân viên</a>
</div>
</body>
</html>
