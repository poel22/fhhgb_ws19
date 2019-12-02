package ex3.bgd;

import java.util.HashMap;
import java.util.Map;

public class File {
    private String name;
    private String file;
    private String hash;
    private String user;
    private int priority;

    public File() {

    }

    public int getPriority() {
        return priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    public String getName() {
        return name;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getHash() {
        return hash;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }

    public String getFile() {
        return file;
    }

    public void setFile(String file) {
        this.file = file;
    }

    public void setName(String name) {
        this.name = name;
    }


    public Map<String, String> toMap() {
        Map<String, String> result = new HashMap<>();
        result.put("name", name);
        result.put("user", user);
        result.put("hash", hash);
        
        return result;
    }

    public static File fromMap(Map<String, String> map) {
        File result = new File();

        result.setName(map.get("name"));
        result.setUser(map.get("user"));
        result.setHash(map.get("hash"));

        return result;
    }



}