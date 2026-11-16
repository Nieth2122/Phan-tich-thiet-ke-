<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, dao.DocumentDAO9, model.DocumentStat9" %>
<%@ include file="/WEB-INF/jspf/checkReader.jspf" %>
<%!
    // Đổi ký tự đặc biệt khi in lại dữ liệu người dùng nhập (tránh chèn mã HTML)
    String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
    // Chuyển chuỗi sang số, ô trống hoặc sai thì trả 0
    int toInt(String s) {
        try { return Integer.parseInt(s.trim()); } catch (Exception e) { return 0; }
    }
%>
<%
    request.setCharacterEncoding("UTF-8");

    // 1. Đọc dữ liệu từ form
    String keyword = request.getParameter("keyword");
    String[] typeParams = request.getParameterValues("documentType");
    List<String> documentTypes = typeParams == null ? new ArrayList<String>() : Arrays.asList(typeParams);
    String genre = request.getParameter("genre");
    int fromYear = toInt(request.getParameter("fromYear"));
    int toYear = toInt(request.getParameter("toYear"));
    boolean searched = request.getParameter("search") != null;

    // 2. Kiểm tra dữ liệu nhập (ngoại lệ 3.1, 3.2 của kịch bản)
    String error = null;
    if (searched) {
        if (keyword == null || keyword.trim().isEmpty()) {
            error = "Vui lòng nhập tên tài liệu cần tìm";
        } else if (fromYear > 0 && toYear > 0 && fromYear > toYear) {
            error = "Năm bắt đầu phải nhỏ hơn hoặc bằng năm kết thúc";
        }
    }

    // 3. Gọi DAO lấy dữ liệu
    DocumentDAO9 documentDAO = new DocumentDAO9();
    List<String> genres = documentDAO.getGenres();
    List<DocumentStat9> documents;
    String tableTitle;
    if (searched && error == null) {
        documents = documentDAO.searchDocument(keyword.trim(), documentTypes, genre, fromYear, toYear);
        tableTitle = "Kết quả tìm kiếm";
    } else {
        documents = documentDAO.getMostViewedDocuments(10);
        tableTitle = "Tài liệu được xem nhiều nhất";
    }
    String[] TYPES = {"Tất cả", "Sách", "Giáo trình", "Tạp chí", "Luận văn"};
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm tài liệu</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<div class="header"><b>LibMan 9 – Tìm kiếm tài liệu</b> <a href="ReaderHomePage9.jsp">Quay lại</a></div>
<div class="content">
    <form method="get" action="SearchDocumentPage9.jsp" class="filter">
        <div>
            Tên tài liệu:
            <input type="text" name="keyword" size="40" value="<%= esc(keyword) %>">
            <button type="submit" name="search" value="1">Tìm kiếm</button>
            <a class="button secondary" href="SearchDocumentPage9.jsp">Làm mới</a>
        </div>
        <h3>Bộ lọc nâng cao</h3>
        <div>Loại tài liệu:
            <% for (String t : TYPES) {
                   boolean checked = documentTypes.contains(t) || (documentTypes.isEmpty() && t.equals("Tất cả")); %>
                <label><input type="checkbox" name="documentType" value="<%= t %>" <%= checked ? "checked" : "" %>> <%= t %></label>
            <% } %>
        </div>
        <div>Thể loại:
            <select name="genre">
                <option value="">-- Chọn thể loại --</option>
                <% for (String g : genres) { %>
                    <option value="<%= esc(g) %>" <%= g.equals(genre) ? "selected" : "" %>><%= esc(g) %></option>
                <% } %>
            </select>
        </div>
        <div>Năm xuất bản: từ
            <input type="number" name="fromYear" style="width:80px" value="<%= fromYear > 0 ? fromYear : "" %>">
            đến
            <input type="number" name="toYear" style="width:80px" value="<%= toYear > 0 ? toYear : "" %>">
        </div>
    </form>

    <% if (error != null) { %>
        <p class="error"><%= error %></p>
    <% } %>

    <h3><%= tableTitle %></h3>
    <% if (documents.isEmpty()) { %>
        <p class="empty">Không tìm thấy tài liệu phù hợp</p>
    <% } else { %>
    <table>
        <tr><th>STT</th><th>Thông tin tài liệu</th><th>Trạng thái</th><th></th></tr>
        <% int stt = 1;
           for (DocumentStat9 d : documents) { %>
        <tr>
            <td><%= stt++ %></td>
            <td>
                <b>Tên:</b> <%= d.getTitle() %><br>
                <b>Tác giả:</b> <%= d.getAuthor() %><br>
                <b>Loại:</b> <%= d.getDocumentType() %> –
                <% if (searched && error == null) { %>
                    <b>Năm xuất bản:</b> <%= d.getPublishYear() %>
                <% } else { %>
                    <b>Lượt xem:</b> <%= d.getViewCount() %>
                <% } %>
            </td>
            <td>
                <%= d.getAvailableCopies() > 0 ? "Có sẵn: " + d.getAvailableCopies() + " cuốn" : "Đã hết: 0 cuốn" %><br>
                Vị trí: Kệ <%= d.getLocation() %>
            </td>
            <td><a href="DocumentDetailPage9.jsp?documentId=<%= d.getId() %>">Xem chi tiết</a></td>
        </tr>
        <% } %>
    </table>
    <% } %>
</div>
</body>
</html>
