<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.MemberDAO9, model.*" %>
<%!
    String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
%>
<%
    request.setCharacterEncoding("UTF-8");

    // Đăng xuất: xóa phiên làm việc rồi hiện lại form đăng nhập
    if (request.getParameter("logout") != null) {
        session.invalidate();
        response.sendRedirect("LoginPage9.jsp");
        return;
    }

    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String error = null;

    if ("POST".equals(request.getMethod())) {
        Member9 member = new MemberDAO9().checkLogin(username, password);
        if (member == null) {
            error = "Sai tên đăng nhập hoặc mật khẩu";
        } else {
            // Lưu người dùng vào phiên rồi chuyển tới giao diện chính theo vai trò
            session.setAttribute("member", member);
            if (member instanceof Reader9) {
                response.sendRedirect("../reader/ReaderHomePage9.jsp");
            } else {
                response.sendRedirect("../staff/StaffHomePage9.jsp");
            }
            return;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<div class="header"><b>LibMan 9 – Hệ thống quản lý thư viện</b></div>
<div class="content login">
    <h2>Đăng nhập</h2>
    <form method="post" action="LoginPage9.jsp" class="filter">
        <div>Tên đăng nhập: <input type="text" name="username" value="<%= esc(username) %>"></div>
        <div>Mật khẩu: <input type="password" name="password"></div>
        <div><button type="submit">Đăng nhập</button></div>
    </form>
    <% if (error != null) { %>
        <p class="error"><%= error %></p>
    <% } %>
</div>
</body>
</html>
