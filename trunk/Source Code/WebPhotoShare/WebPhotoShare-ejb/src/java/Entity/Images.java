/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Hung Nguyen
 */
@Entity
@Table(name = "images", catalog = "WebPhotoShare", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Images.findAll", query = "SELECT i FROM Images i ORDER BY i.imageId DESC"),
    @NamedQuery(name = "Images.findByImageId", query = "SELECT i FROM Images i WHERE i.imageId = :imageId"),
    @NamedQuery(name = "Images.findByTitle", query = "SELECT i FROM Images i WHERE i.title = :title"),
    @NamedQuery(name = "Images.findByFilename", query = "SELECT i FROM Images i WHERE i.filename = :filename"),
    @NamedQuery(name = "Images.findByPath", query = "SELECT i FROM Images i WHERE i.path = :path"),
    @NamedQuery(name = "Images.findByShareStatus", query = "SELECT i FROM Images i WHERE i.shareStatus = :shareStatus"),
    @NamedQuery(name = "Images.findByUploadDate", query = "SELECT i FROM Images i WHERE i.uploadDate = :uploadDate"),
    @NamedQuery(name = "Images.findByModifyDate", query = "SELECT i FROM Images i WHERE i.modifyDate = :modifyDate"),
    @NamedQuery(name = "Images.findAllImages", query = "SELECT i FROM Images i WHERE i.shareStatus=2 ORDER BY i.imageId DESC"),
})
public class Images implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue( strategy = GenerationType.IDENTITY )
    @Basic(optional = false)
    @Column(name = "image_id", nullable = false)
    private Integer imageId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "title", nullable = false, length = 255)
    private String title;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "description", length = 2147483647)
    private String description;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "filename", nullable = false, length = 255)
    private String filename;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "path", nullable = false, length = 255)
    private String path;
    @Basic(optional = false)
    @NotNull
    @Column(name = "share_status", nullable = false)
    private short shareStatus;
    @Column(name = "upload_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date uploadDate;
    @Column(name = "modify_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifyDate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "view_count", nullable = false)
    private int viewCount;
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    @ManyToOne(optional = false)
    private Users userId;
    @JoinColumn(name = "collection_id", referencedColumnName = "collection_id", nullable = false)
    @ManyToOne(optional = false)
    private Collections collectionId;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "imageId")
    private Collection<Comments> commentsCollection;

    public Images() {
    }

    public Images(Integer imageId) {
        this.imageId = imageId;
    }

    public Images(Integer imageId, String title, String filename, String path, short shareStatus, int viewCount) {
        this.imageId = imageId;
        this.title = title;
        this.filename = filename;
        this.path = path;
        this.shareStatus = shareStatus;
        this.viewCount = viewCount;
    }

    public Integer getImageId() {
        return imageId;
    }

    public void setImageId(Integer imageId) {
        this.imageId = imageId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public short getShareStatus() {
        return shareStatus;
    }

    public void setShareStatus(short shareStatus) {
        this.shareStatus = shareStatus;
    }

    public Date getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
    }

    public Date getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(Date modifyDate) {
        this.modifyDate = modifyDate;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public Users getUserId() {
        return userId;
    }

    public void setUserId(Users userId) {
        this.userId = userId;
    }

    public Collections getCollectionId() {
        return collectionId;
    }

    public void setCollectionId(Collections collectionId) {
        this.collectionId = collectionId;
    }

    @XmlTransient
    public Collection<Comments> getCommentsCollection() {
        return commentsCollection;
    }

    public void setCommentsCollection(Collection<Comments> commentsCollection) {
        this.commentsCollection = commentsCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (imageId != null ? imageId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Images)) {
            return false;
        }
        Images other = (Images) object;
        if ((this.imageId == null && other.imageId != null) || (this.imageId != null && !this.imageId.equals(other.imageId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entity.Images[ imageId=" + imageId + " ]";
    }
    
}
