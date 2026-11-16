package model;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;

/** Phiếu mượn. */
public class BookLoanSlip9 {

    private int id;
    private String slipCode;  // mã phiếu, VD PM-2026-0230
    private Date createdDate;  // ngày mượn (ngày lập phiếu)
    private Date dueDate;  // ngày hẹn trả
    private Date returnDate;  // ngày trả thực tế, null nếu chưa trả
    private String status;  // Đang mượn / Quá hạn / Đã trả đúng hạn / Đã trả quá hạn
    private String note;
    private Reader9 reader;  // độc giả mượn
    private Staff9 staff;  // nhân viên lập phiếu
    private List<DetailBookLoan9> detailBookLoans = new ArrayList<>();  // các tài liệu trong phiếu

    public BookLoanSlip9() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSlipCode() {
        return slipCode;
    }

    public void setSlipCode(String slipCode) {
        this.slipCode = slipCode;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Reader9 getReader() {
        return reader;
    }

    public void setReader(Reader9 reader) {
        this.reader = reader;
    }

    public Staff9 getStaff() {
        return staff;
    }

    public void setStaff(Staff9 staff) {
        this.staff = staff;
    }

    public List<DetailBookLoan9> getDetailBookLoans() {
        return detailBookLoans;
    }

    public void setDetailBookLoans(List<DetailBookLoan9> detailBookLoans) {
        this.detailBookLoans = detailBookLoans;
    }
}
