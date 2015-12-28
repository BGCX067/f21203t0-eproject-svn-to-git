/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import Entity.Admins;
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
public class AdminsFacade extends AbstractFacade<Admins> implements AdminsFacadeLocal {
    @PersistenceContext(unitName = "WebPhotoShare-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AdminsFacade() {
        super(Admins.class);
    }

    @Override
    public boolean Login(String username, String password) {
        Query query =   em.createNamedQuery("Admins.checkLogin");
        query.setParameter("username", username);
        query.setParameter("password", password);
        List<Admins> list = query.getResultList();
        if(list.isEmpty()){
            return false;
        }else{
            return true;
        }
    }
    
}
