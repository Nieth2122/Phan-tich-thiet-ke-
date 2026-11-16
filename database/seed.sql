-- =============================================================
-- LibMan - Dữ liệu mẫu, khớp đúng các bảng trong kịch bản
-- Chạy SAU schema.sql
-- =============================================================
USE LibManDB;
GO

-- Thành viên: 3 độc giả + 1 nhân viên (mật khẩu chỉ để demo)
INSERT INTO tblMember (id, username, password, fullName, dob, email, phone) VALUES
(1, 'vana',  '123456', N'Nguyễn Văn A',      '2004-03-15', 'NguyenVanA@gmail.com', '0367222222'),
(2, 'thib',  '123456', N'Trần Thị B',        '1985-10-20', 'TranThiB@ptit.edu.vn', '0987777777'),
(3, 'vanc',  '123456', N'Phạm Văn C',        '2007-09-02', 'PhamVanC@gmail.com',   '0982222222'),
(4, 'hang',  '123456', N'Lê Thị Thu Hằng',   '1990-05-12', 'hang.lt@libman.vn',    '0912345678');

INSERT INTO tblReader (memberId, readerCode, readerType, cardIssuanceDate, cardExpiryDate, cardStatus) VALUES
(1, 'B23DCVT117', N'Sinh viên',  '2023-09-05', '2027-09-05', N'Còn hạn'),
(2, 'GVCN009',    N'Giảng viên', '2020-01-10', '2030-01-10', N'Còn hạn'),
(3, 'B25DCDT779', N'Sinh viên',  '2025-09-05', '2029-09-05', N'Còn hạn');

INSERT INTO tblStaff (memberId, staffCode, position) VALUES
(4, 'NV-003', N'Nhân viên thư viện');

-- Tài liệu: totalCopies = số bản có sẵn + số bản đang được mượn (chưa trả)
INSERT INTO tblDocument (id, documentCode, title, author, documentType, genre, publisher, publishYear, pageCount, language, description, totalCopies, location, viewCount) VALUES
(1, 'TL-0105', N'Lập trình C++ cơ bản', N'Phạm Văn E', N'Giáo trình', N'Công nghệ thông tin', N'NXB Giáo dục', 2020, 320, N'Tiếng Việt', N'Giáo trình nhập môn lập trình C++.', 6, N'A1-02', 1245),
(2, 'TL-0150', N'Clean Code', N'Robert C. Martin', N'Sách', N'Công nghệ thông tin', N'Prentice Hall', 2008, 464, N'Tiếng Anh', N'Các nguyên tắc viết mã sạch.', 1, N'B3-01', 980),
(3, 'TL-0320', N'Tạp chí Khoa học Máy tính', N'ĐH Bách Khoa', N'Tạp chí', N'Công nghệ thông tin', N'ĐH Bách Khoa', 2025, 120, N'Tiếng Việt', N'Tạp chí chuyên ngành khoa học máy tính.', 2, N'C1-02', 850),
(4, 'TL-0112', N'Cấu trúc dữ liệu và giải thuật', N'Lê Minh B', N'Giáo trình', N'Công nghệ thông tin', N'NXB Khoa học và Kỹ thuật', 2021, 380, N'Tiếng Việt', N'Giáo trình cung cấp kiến thức nền tảng về cấu trúc dữ liệu (mảng, danh sách liên kết, cây, đồ thị) và các giải thuật sắp xếp, tìm kiếm, quy hoạch động. Phù hợp cho sinh viên CNTT năm 2–3.', 15, N'A1-03', 720),
(5, 'TL-0113', N'Bài tập Cấu trúc dữ liệu', N'Nguyễn Trí C', N'Sách', N'Công nghệ thông tin', N'NXB Thống kê', 2019, 250, N'Tiếng Việt', N'Tuyển tập bài tập cấu trúc dữ liệu có lời giải.', 1, N'A1-04', 310),
(6, 'TL-0201', N'Cấu trúc dữ liệu với Java', N'Trần Văn D', N'Sách', N'Công nghệ thông tin', N'NXB Bách Khoa', 2022, 410, N'Tiếng Việt', N'Cài đặt các cấu trúc dữ liệu bằng Java.', 4, N'B2-01', 205),
(7, 'TL-0245', N'Lập trình hướng đối tượng với Java', N'Trần Đan Thư', N'Sách', N'Công nghệ thông tin', N'NXB Khoa học và Kỹ thuật', 2018, 360, N'Tiếng Việt', N'Lập trình hướng đối tượng và Java cơ bản.', 9, N'A2-01', 190),
(8, 'TL-0331', N'Tạp chí Khoa học & Công nghệ – Số 7/2026', N'Viện Hàn lâm KHCNVN', N'Tạp chí', N'Khoa học', N'Viện Hàn lâm KHCNVN', 2026, 96, N'Tiếng Việt', N'Tạp chí khoa học và công nghệ số tháng 7/2026.', 3, N'C1-03', 95);

-- Phiếu mượn (nhân viên lập: id 4 - NV-003)
INSERT INTO tblBookLoanSlip (id, slipCode, createdDate, dueDate, returnDate, note, readerId, staffId) VALUES
(1, 'PM-2026-0199', '2026-06-20', '2026-07-20', NULL,         NULL, 3, 4),
(2, 'PM-2026-0230', '2026-07-03', '2026-08-03', '2026-08-01', NULL, 1, 4),
(3, 'PM-2026-0244', '2026-07-08', '2026-08-08', '2026-08-05', NULL, 2, 4),
(4, 'PM-2026-0248', '2026-07-10', '2026-08-10', NULL,         NULL, 1, 4),
(5, 'PM-2026-0252', '2026-07-15', '2026-08-15', '2026-08-12', NULL, 2, 4),
(6, 'PM-2026-0261', '2026-07-22', '2026-08-22', NULL,         NULL, 1, 4),
(7, 'PM-2026-0263', '2026-07-25', '2026-08-25', NULL,         NULL, 3, 4);

INSERT INTO tblDetailBookLoan (id, quantity, returnCondition, bookLoanSlipId, documentId) VALUES
(1,  1, NULL,           1, 5),   -- PM-0199: Bài tập CTDL
(2,  1, N'Tốt',         2, 4),   -- PM-0230: CTDL và giải thuật
(3,  1, N'Tốt',         2, 7),   -- PM-0230: OOP với Java
(4,  1, N'Hư nhẹ bìa',  2, 8),   -- PM-0230: Tạp chí KH&CN
(5,  1, N'Tốt',         3, 3),   -- PM-0244: Tạp chí KHMT
(6,  1, NULL,           4, 6),   -- PM-0248: CTDL với Java
(7,  1, NULL,           4, 1),   -- PM-0248: C++ cơ bản
(8,  1, N'Tốt',         5, 4),   -- PM-0252: CTDL và giải thuật
(9,  1, NULL,           6, 2),   -- PM-0261: Clean Code
(10, 1, NULL,           6, 7),   -- PM-0261: OOP với Java
(11, 1, NULL,           7, 4);   -- PM-0263: CTDL và giải thuật

-- Nhà cung cấp và phiếu nhập
INSERT INTO tblSupplier (id, name, address, phone, email) VALUES
(1, N'Công ty phát hành sách ACB', N'12 Nguyễn Trãi, Hà Nội', '0243123456', 'lienhe@acb-books.vn');

INSERT INTO tblBookReceipt (id, intakeDate, note, supplierId, staffId) VALUES
(1, '2026-01-10', N'Nhập đầu năm', 1, 4);

INSERT INTO tblDetailBookReceipt (id, quantity, unitPrice, bookReceiptId, documentId) VALUES
(1, 6,  85000,  1, 1),
(2, 1,  450000, 1, 2),
(3, 2,  50000,  1, 3),
(4, 15, 95000,  1, 4),
(5, 1,  70000,  1, 5),
(6, 4,  120000, 1, 6),
(7, 9,  98000,  1, 7),
(8, 3,  40000,  1, 8);
GO
