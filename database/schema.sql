-- =============================================================
-- LibMan - Tạo cơ sở dữ liệu (theo Hình 3.2 của báo cáo)
-- Chạy trên SQL Server: mở file trong SSMS rồi bấm Execute
-- =============================================================
IF DB_ID('LibManDB') IS NULL
    CREATE DATABASE LibManDB;
GO
USE LibManDB;
GO

-- Xóa bảng cũ (nếu chạy lại), xóa bảng con trước bảng cha
DROP TABLE IF EXISTS tblDetailBookReceipt, tblBookReceipt, tblSupplier,
                     tblDetailBookLoan, tblBookLoanSlip, tblDocument,
                     tblStaff, tblReader, tblMember;
GO

-- Thành viên (lớp cha của Độc giả và Nhân viên)
CREATE TABLE tblMember (
    id        INT PRIMARY KEY,
    username  VARCHAR(50)   NOT NULL UNIQUE,
    password  VARCHAR(255)  NOT NULL,
    fullName  NVARCHAR(100) NOT NULL,
    dob       DATE,
    email     VARCHAR(100),
    phone     VARCHAR(15)
);

-- Độc giả (gộp luôn thông tin thẻ độc giả vì quan hệ 1 - 1)
CREATE TABLE tblReader (
    memberId          INT PRIMARY KEY REFERENCES tblMember(id),
    readerCode        VARCHAR(20)  NOT NULL UNIQUE,
    readerType        NVARCHAR(30) NOT NULL,
    cardIssuanceDate  DATE,
    cardExpiryDate    DATE,
    cardStatus        NVARCHAR(30)
);

-- Nhân viên (một vai trò chung, không phân quyền)
CREATE TABLE tblStaff (
    memberId   INT PRIMARY KEY REFERENCES tblMember(id),
    staffCode  VARCHAR(20) NOT NULL UNIQUE,
    position   NVARCHAR(50)
);

-- Tài liệu
CREATE TABLE tblDocument (
    id            INT PRIMARY KEY,
    documentCode  VARCHAR(20)   NOT NULL UNIQUE,
    title         NVARCHAR(255) NOT NULL,
    author        NVARCHAR(255),
    documentType  NVARCHAR(30),
    genre         NVARCHAR(50),
    publisher     NVARCHAR(255),
    publishYear   INT,
    pageCount     INT,
    language      NVARCHAR(30),
    description   NVARCHAR(MAX),
    totalCopies   INT NOT NULL DEFAULT 0,
    location      NVARCHAR(20),
    viewCount     INT NOT NULL DEFAULT 0
);

-- Phiếu mượn (trạng thái không lưu, tính từ dueDate và returnDate)
CREATE TABLE tblBookLoanSlip (
    id           INT PRIMARY KEY,
    slipCode     VARCHAR(20) NOT NULL UNIQUE,
    createdDate  DATE NOT NULL,
    dueDate      DATE NOT NULL,
    returnDate   DATE NULL,
    note         NVARCHAR(500),
    readerId     INT NOT NULL REFERENCES tblReader(memberId),
    staffId      INT NOT NULL REFERENCES tblStaff(memberId)
);

-- Chi tiết phiếu mượn
CREATE TABLE tblDetailBookLoan (
    id               INT PRIMARY KEY,
    quantity         INT NOT NULL DEFAULT 1,
    returnCondition  NVARCHAR(255),
    bookLoanSlipId   INT NOT NULL REFERENCES tblBookLoanSlip(id),
    documentId       INT NOT NULL REFERENCES tblDocument(id)
);

-- Nhà cung cấp
CREATE TABLE tblSupplier (
    id       INT PRIMARY KEY,
    name     NVARCHAR(255) NOT NULL,
    address  NVARCHAR(255),
    phone    VARCHAR(15),
    email    VARCHAR(100)
);

-- Phiếu nhập
CREATE TABLE tblBookReceipt (
    id          INT PRIMARY KEY,
    intakeDate  DATE NOT NULL,
    note        NVARCHAR(500),
    supplierId  INT NOT NULL REFERENCES tblSupplier(id),
    staffId     INT NOT NULL REFERENCES tblStaff(memberId)
);

-- Chi tiết phiếu nhập
CREATE TABLE tblDetailBookReceipt (
    id             INT PRIMARY KEY,
    quantity       INT NOT NULL,
    unitPrice      DECIMAL(18, 2) NOT NULL,
    bookReceiptId  INT NOT NULL REFERENCES tblBookReceipt(id),
    documentId     INT NOT NULL REFERENCES tblDocument(id)
);
GO
