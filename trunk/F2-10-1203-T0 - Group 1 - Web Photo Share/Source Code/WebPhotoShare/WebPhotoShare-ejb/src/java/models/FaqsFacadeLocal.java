/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import Entity.Faqs;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Hung Nguyen
 */
@Local
public interface FaqsFacadeLocal {

    void create(Faqs faqs);

    void edit(Faqs faqs);

    void remove(Faqs faqs);

    Faqs find(Object id);

    List<Faqs> findAll();

    List<Faqs> findRange(int[] range);

    int count();

    List listFaqByLimit(final int firstRow, final int maxRow);

    
}
