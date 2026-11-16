# LibMan 9 – Mã nguồn (Đề 05)

Ứng dụng web JSP + JDBC cho hai module:
- **Module 1:** Độc giả tìm kiếm thông tin tài liệu
- **Module 2:** Nhân viên xem thống kê độc giả theo lượt mượn

Code bám đúng biểu đồ lớp thiết kế trong báo cáo: trang JSP (`web/view`) gọi lớp DAO (`src/dao`), DAO trả về đối tượng thực thể (`src/model`).

## Cấu trúc

```
LibMan/
├── src/model/      12 lớp thực thể (Member9, Reader9, Document9, BookLoanSlip9, ...)
├── src/dao/        DAO9 (kết nối CSDL) + DocumentDAO9, SupplierDAO9, BookLoanSlipDAO9, ReaderDAO9, ReaderStatDAO9
├── web/
│   ├── index.jsp           chọn vai trò Độc giả / Nhân viên
│   ├── style.css
│   ├── view/reader/        ReaderHomePage9, SearchDocumentPage9, DocumentDetailPage9
│   ├── view/staff/         StaffHomePage9, SelectStatPage9, ReaderStatPage9, ReaderLoanPage9, LoanSlipDetailPage9
│   └── WEB-INF/lib/        (đặt driver mssql-jdbc ở đây)
├── database/       schema.sql, seed.sql, create-login.sql
├── db.properties.example
└── build.bat
```

## Chạy nhanh trên máy này (đã cài sẵn)

Tomcat đã giải nén ở `C:\Users\ADMIN\tools\apache-tomcat-10.1.34`, driver đã có trong `web\WEB-INF\lib`, CSDL `LibManDB` và tài khoản `libman_app` đã tạo, `db.properties` đã có mật khẩu.

```bat
set JAVA_HOME=C:\Program Files\Microsoft\jdk-21.0.13.21-hotspot
```
```bat
build.bat "C:\Users\ADMIN\tools\apache-tomcat-10.1.34"
```
```bat
C:\Users\ADMIN\tools\apache-tomcat-10.1.34\bin\startup.bat
```
Mở http://localhost:8080/LibMan/ . Sửa code xong thì build lại, rồi chạy `shutdown.bat` và `startup.bat` để Tomcat nạp lớp Java mới.

Muốn đưa dữ liệu về như ban đầu (lượt xem tăng sau mỗi lần mở trang chi tiết): chạy lại `schema.sql` rồi `seed.sql`.

## Cài đặt và chạy trên máy khác (Windows)

### 1. Chuẩn bị
| Cần có | Cách lấy |
|---|---|
| JDK 21 | Đã có trên máy |
| SQL Server + SSMS | Đã có SQL Server 2025 |
| Apache Tomcat 10.1 | Tải bản **64-bit Windows zip** ở https://tomcat.apache.org/download-10.cgi, giải nén, ví dụ `C:\apache-tomcat-10.1.34` |
| Driver JDBC | Tải **mssql-jdbc** (file `.jar`, bản `jre11`) ở https://learn.microsoft.com/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server, copy file `mssql-jdbc-...jre11.jar` vào `web\WEB-INF\lib\` |

Đặt biến môi trường `JAVA_HOME` trỏ tới thư mục JDK (ví dụ `C:\Program Files\Microsoft\jdk-21.0.13.21-hotspot`) để Tomcat chạy được.

### 2. Tạo cơ sở dữ liệu
Mở SSMS, kết nối `localhost`, lần lượt mở và chạy (Execute):
1. `database\schema.sql` – tạo CSDL `LibManDB` và 9 bảng
2. `database\seed.sql` – nạp dữ liệu mẫu đúng như kịch bản
3. `database\create-login.sql` – tạo tài khoản `libman_app` (sửa mật khẩu trước khi chạy)

### 3. Cấu hình kết nối
Copy `db.properties.example` thành `db.properties`, điền mật khẩu vừa đặt. Giữ `app.today=2026-08-15` để demo ra đúng số liệu kịch bản (Nguyễn Văn A "Quá hạn").

### 4. Build và chạy
```bat
build.bat "C:\apache-tomcat-10.1.34"
```
```bat
C:\apache-tomcat-10.1.34\bin\startup.bat
```
Mở trình duyệt: http://localhost:8080/LibMan/

## Chạy thử theo kịch bản

**Module 1:** Độc giả → Tìm kiếm tài liệu → nhập `Cấu trúc dữ liệu`, chọn thể loại *Công nghệ thông tin*, năm 2019 – 2022 → Tìm kiếm (ra 3 tài liệu) → Xem chi tiết *Cấu trúc dữ liệu và giải thuật* (có sẵn 14/15, lịch sử 3 phiếu).

**Module 2:** Nhân viên → Xem báo cáo thống kê → *Thống kê độc giả theo lượt mượn*, từ 01/07/2026 đến 31/07/2026 → Xem thống kê (A: 3, B: 2, C: 1) → Xem chi tiết Nguyễn Văn A (3 phiếu) → Chi tiết phiếu PM-2026-0230 (3 tài liệu).

## Lỗi thường gặp
| Hiện tượng | Cách xử lý |
|---|---|
| `Không kết nối được CSDL: Login failed` | Sai user/password trong `db.properties`, hoặc chưa chạy `create-login.sql` |
| `ClassNotFoundException: SQLServerDriver` | Chưa copy file `mssql-jdbc-...jar` vào `web\WEB-INF\lib` rồi build lại |
| Lỗi chứng chỉ SSL | Kiểm tra `db.url` có `trustServerCertificate=true` |
| Tomcat tắt ngay khi chạy `startup.bat` | Chưa đặt `JAVA_HOME` |
