/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import Entity.Collections;
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
public class CollectionsFacade extends AbstractFacade<Collections> implements CollectionsFacadeLocal {
    @PersistenceContext(unitName = "WebPhotoShare-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CollectionsFacade() {
        super(Collections.class);
    }

    /**
     *
     * @param status the value of status
     */
    @Override
    public List getCollections(boolean status) {
        Query query =   em.createNamedQuery("Collections.findByStatus");
        query.setParameter("status", status);
        List<Collections> collections   =   query.getResultList();
        return collections;
    }
    @Override
    public List<Collections> listCollectionByLimit(int firstRow, int maxRow) {
        String  queryString =   "select * from collections order by collection_id DESC";
        return em.createNativeQuery(queryString,Collections.class).setMaxResults(maxRow).setFirstResult(firstRow).getResultList();
    }
    
}
