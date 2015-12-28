/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import Entity.UserFriends;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Hung Nguyen
 */
@Local
public interface UserFriendsFacadeLocal {

    void create(UserFriends userFriends);

    void edit(UserFriends userFriends);

    void remove(UserFriends userFriends);

    UserFriends find(Object id);

    List<UserFriends> findAll();

    List<UserFriends> findRange(int[] range);

    int count();

    /**
     *
     * @param userID the value of userID
     * @param friend the value of friend
     * @return the boolean
     */
    boolean isRequestSent(final int userID, final int friend);

    List<UserFriends> pendingFriendRequest(final int userId);

    /**
     *
     * @param request the value of request
     * @return the boolean
     */
    boolean acceptFriendRequest(final int request);

    /**
     *
     * @param user_id the value of user_id
     */
    List<UserFriends> listMyFriends(final int user_id);

    void deletFriendByUser(final int userID);

    /**
     *
     * @param userID the value of userID
     * @param friend the value of friend
     * @return the int
     */
    UserFriends getUserFriendStatus(final int userID, final int friend);
    
}
