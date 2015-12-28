/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

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
public class UsersFacade extends AbstractFacade<Users> implements UsersFacadeLocal {
    @PersistenceContext(unitName = "WebPhotoShare-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UsersFacade() {
        super(Users.class);
    }

    @Override
    public boolean Login(String username, String password) {
        Query query =   em.createNamedQuery("Users.checkLogin");
        query.setParameter("username", username);
        query.setParameter("password", password);
        List<Users> list = query.getResultList();
        if(list.isEmpty()){
            return false;
        }else{
            return true;
        }
    }

    @Override
    public List findByUserName(String username) {
        Query query =   em.createNamedQuery("Users.findByUsername");
        query.setParameter("username", username);
        List<Users> list = query.getResultList();
        return list;
    }

    /**
     *
     * @param email the value of email
     * @return the Users
     */
    @Override
    public Users findUserByEmail(String email) {
        Query query =   em.createNamedQuery("Users.findByEmail");
        query.setParameter("email", email);
        try {
            Users user  =   (Users) query.getSingleResult();
            return user;
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public int getUserIdFromUserName(final String username) {
        Query query =   em.createNamedQuery("Users.findByUsername");
        query.setParameter("username", username);
        Users user  =   (Users) query.getSingleResult();
        return user.getUserId();
    }

    /**
     *
     * @param userID the value of userID
     * @param email the value of email
     * @return the boolean
     */
    @Override
    public boolean isDuplidateEmail(final int userID, final String email) {
        Query query =   em.createNativeQuery("SELECT * FROM users WHERE email=? AND user_id != ?");
        query.setParameter(1, email);
        query.setParameter(2, userID);
        List<Users> list = query.getResultList();
        if(list.size() > 0){
            return true;
        }else{
            return false;
        }
    }
    @Override
    public List<Users> FindUserValidating() {
        Query query =   em.createNamedQuery("Users.findValidating");
        List<Users> list = query.getResultList();
        return list;
    }

    @Override
    public List FindUserDeclined() {
        Query query =   em.createNamedQuery("Users.findDeclined");
        List<Users> list = query.getResultList();
        return list;
    }

    @Override
    public Users getLastestUser() {
        Query query =   em.createNativeQuery("SELECT TOP 1 * FROM users ORDER BY user_id DESC", Users.class);
        try {
            Users user  =   (Users) query.getSingleResult();
            return user;
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public Users findUserByKey(final String key) {
        Query query =   em.createNativeQuery("SELECT * FROM users WHERE reset_password_key=?", Users.class);
        query.setParameter(1, key);
        try {
            Users user  =   (Users) query.getSingleResult();
            return user;
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Users> listUserByLimit(final int firstRow, final int maxRow) {
        String  queryString =   "select * from users order by user_id DESC";
        return em.createNativeQuery(queryString,Users.class).setMaxResults(maxRow).setFirstResult(firstRow).getResultList();
    }

    @Override
    public List<Users> listUserValidatingByLimit(int firstRow, int maxRow) {
        String  queryString =   "select * from users where user_status = 0 order by user_id DESC";
        return em.createNativeQuery(queryString,Users.class).setMaxResults(maxRow).setFirstResult(firstRow).getResultList();
    }

    @Override
    public List<Users> listUserDeclinedByLimit(final int firstRow, final int maxRow) {
        String  queryString =   "select * from users where user_status = 2 order by user_id DESC";
        return em.createNativeQuery(queryString,Users.class).setMaxResults(maxRow).setFirstResult(firstRow).getResultList();
    }

    
}