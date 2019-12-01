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
public class ProductController {
    private static Jedis jedis = new Jedis("localhost");
    private static String REDIS_PRODUCTDATA = "pd";
    private static String SORTED_KEY = "sorted";

    // Speichern/Hochladen von Dateien
    @RequestMapping(value = "/product", method = RequestMethod.POST)
    public void file(@RequestBody Product product) {
        product.setHash(Integer.toString(product.getName().hashCode()));

        jedis.sadd(REDIS_PRODUCTDATA, product.getHash());
        jedis.sadd(product.getCategory(), product.getHash());
        jedis.hset(product.getHash(), product.toMap());

        jedis.zadd(SORTED_KEY, product.getPrice(), product.getHash());
    }

    @RequestMapping(value = "/product", method = RequestMethod.GET, params = { "name" })
    public Product product(String name) {
        return Product.fromMap(jedis.hgetAll(Integer.toString(name.hashCode())));
    }

    @RequestMapping(value = "/products", method = RequestMethod.GET)
    public List<Product> products() {
        List<Product> products = new ArrayList<>();

        Set<String> hashes = jedis.smembers(REDIS_PRODUCTDATA);

        for (String hash : hashes) {
            Product product = Product.fromMap(jedis.hgetAll(hash));
            products.add(product);
        }

        return products;
    }

    @RequestMapping(value = "/category", method = RequestMethod.GET, params = { "category" })
    public List<Product> category(String category) {
        List<Product> products = new ArrayList<>();

        Set<String> hashes = jedis.smembers(category);

        for (String hash : hashes) {
            Product product = Product.fromMap(jedis.hgetAll(hash));
            products.add(product);
        }

        return products;
    }

    @RequestMapping(value = "/cheapest", method = RequestMethod.GET)
    public List<Product> filesPrio() {
        List<Product> products = new ArrayList<>();

        Set<String> hashes = jedis.zrange(SORTED_KEY, 0, 4);

        for (String hash : hashes) {
            Product product = Product.fromMap(jedis.hgetAll(hash));
            products.add(product);
        }

        return products;
    }

}