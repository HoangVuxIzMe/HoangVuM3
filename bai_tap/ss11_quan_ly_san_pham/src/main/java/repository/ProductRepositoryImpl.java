package repository;

import model.Product;

import java.util.ArrayList;
import java.util.List;

public class ProductRepositoryImpl implements IProductRepository{
    private static List<Product> products = new ArrayList<>();
    static {
        products.add(new Product(1, "Dien thoai", 100,"SmartPhone", "Samsung"));
        products.add(new Product(2, "May tinh", 150,"Laptop Gaming", "Dell"));
        products.add(new Product(3, "Television", 200,"TV Full HD", "Sony"));
        products.add(new Product(4, "Headphone", 250,"Tai nghe gaming", "JBL"));
    }
    @Override
    public List<Product> findAll() {
        return products;
    }

    @Override
    public Product findById(int id) {
        return null;
    }

    @Override
    public boolean add(Product product) {
        return products.add(product);
    }

    @Override
    public boolean delete(int id) {
        return false;
    }
}
