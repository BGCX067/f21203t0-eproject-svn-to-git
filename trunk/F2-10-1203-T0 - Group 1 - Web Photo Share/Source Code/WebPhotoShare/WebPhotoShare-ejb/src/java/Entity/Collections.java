/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Hung Nguyen
 */
@Entity
@Table(name = "collections", catalog = "WebPhotoShare", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Collections.findAll", query = "SELECT c FROM Collections c"),
    @NamedQuery(name = "Collections.findByCollectionId", query = "SELECT c FROM Collections c WHERE c.collectionId = :collectionId"),
    @NamedQuery(name = "Collections.findByTitle", query = "SELECT c FROM Collections c WHERE c.title = :title"),
    @NamedQuery(name = "Collections.findByStatus", query = "SELECT c FROM Collections c WHERE c.status = :status"),
    @NamedQuery(name = "Collections.findByDescription", query = "SELECT c FROM Collections c WHERE c.description = :description")})
public class Collections implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue( strategy = GenerationType.IDENTITY )
    @Basic(optional = false)
    @Column(name = "collection_id", nullable = false)
    private Integer collectionId;
    @Size(max = 255)
    @Column(name = "title", length = 255)
    private String title;
    @Basic(optional = false)
    @NotNull
    @Column(name = "status", nullable = false)
    private boolean status;
    @Size(max = 255)
    @Column(name = "description", length = 255)
    private String description;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "collectionId")
    private Collection<Images> imagesCollection;

    public Collections() {
    }

    public Collections(Integer collectionId) {
        this.collectionId = collectionId;
    }

    public Collections(Integer collectionId, boolean status) {
        this.collectionId = collectionId;
        this.status = status;
    }

    public Integer getCollectionId() {
        return collectionId;
    }

    public void setCollectionId(Integer collectionId) {
        this.collectionId = collectionId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @XmlTransient
    public Collection<Images> getImagesCollection() {
        return imagesCollection;
    }

    public void setImagesCollection(Collection<Images> imagesCollection) {
        this.imagesCollection = imagesCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (collectionId != null ? collectionId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Collections)) {
            return false;
        }
        Collections other = (Collections) object;
        if ((this.collectionId == null && other.collectionId != null) || (this.collectionId != null && !this.collectionId.equals(other.collectionId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entity.Collections[ collectionId=" + collectionId + " ]";
    }
    
}
