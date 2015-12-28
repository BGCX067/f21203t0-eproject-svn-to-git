/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Hung Nguyen
 */
@Entity
@Table(name = "feedbacks", catalog = "WebPhotoShare", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Feedbacks.findAll", query = "SELECT f FROM Feedbacks f"),
    @NamedQuery(name = "Feedbacks.findByFeedbackId", query = "SELECT f FROM Feedbacks f WHERE f.feedbackId = :feedbackId"),
    @NamedQuery(name = "Feedbacks.findBySubject", query = "SELECT f FROM Feedbacks f WHERE f.subject = :subject"),
    @NamedQuery(name = "Feedbacks.findByStatus", query = "SELECT f FROM Feedbacks f WHERE f.status = :status"),
    @NamedQuery(name = "Feedbacks.findByFeedbackDate", query = "SELECT f FROM Feedbacks f WHERE f.feedbackDate = :feedbackDate"),
    @NamedQuery(name = "Feedbacks.findByReplyDate", query = "SELECT f FROM Feedbacks f WHERE f.replyDate = :replyDate")})
public class Feedbacks implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue( strategy = GenerationType.IDENTITY )
    @Basic(optional = false)
    @Column(name = "feedback_id", nullable = false)
    private Integer feedbackId;
    @Size(max = 255)
    @Column(name = "subject", length = 255)
    private String subject;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "message", length = 2147483647)
    private String message;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "reply", length = 2147483647)
    private String reply;
    @Basic(optional = false)
    @NotNull
    @Column(name = "status", nullable = false)
    private short status;
    @Column(name = "feedback_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date feedbackDate;
    @Column(name = "reply_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date replyDate;
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    @ManyToOne(optional = false)
    private Users userId;

    public Feedbacks() {
    }

    public Feedbacks(Integer feedbackId) {
        this.feedbackId = feedbackId;
    }

    public Feedbacks(Integer feedbackId, short status) {
        this.feedbackId = feedbackId;
        this.status = status;
    }

    public Integer getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(Integer feedbackId) {
        this.feedbackId = feedbackId;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public short getStatus() {
        return status;
    }

    public void setStatus(short status) {
        this.status = status;
    }

    public Date getFeedbackDate() {
        return feedbackDate;
    }

    public void setFeedbackDate(Date feedbackDate) {
        this.feedbackDate = feedbackDate;
    }

    public Date getReplyDate() {
        return replyDate;
    }

    public void setReplyDate(Date replyDate) {
        this.replyDate = replyDate;
    }

    public Users getUserId() {
        return userId;
    }

    public void setUserId(Users userId) {
        this.userId = userId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (feedbackId != null ? feedbackId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Feedbacks)) {
            return false;
        }
        Feedbacks other = (Feedbacks) object;
        if ((this.feedbackId == null && other.feedbackId != null) || (this.feedbackId != null && !this.feedbackId.equals(other.feedbackId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entity.Feedbacks[ feedbackId=" + feedbackId + " ]";
    }
    
}
