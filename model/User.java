package model;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

public class User {
    private String firstName;
    private String lastName;
    private final String id;
    private boolean isPublic;
    //caches
    private List<File> home;
    private List<File> trash;
    private List<User> fav;

    public User(String firstName, String lastName, String id, boolean isPublic) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.id = id;
        this.isPublic = isPublic;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getFullName() {
        return lastName + " " + firstName;
    }

    public String getId() {
        return id;
    }

    public boolean isPublic() {
        return isPublic;
    }

    public List<File> getHome() {
        return home;
    }

    public List<File> getTrash() {
        return trash;
    }

    public List<User> getFav() {
        return fav;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public boolean setIsPublic(boolean val) {
        return isPublic = val;
    }

    public List<File> setHome(List<File> home) {
        return this.home = home;
    }

    public List<File> setTrash(List<File> trash) {
        return this.trash = trash;
    }

    public List<User> setFav(List<User> fav) {
        return this.fav = fav;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("firstName = ").append(firstName).append("\n");
        sb.append("lastName = ").append(lastName).append("\n");
        sb.append("id = ").append(id).append("\n");
        sb.append("home = ").append(home).append("\n");
        sb.append("trash = ").append(trash).append("\n");
        sb.append("fav = ").append(fav).append("\n");
        return sb.toString();
    }
}
