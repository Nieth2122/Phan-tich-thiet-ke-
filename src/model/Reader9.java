package model;

/** Độc giả. */
public class Reader9 extends Member9 {

    private String readerCode;  // mã độc giả, VD B23DCVT117
    private String readerType;  // Sinh viên / Giảng viên
    private LibraryCard9 libraryCard;  // thẻ độc giả

    public Reader9() {
    }

    public String getReaderCode() {
        return readerCode;
    }

    public void setReaderCode(String readerCode) {
        this.readerCode = readerCode;
    }

    public String getReaderType() {
        return readerType;
    }

    public void setReaderType(String readerType) {
        this.readerType = readerType;
    }

    public LibraryCard9 getLibraryCard() {
        return libraryCard;
    }

    public void setLibraryCard(LibraryCard9 libraryCard) {
        this.libraryCard = libraryCard;
    }
}
