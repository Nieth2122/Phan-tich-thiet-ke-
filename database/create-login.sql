-- =============================================================
-- LibMan - Tạo tài khoản SQL cho ứng dụng (chạy SAU schema.sql)
-- Đổi mật khẩu ở 2 chỗ: dòng CREATE LOGIN bên dưới và db.properties
-- =============================================================
USE master;
GO
CREATE LOGIN libman_app WITH PASSWORD = 'DOI_MAT_KHAU_O_DAY', CHECK_POLICY = OFF;
GO
USE LibManDB;
GO
CREATE USER libman_app FOR LOGIN libman_app;
ALTER ROLE db_datareader ADD MEMBER libman_app;  -- được đọc dữ liệu
ALTER ROLE db_datawriter ADD MEMBER libman_app;  -- được ghi (tăng lượt xem)
GO
