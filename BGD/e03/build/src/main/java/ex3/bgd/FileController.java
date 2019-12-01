package ex3.bgd;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import redis.clients.jedis.Jedis;

@RestController
public class FileController {

    public static Jedis jedis = new Jedis(System.getenv("REDIS_HOST"));
    private static String REDIS_FILEDATA = "fd";

    @PostMapping("/file")
    public void postFile(@RequestBody File file) {
        file.setHash(Integer.toString(file.hashCode()));
        jedis.hset(REDIS_FILEDATA, file.getHash(), file.getFile());
        jedis.hset(file.getHash(), file.toMap());
    }

    @GetMapping("/file")
    public List<File> getFile(@RequestParam String userName) {
    }

    @GetMapping("/filecount")
    public Integer getFileCount() {
        return 0;
    }
}