/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import Entity.Images;
import java.awt.Image;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Hung Nguyen
 */
@Local
public interface ImagesFacadeLocal {

    void create(Images images);

    void edit(Images images);

    void remove(Images images);

    Images find(Object id);

    List<Images> findAll();

    List<Images> findRange(int[] range);

    int count();

    /**
     *
     * @param userID the value of userID
     */
    List<Images> getImagesByUser(int userID);

    List viewAllImages();

    List<Images> listImageByLimit(int firstRow, int maxRow);

    int imageTotalRows();

    /**
     *
     * @param userId the value of userId
     * @return the int
     */
    int imageUserTotal(final int userId);
    /**
     *
     * @param collectionID the value of collectionID
     * @param maxRow the value of maxRow
     * @param firstRow the value of firstRow
     */
    List<Images> listImageCollectionByLimit(final int collectionID, int firstRow, int maxRow);

    /**
     *
     * @param collectionID the value of collectionID
     * @return the int
     */
    int imageCollectionTotalRow(final int collectionID);

    /**
     *
     * @param userID the value of userID
     */
    void deleteImageByUser(final int userID);

    /**
     *
     * @param cid the value of cid
     */
    void deleteImageOnDeleteCollection(final int cid);

    List ListImageAll(int firstRow, int maxRow);

}
