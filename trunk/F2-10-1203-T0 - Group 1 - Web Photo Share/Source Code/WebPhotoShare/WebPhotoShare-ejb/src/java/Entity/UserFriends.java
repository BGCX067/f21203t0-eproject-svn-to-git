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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Hung Nguyen
 */
@Entity
@Table(name = "user_friends", catalog = "WebPhotoShare", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "UserFriends.findAll", query = "SELECT u FROM UserFriends u"),
    @NamedQuery(name = "UserFriends.findByFriendId", query = "SELECT u FROM UserFriends u WHERE u.friendId = :friendId"),
    @NamedQuery(name = "UserFriends.findByRequestStatus", query = "SELECT u FROM UserFriends u WHERE u.requestStatus = :requestStatus")})
public class UserFriends implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue( strategy = GenerationType.IDENTITY )
    @Basic(optional = false)
    @Column(name = "friend_id", nullable = false)
    private Integer friendId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "request_status", nullable = false)
    private boolean requestStatus;
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    @ManyToOne(optional = false)
    private Users userId;
    @JoinColumn(name = "friend", referencedColumnName = "user_id", nullable = false)
    @ManyToOne(optional = false)
    private Users friend;

    public UserFriends() {
    }

    public UserFriends(Integer friendId) {
        this.friendId = friendId;
    }

    public UserFriends(Integer friendId, boolean requestStatus) {
        this.friendId = friendId;
        this.requestStatus = requestStatus;
    }

    public Integer getFriendId() {
        return friendId;
    }

    public void setFriendId(Integer friendId) {
        this.friendId = friendId;
    }

    public boolean getRequestStatus() {
        return requestStatus;
    }

    public void setRequestStatus(boolean requestStatus) {
        this.requestStatus = requestStatus;
    }

    public Users getUserId() {
        return userId;
    }

    public void setUserId(Users userId) {
        this.userId = userId;
    }

    public Users getFriend() {
        return friend;
    }

    public void setFriend(Users friend) {
        this.friend = friend;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (friendId != null ? friendId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UserFriends)) {
            return false;
        }
        UserFriends other = (UserFriends) object;
        if ((this.friendId == null && other.friendId != null) || (this.friendId != null && !this.friendId.equals(other.friendId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entity.UserFriends[ friendId=" + friendId + " ]";
    }
    
}
