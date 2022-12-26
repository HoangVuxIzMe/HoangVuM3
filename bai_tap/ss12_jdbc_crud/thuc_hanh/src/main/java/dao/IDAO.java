package dao;

import model.User;

import java.sql.SQLException;
import java.util.List;

public interface IDAO {
    void insertUser (User user) throws SQLException;
    User selectUser (int id);
    List<User> selectAllUser();
    List<User> searchCountry(String countrySearch);
    boolean deleteUser(int id) throws SQLException;
    boolean updateUser(User user) throws SQLException;
}
