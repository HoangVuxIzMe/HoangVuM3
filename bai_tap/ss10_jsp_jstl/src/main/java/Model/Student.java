package Model;

public class Student {
    private String name;
    private String birthday;
    private String address;
    private String addressImage;

    public Student(String name, String birthday, String address, String addressImage) {
        this.name = name;
        this.birthday = birthday;
        this.address = address;
        this.addressImage = addressImage;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAddressImage() {
        return addressImage;
    }

    public void setAddressImage(String addressImage) {
        this.addressImage = addressImage;
    }
}
