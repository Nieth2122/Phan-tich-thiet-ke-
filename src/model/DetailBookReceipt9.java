package model;

/** Một tài liệu trong phiếu nhập. */
public class DetailBookReceipt9 {

    private int id;
    private int quantity;
    private double unitPrice;  // đơn giá
    private Document9 document;

    public DetailBookReceipt9() {
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

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Document9 getDocument() {
        return document;
    }

    public void setDocument(Document9 document) {
        this.document = document;
    }
}
