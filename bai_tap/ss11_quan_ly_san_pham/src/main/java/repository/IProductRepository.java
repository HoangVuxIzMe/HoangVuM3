package repository;

import model.Product;

import java.util.List;

public interface IProductRepository {
    List<Product> findAll();
    Product findById(int id);
    boolean add(Product product);
    boolean delete(int id);
}
