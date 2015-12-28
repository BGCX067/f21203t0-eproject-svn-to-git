/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import Entity.Collections;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Hung Nguyen
 */
@Local
public interface CollectionsFacadeLocal {

    void create(Collections collections);

    void edit(Collections collections);

    void remove(Collections collections);

    Collections find(Object id);

    List<Collections> findAll();

    List<Collections> findRange(int[] range);

    int count();

    /**
     *
     * @param status the value of status
     */
    List getCollections(boolean status);

    List listCollectionByLimit(int firstRow, int maxRow);
    
}
