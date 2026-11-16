package model;

/** Tài liệu kèm số bản có sẵn (tính khi truy vấn). */
public class DocumentStat9 extends Document9 {

    private int availableCopies;  // số bản có sẵn = tổng số bản - số bản đang được mượn

    public DocumentStat9() {
    }

    public int getAvailableCopies() {
        return availableCopies;
    }

    public void setAvailableCopies(int availableCopies) {
        this.availableCopies = availableCopies;
    }
}
