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
import javax.persistence.Lob;
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
@Table(name = "contact", catalog = "WebPhotoShare", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Contact.findAll", query = "SELECT c FROM Contact c"),
    @NamedQuery(name = "Contact.findByContactId", query = "SELECT c FROM Contact c WHERE c.contactId = :contactId"),
    @NamedQuery(name = "Contact.findByContactName", query = "SELECT c FROM Contact c WHERE c.contactName = :contactName"),
    @NamedQuery(name = "Contact.findByContactEmail", query = "SELECT c FROM Contact c WHERE c.contactEmail = :contactEmail"),
    @NamedQuery(name = "Contact.findByContactSubject", query = "SELECT c FROM Contact c WHERE c.contactSubject = :contactSubject"),
    @NamedQuery(name = "Contact.findByContactStatus", query = "SELECT c FROM Contact c WHERE c.contactStatus = :contactStatus"),
    @NamedQuery(name = "Contact.findByContactDate", query = "SELECT c FROM Contact c WHERE c.contactDate = :contactDate"),
    @NamedQuery(name = "Contact.findByReplyDate", query = "SELECT c FROM Contact c WHERE c.replyDate = :replyDate")})
public class Contact implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue( strategy = GenerationType.IDENTITY )
    @Basic(optional = false)
    @Column(name = "contact_id", nullable = false)
    private Integer contactId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "contact_name", nullable = false, length = 255)
    private String contactName;
    @Size(max = 255)
    @Column(name = "contact_email", length = 255)
    private String contactEmail;
    @Size(max = 255)
    @Column(name = "contact_subject", length = 255)
    private String contactSubject;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "contact_message", length = 2147483647)
    private String contactMessage;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "contact_reply", length = 2147483647)
    private String contactReply;
    @Basic(optional = false)
    @NotNull
    @Column(name = "contact_status", nullable = false)
    private short contactStatus;
    @Column(name = "contact_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date contactDate;
    @Column(name = "reply_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date replyDate;

    public Contact() {
    }

    public Contact(Integer contactId) {
        this.contactId = contactId;
    }

    public Contact(Integer contactId, String contactName, short contactStatus) {
        this.contactId = contactId;
        this.contactName = contactName;
        this.contactStatus = contactStatus;
    }

    public Integer getContactId() {
        return contactId;
    }

    public void setContactId(Integer contactId) {
        this.contactId = contactId;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getContactEmail() {
        return contactEmail;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public String getContactSubject() {
        return contactSubject;
    }

    public void setContactSubject(String contactSubject) {
        this.contactSubject = contactSubject;
    }

    public String getContactMessage() {
        return contactMessage;
    }

    public void setContactMessage(String contactMessage) {
        this.contactMessage = contactMessage;
    }

    public String getContactReply() {
        return contactReply;
    }

    public void setContactReply(String contactReply) {
        this.contactReply = contactReply;
    }

    public short getContactStatus() {
        return contactStatus;
    }

    public void setContactStatus(short contactStatus) {
        this.contactStatus = contactStatus;
    }

    public Date getContactDate() {
        return contactDate;
    }

    public void setContactDate(Date contactDate) {
        this.contactDate = contactDate;
    }

    public Date getReplyDate() {
        return replyDate;
    }

    public void setReplyDate(Date replyDate) {
        this.replyDate = replyDate;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (contactId != null ? contactId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Contact)) {
            return false;
        }
        Contact other = (Contact) object;
        if ((this.contactId == null && other.contactId != null) || (this.contactId != null && !this.contactId.equals(other.contactId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entity.Contact[ contactId=" + contactId + " ]";
    }
    
}
