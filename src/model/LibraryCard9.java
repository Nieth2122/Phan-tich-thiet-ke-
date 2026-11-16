package model;

import java.util.Date;

/** Thẻ độc giả. */
public class LibraryCard9 {

    private int id;
    private Date issuanceDate;  // ngày cấp
    private Date expiryDate;  // ngày hết hạn
    private String status;

    public LibraryCard9() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getIssuanceDate() {
        return issuanceDate;
    }

    public void setIssuanceDate(Date issuanceDate) {
        this.issuanceDate = issuanceDate;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
