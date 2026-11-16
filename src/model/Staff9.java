package model;

/** Nhân viên (một vai trò chung, không phân quyền). */
public class Staff9 extends Member9 {

    private String staffCode;  // mã nhân viên, VD NV-003
    private String position;  // chức vụ

    public Staff9() {
    }

    public String getStaffCode() {
        return staffCode;
    }

    public void setStaffCode(String staffCode) {
        this.staffCode = staffCode;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
}
