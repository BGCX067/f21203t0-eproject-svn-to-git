/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import Entity.Faqs;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Hung Nguyen
 */
@Stateless
public class FaqsFacade extends AbstractFacade<Faqs> implements FaqsFacadeLocal {
    @PersistenceContext(unitName = "WebPhotoShare-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public FaqsFacade() {
        super(Faqs.class);
    }

    @Override
    public List<Faqs> listFaqByLimit(final int firstRow, final int maxRow) {
        String  queryString =   "select * from faqs order by faq_id DESC";
        return em.createNativeQuery(queryString,Faqs.class).setMaxResults(maxRow).setFirstResult(firstRow).getResultList();
    }

    
}
