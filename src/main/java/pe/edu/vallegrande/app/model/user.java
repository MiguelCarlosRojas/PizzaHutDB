package pe.edu.vallegrande.app.model;

public class user {
    private Integer id;
    private String name;
    private String password;
    private String role;
    private Integer branchId;

    public user() {
    }

    public user(Integer id, String name, String password, String role, Integer branchId) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.role = role;
        this.branchId = branchId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Integer getBranchId() {
        return branchId;
    }

    public void setBranchId(Integer branchId) {
        this.branchId = branchId;
    }

    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", role='" + role + '\'' +
                ", branchId=" + branchId +
                '}';
    }
}
