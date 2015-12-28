/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import Entity.Comments;
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
public class CommentsFacade extends AbstractFacade<Comments> implements CommentsFacadeLocal {
    @PersistenceContext(unitName = "WebPhotoShare-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CommentsFacade() {
        super(Comments.class);
    }

    @Override
    public List<Comments> imageComment(final int imageID) {
        Query query = em.createNativeQuery("SELECT * from comments WHERE image_id=? ORDER BY comment_id DESC", Comments.class);
        query.setParameter(1, imageID);
        return query.getResultList();
    }

    /**
     *
     * @param userID the value of userID
     */
    @Override
    public void deleteCommentByUser(final int userID) {
        Query query =   em.createNativeQuery("DELETE comments WHERE user_id=?");
        query.setParameter(1, userID);
        query.executeUpdate();
    }

    @Override
    public void deleteCommentOnDeleteCollection(final int cid) {
        Query query =   em.createNativeQuery("DELETE comments WHERE image_id IN (SELECT image_id FROM images WHERE collection_id=?)");
        query.setParameter(1, cid);
        query.executeUpdate();
    }

    @Override
    public void deleteCommnetByImage(final int imageId) {
        Query query =   em.createNativeQuery("DELETE comments WHERE image_id=?");
        query.setParameter(1, imageId);
        query.executeUpdate();
    }
    
}
