package model;

/** Thống kê độc giả theo lượt mượn (không có bảng riêng, số liệu tính khi truy vấn). */
public class ReaderStat9 extends Reader9 {

    private int loanCount;  // số lần mượn trong khoảng thống kê
    private String loanStatus;  // Quá hạn / Đang mượn / Đã trả hết

    public ReaderStat9() {
    }

    public int getLoanCount() {
        return loanCount;
    }

    public void setLoanCount(int loanCount) {
        this.loanCount = loanCount;
    }

    public String getLoanStatus() {
        return loanStatus;
    }

    public void setLoanStatus(String loanStatus) {
        this.loanStatus = loanStatus;
    }
}
