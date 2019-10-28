package ex3.bgd;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.SortingParams;

@RestController
public class ProductController {
    private static Jedis jedis = new Jedis("localhost");
    private static String REDIS_PRODUCTDATA = "pd";
    private static String SORTED_KEY = "sorted";

    // Speichern/Hochladen von Dateien
    @RequestMapping(value = "/product", method = RequestMethod.POST)
    public void file(@RequestBody Product product) {
        System.out.println("Posting product >>>");
        System.out.println("price: " + Double.toString(product.getPrice()));
        product.setHash(Integer.toString(product.getName().hashCode()));

        jedis.lpush("all:products", product.getHash());
        jedis.hset(REDIS_PRODUCTDATA, product.getHash(), product.getName());
        jedis.hmset("product:".concat(product.getHash()), product.toMap());

        jedis.zadd(product.getCategory(), product.getPrice(), product.getHash());

        System.out.println("File was written with hash: " + product.getHash());
    }

    @RequestMapping(value = "/counter", method = RequestMethod.GET)
    public String counter() {
        return jedis.get("fcounter");
    }

    @RequestMapping(value = "/product", method = RequestMethod.GET, params = { "name" })
    public Product product(String name) {
        return Product.fromMap(jedis.hgetAll(Integer.toString(name.hashCode())));
    }

    @RequestMapping(value = "/products", method = RequestMethod.GET)
    public List<Product> products() {
        List<Product> products = new ArrayList<>();

        Collection<String> hashes = jedis.hgetAll(REDIS_PRODUCTDATA).values();

        for (String hash : hashes) {
            Product product = Product.fromMap(jedis.hgetAll("product:".concat(hash)));
            products.add(product);
        }

        return products;
    }

    @RequestMapping(value = "/category", method = RequestMethod.GET, params = { "category" })
    public List<Product> category(String category) {
        List<Product> products = new ArrayList<>();

        Collection<String> hashes = jedis.hgetAll(category).values();

        for (String hash : hashes) {
            Product product = Product.fromMap(jedis.hgetAll(hash));
            products.add(product);
        }

        return products;
    }

    @RequestMapping(value = "/cheapest", method = RequestMethod.GET)
    public List<Product> filesPrio() {
        List<Product> products = new ArrayList<>();

        jedis.sort("all:products", new SortingParams().alpha().by("product:*->price"));
        Set<String> hashes = jedis.zrange(SORTED_KEY, 0, 5);

        for (String hash : hashes) {
            Product product = Product.fromMap(jedis.hgetAll(hash));
            products.add(product);
        }

        return products;
    }

}