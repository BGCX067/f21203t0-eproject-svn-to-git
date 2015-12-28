/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import Entity.Images;
import java.awt.Image;
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
public class ImagesFacade extends AbstractFacade<Images> implements ImagesFacadeLocal {
    @PersistenceContext(unitName = "WebPhotoShare-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ImagesFacade() {
        super(Images.class);
    }

    /**
     * List of images by user
     *
     * @param userID the value of userID
     */
    @Override
    public List<Images> getImagesByUser(int userID) {
        Query query = em.createNativeQuery("SELECT * from images WHERE user_id=? ORDER BY image_id DESC", Images.class);
        query.setParameter(1, userID);
        List results = query.getResultList();
        return results;
    }

    @Override
    public List viewAllImages() {
        Query query =   em.createNamedQuery("Images.findAllImages");
        List<Images> images =   query.getResultList();
        return images;
    }
    
    /**
    * Returns list of image list starting at the given first index with the given max row count.
    * @return list of image list starting at the given first index with the given max row count.
    */
    @Override
    public List<Images> listImageByLimit(int firstRow, int maxRow) {
        String  queryString =   "select * from images \n" +
"LEFT JOIN collections\n" +
"	ON images.collection_id = collections.collection_id\n" +
"LEFT JOIN users\n" +
"	ON images.user_id = users.user_id\n" +
"WHERE \n" +
"	share_status=2 \n" +
"	AND collections.status=1\n" +
"	AND users.user_status=1\n" +
"order by image_id DESC";
        return em.createNativeQuery(queryString,Images.class).setMaxResults(maxRow).setFirstResult(firstRow).getResultList();
    }
    
    /**
      * Returns total amount of rows in table.
      * @return Total amount of rows in table.
      */
    @Override
    public int imageTotalRows() {
        String  queryString =   "select * from images \n" +
"LEFT JOIN collections\n" +
"	ON images.collection_id = collections.collection_id\n" +
"LEFT JOIN users\n" +
"	ON images.user_id = users.user_id\n" +
"WHERE \n" +
"	share_status=2 \n" +
"	AND collections.status=1\n" +
"	AND users.user_status=1\n" +
"order by image_id DESC";
        Query query = em.createNativeQuery(queryString);
        List results = query.getResultList();
        return results.size();
    }

    /**
     *
     * @param userId the value of userId
     * @return the int
     */
    @Override
    public int imageUserTotal(final int userId) {
        String  queryString = "select * from images WHERE user_id=? order by image_id DESC";
        Query   query       =   em.createNativeQuery(queryString);
        query.setParameter(1, userId);
        List results = query.getResultList();
        return results.size();
    }

    /**
     *
     * @param collectionID the value of collectionID
     * @param maxRow the value of maxRow
     * @param firstRow the value of firstRow
     */
    @Override
    public List<Images> listImageCollectionByLimit(final int collectionID, int firstRow, int maxRow) {
        String  queryString =   "select * from images WHERE share_status=2 AND collection_id="+collectionID+" order by image_id DESC";
        return em.createNativeQuery(queryString,Images.class).setMaxResults(maxRow).setFirstResult(firstRow).getResultList();
    }

    /**
     * Count total images by collection
     * @param collectionID the value of collectionID
     * @return the int
     */
    @Override
    public int imageCollectionTotalRow(final int collectionID) {
        String queryString = "select * from images WHERE share_status=2 AND collection_id="+collectionID+" order by image_id DESC";
        Query query = em.createNativeQuery(queryString);
        List results = query.getResultList();
        return results.size();
    }

    /**
     * Delete image on delete user
     *
     * @param userID the value of userID
     */
    @Override
    public void deleteImageByUser(final int userID) {
        Query query =   em.createNativeQuery("DELETE images WHERE user_id=?");
        query.setParameter(1, userID);
        query.executeUpdate();
    }

    /**
     * Delete image on delete collection
     *
     * @param cid the value of cid
     */
    @Override
    public void deleteImageOnDeleteCollection(final int cid) {
        Query query =   em.createNativeQuery("DELETE images WHERE collection_id=?");
        query.setParameter(1, cid);
        query.executeUpdate();
    }

    @Override
    public List<Image> ListImageAll(int firstRow, int maxRow) {
        String  queryString =   "select * from images order by image_id DESC";
        return em.createNativeQuery(queryString,Images.class).setMaxResults(maxRow).setFirstResult(firstRow).getResultList();
    }
    
}