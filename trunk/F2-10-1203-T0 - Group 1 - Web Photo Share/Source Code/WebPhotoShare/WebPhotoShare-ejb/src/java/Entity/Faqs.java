/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Hung Nguyen
 */
@Entity
@Table(name = "faqs", catalog = "WebPhotoShare", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Faqs.findAll", query = "SELECT f FROM Faqs f"),
    @NamedQuery(name = "Faqs.findByFaqId", query = "SELECT f FROM Faqs f WHERE f.faqId = :faqId"),
    @NamedQuery(name = "Faqs.findByQuestion", query = "SELECT f FROM Faqs f WHERE f.question = :question")})
public class Faqs implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue( strategy = GenerationType.IDENTITY )
    @Basic(optional = false)
    @Column(name = "faq_id", nullable = false)
    private Integer faqId;
    @Size(max = 255)
    @Column(name = "question", length = 255)
    private String question;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "answer", length = 2147483647)
    private String answer;

    public Faqs() {
    }

    public Faqs(Integer faqId) {
        this.faqId = faqId;
    }

    public Integer getFaqId() {
        return faqId;
    }

    public void setFaqId(Integer faqId) {
        this.faqId = faqId;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (faqId != null ? faqId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Faqs)) {
            return false;
        }
        Faqs other = (Faqs) object;
        if ((this.faqId == null && other.faqId != null) || (this.faqId != null && !this.faqId.equals(other.faqId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entity.Faqs[ faqId=" + faqId + " ]";
    }
    
}
