/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import Entity.UserFriends;
import Entity.Users;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Hung Nguyen
 */
@Stateless
public class UserFriendsFacade extends AbstractFacade<UserFriends> implements UserFriendsFacadeLocal {
    @PersistenceContext(unitName = "WebPhotoShare-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UserFriendsFacade() {
        super(UserFriends.class);
    }

    /**
     *
     * @param userID the value of userID
     * @param friend the value of friend
     * @return the boolean
     */
    @Override
    public boolean isRequestSent(final int userID, final int friend) {
        Query query = em.createNativeQuery("SELECT * from user_friends WHERE user_id=? AND friend=?");
        query.setParameter(1, userID);
        query.setParameter(2, friend);
        List    results =   query.getResultList();
        if(results.size() > 0)
            return true;
        return false;
    }

    /**
     *
     * @param friend
     * @return
     */
    @Override
    public List<UserFriends> pendingFriendRequest(final int friend) {
        Query query = em.createNativeQuery("SELECT * from user_friends WHERE friend=? AND request_status=0", UserFriends.class);
        query.setParameter(1, friend);
        return query.getResultList();
    }
    
    /**
     *
     * @param request the value of request
     * @return the boolean
     */
    @Override
    public boolean acceptFriendRequest(final int request) {
        return false;
    }

    /**
     *
     * @param user_id the value of user_id
     */
    @Override
    public List<UserFriends> listMyFriends(final int user_id) {
        Query query = em.createNativeQuery("(SELECT * from user_friends WHERE user_id=? AND request_status=1) UNION (SELECT * from user_friends WHERE friend=? AND request_status=1)", UserFriends.class);
        query.setParameter(1, user_id);
        query.setParameter(2, user_id);
        return query.getResultList();
    }

    @Override
    public void deletFriendByUser(final int userID) {
        Query query =   em.createNativeQuery("DELETE user_friends WHERE user_id=? OR friend=?");
        query.setParameter(1, userID);
        query.setParameter(2, userID);
        query.executeUpdate();
    }

    /**
     *
     * @param userID the value of userID
     * @param friend the value of friend
     * @return the int
     */
    @Override
    public UserFriends getUserFriendStatus(final int userID, final int friend) {
        Query query = em.createNativeQuery("SELECT * from user_friends WHERE (user_id=? AND friend=?) OR (user_id=? AND friend=?)", UserFriends.class);
        query.setParameter(1, userID);
        query.setParameter(2, friend);
        query.setParameter(3, friend);
        query.setParameter(4, userID);
        try {
            UserFriends uf  =   (UserFriends) query.getSingleResult();
            return uf;
        } catch (Exception e) {
            return null;
        }
    }
    
}
