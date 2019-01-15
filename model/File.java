package model;

import java.nio.file.Path;

public class File {
    private final String name;
    private final Path path;
    private final boolean isPublic;

    public File(String name, Path path, boolean isPublic) {
        this.name = name;
        this.path = path;
        this.isPublic = isPublic;
    }

    public String getName() {
        return name;
    }

    public Path getPath() {
        return path;
    }

    public boolean isPublic() {
        return isPublic;
    }

    @Override
    public String toString() {
        return "name = " + name + "\n" +
                "path = " + path + "\n" +
                "isPublic = " + isPublic + "\n";
    }
}
