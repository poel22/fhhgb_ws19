package ex3.bgd;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import redis.clients.jedis.Jedis;

@RestController
public class FileController {
    private static Jedis jedis = new Jedis(System.getenv("REDIS_HOST"));
    private static String REDIS_FILEDATA = "fd";

    // Speichern/Hochladen von Dateien
    @RequestMapping(value ="/file", method = RequestMethod.POST)
    public void file(@RequestBody File file) {
        file.setHash(Integer.toString(file.getFile().hashCode()));

        jedis.hset(REDIS_FILEDATA, file.getHash(), file.getFile());
        jedis.hset(file.getHash(), file.toMap());

        // b)
        jedis.zadd(file.getUser(), file.getPriority(), file.getHash());

        // d)
        jedis.incr("fcounter");

        System.out.println("File was written with hash: " + file.getHash());
    }

    @RequestMapping(value ="/counter", method = RequestMethod.GET)
    public String counter() {
        return jedis.get("fcounter");
    }

    @RequestMapping(value ="/file", method = RequestMethod.GET, params = {"hash"})
    public String file(String hash) {
        return jedis.hget(REDIS_FILEDATA, hash);
    }

    @RequestMapping(value ="/files", method = RequestMethod.GET, params = {"user"})
    public List<File> files(String user) {
        List<File> files = new ArrayList<File>();

        Set<String> hashes = jedis.zrange(user, 0, -1);

        for(String hash : hashes) {
            File file = File.fromMap(jedis.hgetAll(hash));
            files.add(file);
        }

        return files;
    }

    @RequestMapping(value ="/filesprio", method = RequestMethod.GET, params = {"user"})
    public List<File> filesPrio(String user) {
        List<File> files = new ArrayList<File>();

        Set<String> hashes = jedis.zrange(user, -5, -1);

        for(String hash : hashes) {
            File file = File.fromMap(jedis.hgetAll(hash));
            files.add(file);
        }

        return files;
    }

}