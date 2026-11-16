# LibMan 9 – Mã nguồn (Đề 05)

Ứng dụng web JSP + JDBC cho hai module:
- **Module 1:** Độc giả tìm kiếm thông tin tài liệu
- **Module 2:** Nhân viên xem thống kê độc giả theo lượt mượn

Code bám đúng biểu đồ lớp thiết kế trong báo cáo: trang JSP (`web/view`) gọi lớp DAO (`src/dao`), DAO trả về đối tượng thực thể (`src/model`).

## Cấu trúc

```
LibMan/
├── src/model/      12 lớp thực thể (Member9, Reader9, Document9, BookLoanSlip9, ...)
├── src/dao/        DAO9 (kết nối CSDL) + MemberDAO9 (đăng nhập), DocumentDAO9, SupplierDAO9, BookLoanSlipDAO9, ReaderDAO9, ReaderStatDAO9
├── web/
│   ├── index.jsp           chuyển tới trang đăng nhập
│   ├── view/member/        LoginPage9 (đăng nhập, đăng xuất)
│   ├── style.css
│   ├── view/reader/        ReaderHomePage9, SearchDocumentPage9, DocumentDetailPage9
│   ├── view/staff/         StaffHomePage9, SelectStatPage9, ReaderStatPage9, ReaderLoanPage9, LoanSlipDetailPage9
│   └── WEB-INF/lib/        (đặt driver mssql-jdbc ở đây)
├── database/       schema.sql, seed.sql, create-login.sql
├── db.properties.example
└── build.bat
```
