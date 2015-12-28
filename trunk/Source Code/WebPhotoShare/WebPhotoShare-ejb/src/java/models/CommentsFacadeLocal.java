/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import Entity.Comments;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Hung Nguyen
 */
@Local
public interface CommentsFacadeLocal {

    void create(Comments comments);

    void edit(Comments comments);

    void remove(Comments comments);

    Comments find(Object id);

    List<Comments> findAll();

    List<Comments> findRange(int[] range);

    int count();

    List<Comments> imageComment(final int imageID);

    /**
     *
     * @param userID the value of userID
     */
    void deleteCommentByUser(final int userID);

    void deleteCommentOnDeleteCollection(final int cid);

    void deleteCommnetByImage(final int imageId);
    
}
