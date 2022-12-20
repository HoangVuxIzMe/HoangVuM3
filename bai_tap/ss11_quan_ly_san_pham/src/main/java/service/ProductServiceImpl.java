package service;

import model.Product;
import repository.IProductRepository;
import repository.ProductRepositoryImpl;

import java.util.List;

public class ProductServiceImpl implements IProductService{
    private IProductRepository productRepository = new ProductRepositoryImpl();
    @Override
    public List<Product> findAll() {
        return null;
    }

    @Override
    public Product findById(int id) {
        return null;
    }

    @Override
    public boolean add(Product product) {
        return productRepository.add(product);
    }

    @Override
    public boolean delete(int id) {
        return false;
    }
}
