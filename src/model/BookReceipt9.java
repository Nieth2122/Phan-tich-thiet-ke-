package model;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;

/** Phiếu nhập tài liệu. */
public class BookReceipt9 {

    private int id;
    private Date intakeDate;  // ngày nhập
    private String note;
    private Supplier9 supplier;
    private Staff9 staff;  // nhân viên lập phiếu
    private List<DetailBookReceipt9> detailBookReceipts = new ArrayList<>();

    public BookReceipt9() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getIntakeDate() {
        return intakeDate;
    }

    public void setIntakeDate(Date intakeDate) {
        this.intakeDate = intakeDate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Supplier9 getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier9 supplier) {
        this.supplier = supplier;
    }

    public Staff9 getStaff() {
        return staff;
    }

    public void setStaff(Staff9 staff) {
        this.staff = staff;
    }

    public List<DetailBookReceipt9> getDetailBookReceipts() {
        return detailBookReceipts;
    }

    public void setDetailBookReceipts(List<DetailBookReceipt9> detailBookReceipts) {
        this.detailBookReceipts = detailBookReceipts;
    }
}
