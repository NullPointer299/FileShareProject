package model;

import java.io.BufferedWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class MyDriveDAO {

    private static Statement stat;
    private static Path srcPath = Paths.get("/home/nullpo299/IdeaProjects/FileShareService/out/artifacts/FileShareService_war_exploded/WEB-INF/uploaded/");

    static {
        Connection conn;
        try {
            conn = DriverManager.getConnection("jdbc:mariadb://localhost/MyDrive", "web", "pass");
            stat = conn.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static User login(String id, String pass) {
        System.out.println("[MyDriveDAO]method = login");
        System.out.println("[MyDriveDAO]id = " + id);
        System.out.println("[MyDriveDAO]pass = " + pass);
        String sql = String.format("SELECT FIRST_NAME, LAST_NAME, PUBLIC, PASSWORD FROM USERS WHERE ID='%s';", id);
        ResultSet rs = null;
        User user = null;
        try {
            rs = stat.executeQuery(sql);
            if (rs.first() && rs.getString("PASSWORD").equals(toEncryptedHashValue(pass))) {
                String fname = rs.getString("FIRST_NAME");
                String lname = rs.getString("LAST_NAME");
                int isPublic = rs.getInt("PUBLIC");
                user = new User(fname, lname, id, isPublic == 1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public static boolean createUser(String id, String firstName, String lastName, String pass) {
        System.out.println("[MyDriveDAO]method = createUser");
        System.out.println("[MyDriveDAO]id = " + id);
        System.out.println("[MyDriveDAO]firstName = " + firstName);
        System.out.println("[MyDriveDAO]lastName = " + lastName);
        System.out.println("[MyDriveDAO]pass = " + pass);
        String sql = String.format("INSERT INTO USERS VALUES('%s', '%s', '%s', '%s', %d);",
                id, firstName, lastName, toEncryptedHashValue(pass), 1);
        try {
            stat.executeUpdate(sql);
            Files.createDirectory(srcPath.resolve(id));
            Files.createDirectory(srcPath.resolve(id).resolve("home"));
            Files.createDirectory(srcPath.resolve(id).resolve("trash"));
            Files.createFile(srcPath.resolve(id).resolve("blacklist.dat"));
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return true;
    }

    public static List<User> searchUser(String keyword) {
        System.out.println("[MyDriveDAO]method = searchUser");
        System.out.println("[MyDriveDAO]keyword = " + keyword);
        return null;
    }

    public static Path getRootPath(String id) {
        System.out.println("[MyDriveDAO]method = getRootPath");
        System.out.println("[MyDriveDAO]id = " + id);
        return Paths.get("root_path");
    }

    public static List<User> getFav(String id) {
        System.out.println("[MyDriveDAO]method = getFav");
        System.out.println("[MyDriveDAO]id = " + id);
        return null;
    }

    public static List<File> move(Path path, String id) {
        System.out.println("[MyDriveDAO]method = move");
        System.out.println("[MyDriveDAO]path = " + path);
        System.out.println("[MyDriveDAO]id = " + id);
        List<File> targets = null;
        Path dir = srcPath.resolve(path);
        try {
            if (id == null) {
                targets = Files.list(dir).map(p -> {
                    boolean isDir = false;
                    if (Files.isDirectory(p))
                        isDir = true;
                    return new File(p.getFileName().toString(), srcPath.relativize(p.getParent()), isDir, true);
                }).collect(Collectors.toList());
            } else {
                Stream<String> lines = Files.lines(srcPath.resolve(id).resolve("blacklist.dat"));
                targets = Files.list(dir).map(p -> {
                    boolean isDir = false;
                    if (Files.isDirectory(p))
                        isDir = true;
                    return new File(p.getFileName().toString(), srcPath.relativize(p.getParent()), isDir, lines.anyMatch(s -> {
                        String[] ary = s.split(" ");
                        return srcPath.resolve(id).resolve("home").resolve(ary[0]).equals(p.getParent()) && ary[1].equals(p.getFileName());
                    }));
                }).collect(Collectors.toList());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        for (File f : targets) {
            System.out.println("[MyDriveDAO]file info");
            System.out.println(f);
        }
        return targets;
    }

    public static boolean mkdir(Path path) {
        System.out.println("[MyDriveDAO]method = mkdir");
        System.out.println("[MyDriveDAO]path = " + path);
        boolean isSuccess;
        Path target = srcPath.resolve(path);
        if (Files.exists(target)) {
            System.out.println("Directory is already exists!");
            isSuccess = false;
        } else {
            try {
                Files.createDirectory(target);
            } catch (IOException e) {
                e.printStackTrace();
            }
            isSuccess = true;
        }
        return isSuccess;
    }

    public static boolean updateName(String id, String firstName, String lastName) {
        System.out.println("[MyDriveDAO]method = updateName");
        System.out.println("[MyDriveDAO]id = "+id);
        System.out.println("[MyDriveDAO]firstName = "+firstName);
        System.out.println("[MyDriveDAO]lastName = "+lastName);
        int updCnt = 0;
        String sql = String.format("UPDATE USERS SET FIRST_NAME='%s', LAST_NAME='%s' WHERE ID='%s';", firstName, lastName, id);
        try {
            updCnt = stat.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return updCnt <= 0 ? false : true;
    }

    public static boolean updatePassword(String id, String newPass) {
        System.out.println("[MyDriveDAO]method = updatePassword");
        System.out.println("[MyDriveDAO]id = "+id);
        System.out.println("[MyDriveDAO]newPass = "+newPass);
        int updCnt = 0;
        String sql = String.format("UPDATE USERS SET PASSWORD='%s' WHERE ID='%s';", toEncryptedHashValue(newPass), id);
        try {
            updCnt = stat.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return updCnt <= 0 ? false : true;
    }

    public static boolean updatePublic(String id, int pub) {
        System.out.println("[MyDriveDAO]method=updatePublic");
        System.out.println("[MyDriveDAO]id = "+id);
        System.out.println("[MyDriveDAO]pub = "+pub);
        int updCnt = 0;
        String sql = String.format("UPDATE USERS SET PUBLIC=%d WHERE ID='%s';", pub, id);
        try {
            updCnt = stat.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return updCnt <= 0 ? false : true;
    }

    public static void writeBlacklist(String path, String name, String id) {
        BufferedWriter writer = null;
        try {
            writer = Files.newBufferedWriter(srcPath.resolve(id).resolve("blacklist.dat"));
            writer.append(path + " " + name);
            writer.newLine();
            writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static void eraceBlacklist(String path, String name, String id) {
        try {
            List<String> lines = Files.lines(srcPath.resolve(id).resolve("blacklist.dat")).filter(s -> {
                String[] split = s.split(" ");
                return !(split[0].equals(path) && split[1].equals(name));
            }).collect(Collectors.toList());
            BufferedWriter writer = Files.newBufferedWriter(srcPath.resolve(id).resolve("blacklist.dat"));
            lines.stream().forEach(s -> {
                try {
                    writer.append(s);
                    writer.newLine();
                    writer.flush();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            });
        } catch (IOException e) {
            e.printStackTrace();
        }
        // make code close();
    }

    private static String toEncryptedHashValue(String value) {
        MessageDigest md = null;
        StringBuilder sb = null;
        try {
            md = MessageDigest.getInstance("SHA-512");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        md.update(value.getBytes());
        sb = new StringBuilder();
        for (byte b : md.digest()) {
            String hex = String.format("%02x", b);
            sb.append(hex);
        }
        return sb.toString();
    }
}
