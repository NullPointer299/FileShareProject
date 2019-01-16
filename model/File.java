package model;

import java.nio.file.Path;

public class File {
    private final String name;
    private final Path path;
    private final boolean isDirectory;
    private boolean isPublic;

    public File(String name, Path path, boolean isDirectories, boolean isPublic) {
        this.name = name;
        this.path = path;
        this.isDirectory = isDirectories;
        this.isPublic = isPublic;
    }

    public String getName() {
        return name;
    }

    public Path getPath() {
        return path;
    }

    public boolean isDirectory() {
        return isDirectory;
    }

    public boolean isPublic() {
        return isPublic;
    }

    public void setPublic(boolean aPublic) {
        isPublic = aPublic;
    }

    @Override
    public String toString() {
        return "name = " + name + "\n" +
                "path = " + path + "\n" +
                "isPublic = " + isPublic + "\n";
    }
}
