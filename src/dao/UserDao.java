package dao;

import domain.User;

public class UserDao extends Dao<User>{

    public String getPasswordByNameOrEmail(String emailOrName){
        String sql = "SELECT Pass FROM traveluser WHERE UserName = ? OR Email = ?";
        String password = getForValues(sql,emailOrName,emailOrName);
        return password;
    }

    public User getUserByNameOrEmail(String emailOrName){
        String sql = "SELECT Pass password, UID uid, UserName username, Email email, State state FROM traveluser WHERE UserName = ? OR Email = ?";
        //System.out.println(user);
        return get(sql,emailOrName,emailOrName);
    }

    public long getCountWithName(String name) {
        String sql = "SELECT count(*) FROM traveluser WHERE UserName = ?";
        return getForValues(sql,name);
    }

    public boolean save(User user){
        String sql = "INSERT INTO traveluser (UserName, Email, Pass) VALUES (?,?,?)";
        return update(sql,user.getUsername(),user.getEmail(),user.getPassword());
    }
}
