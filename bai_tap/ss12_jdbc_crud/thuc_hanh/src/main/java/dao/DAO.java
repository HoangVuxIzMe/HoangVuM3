package dao;

import com.mysql.jdbc.Driver;
import model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAO implements IDAO {
    private static final String INSERT_USERS_SQL = "INSERT INTO users" + "  (name, email, country) VALUES " +
            " (?, ?, ?);";
    private static final String SEARCH_USER_BY_COUNTRY = "select * from users where country like ?;";
    private static final String SELECT_USER_BY_ID = "select id,name,email,country from users where id =?";
    private static final String SELECT_ALL_USERS = "select * from users";
    private static final String DELETE_USERS_SQL = "delete from users where id = ?;";
    private static final String UPDATE_USERS_SQL = "update users set name = ?,email= ?, country =? where id = ?;";

    public DAO() {
    }


    @Override
    public void insertUser(User user) throws SQLException {
        System.out.println(INSERT_USERS_SQL);
        // try-catch tu dong dong ket noi (auto close the connection)
        try (Connection connection = BaseDAO.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL)) {
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getCountry());
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    @Override
    public User selectUser(int id) {
        User user = null;
        // Step 1: Establishing a Connection (Thiet lap ket noi)
        try (Connection connection = BaseDAO.getConnectDB();
             // Step 2: Create a statement using connection object (Tao cau lenh su dung doi tuong ket noi)
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_ID);) {
            preparedStatement.setInt(1, id);
            System.out.println(preparedStatement);
            // Step 3: Execute the query or update query (Thuc hien truy van hoac cap nhat truy van)
            ResultSet resultSet = preparedStatement.executeQuery();
            // Step 4: Process the ResultSet object. ( Xu ly doi tuong Result )
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country = resultSet.getString("country");
                user = new User(id, name, email, country);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return user;
    }

    @Override
    public List<User> selectAllUser() {
        List<User> users = new ArrayList<>();
        // Step 1: Establishing a Connection (Thiet lap ket noi)
        try (Connection connection = BaseDAO.getConnectDB();
             // Step 2: Create a statement using connection object (Tao cau lenh su dung doi tuong ket noi)
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_USERS);) {
            System.out.println(preparedStatement);
            // Step 3: Execute the query or update query (Thuc hien truy van hoac cap nhat truy van)
            ResultSet resultSet = preparedStatement.executeQuery();
            // Step 4: Process the ResultSet object. ( Xu ly doi tuong Result )
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country = resultSet.getString("country");
                users.add(new User(id, name, email, country));
            }
        } catch (SQLException exception) {
            printSQLException(exception);
        }
        return users;
    }

    @Override
    public List<User> searchCountry(String countrySearch) {
        List<User> users = new ArrayList<>();
        try (Connection connection = BaseDAO.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(SEARCH_USER_BY_COUNTRY)) {
            preparedStatement.setString(1, "%" + countrySearch + "%");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country = resultSet.getString("country");
                users.add(new User(id, name, email, country));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return users;
    }

    @Override
    public boolean deleteUser(int id) throws SQLException {
        boolean rowDelete;
        try (Connection connection = BaseDAO.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_USERS_SQL);) {
            preparedStatement.setInt(1, id);

            rowDelete = preparedStatement.executeUpdate() > 0;
        }
        return rowDelete;
    }

    @Override
    public boolean updateUser(User user) throws SQLException {
        boolean rowUpdate;
        try (Connection connection = BaseDAO.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USERS_SQL);) {
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(1, user.getCountry());
            preparedStatement.setInt(1, user.getId());

            rowUpdate = preparedStatement.executeUpdate() > 0;
        }
        return rowUpdate;
    }

    private void printSQLException(SQLException exception) {
        for (Throwable e : exception) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("ERROR CODE: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = exception.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
