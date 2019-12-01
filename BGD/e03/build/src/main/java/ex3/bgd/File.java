package ex3.bgd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class File {
    private String name;
    private String file;
    private String hash;
    private String user;
    private Integer priority;
    private List<Tag> tags = new ArrayList<>();

    public File() {

    }

    public void addTag(Tag tag) {
        if (!tags.contains(tag)) {
            tags.add(tag);
        }
    }

    public void removeTag(Tag tag) {
        tags.remove(tag);
    }

    public Integer getPriority() {
        return priority;
    }

    public void setPriority(Integer priority) {
        if (priority > 5) {
            this.priority = 5;
        } else if (priority < 0) {
            this.priority = 0;
        } else {
            this.priority = priority;
        }
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
        result.put("priority", Integer.toString(priority));
        return result;
    }

    public static File fromMap(Map<String, String> source) {
        File result = new File();
        result.setName(source.get("name"));
        result.setUser(source.get("user"));
        result.setPriority(Integer.parseInt(source.get("priority")));
        result.setHash(source.get("hash"));
        return result;
    }

}