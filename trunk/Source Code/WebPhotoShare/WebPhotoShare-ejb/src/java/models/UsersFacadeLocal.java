/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import Entity.Users;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Hung Nguyen
 */
@Local
public interface UsersFacadeLocal {

    void create(Users users);

    void edit(Users users);

    void remove(Users users);

    Users find(Object id);

    List<Users> findAll();

    List<Users> findRange(int[] range);

    int count();

    boolean Login(String username, String password);

    List findByUserName(String username);

    /**
     *
     * @param email the value of email
     * @return the Users
     */
    Users findUserByEmail(String email);

    List FindUserValidating();

    List FindUserDeclined();

    int getUserIdFromUserName(final String username);

    /**
     *
     * @param userID the value of userID
     * @param email the value of email
     * @return the boolean
     */
    boolean isDuplidateEmail(final int userID, final String email);

    Users getLastestUser();

    Users findUserByKey(final String key);

    List<Users> listUserByLimit(final int firstRow, final int maxRow);

    List listUserValidatingByLimit(int firstRow, int maxRow);

    List listUserDeclinedByLimit(final int firstRow, final int maxRow);



    
}
