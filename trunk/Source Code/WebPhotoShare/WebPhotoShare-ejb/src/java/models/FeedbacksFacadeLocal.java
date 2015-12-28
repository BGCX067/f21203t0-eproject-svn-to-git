/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import Entity.Feedbacks;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Hung Nguyen
 */
@Local
public interface FeedbacksFacadeLocal {

    void create(Feedbacks feedbacks);

    void edit(Feedbacks feedbacks);

    void remove(Feedbacks feedbacks);

    Feedbacks find(Object id);

    List<Feedbacks> findAll();

    List<Feedbacks> findRange(int[] range);

    int count();

    /**
     *
     * @param userID the value of userID
     */
    void deleteFeedbackByUser(final int userID);
    
}
