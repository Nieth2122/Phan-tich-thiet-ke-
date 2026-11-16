package model;

/** Một tài liệu trong phiếu mượn. */
public class DetailBookLoan9 {

    private int id;
    private int quantity;
    private String returnCondition;  // tình trạng khi trả
    private Document9 document;

    public DetailBookLoan9() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getReturnCondition() {
        return returnCondition;
    }

    public void setReturnCondition(String returnCondition) {
        this.returnCondition = returnCondition;
    }

    public Document9 getDocument() {
        return document;
    }

    public void setDocument(Document9 document) {
        this.document = document;
    }
}
