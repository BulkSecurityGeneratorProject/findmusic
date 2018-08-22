package com.hshbic.ai.domain;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * A hr_best_song.
 */
@Entity
@Table(name = "hr_best_song")

public class HrBestSong extends AbstractAuditingEntity implements Serializable {

    private static final long serialVersionUID = 2L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Size(max = 50)
    @Column(name = "area", length = 50)
    private String area;

    @Size(max = 30)
    @Column(name = "cate", length = 30)
    private String cate;

    @Size(max = 100)
    @Column(name = "singer", length = 100)
    private String singer;

    @Size(max = 100)
    @Column(name = "song", length = 100)
    private String song;

    @Size(max = 200)
    @Column(name = "playurl", length = 200)
    private String playurl;

    @Size(max = 50)
    @Column(name = "migu_id", length = 50)
    private String miguId;

    /**
     * 分类，咪咕：migu 云端：cloud
     */
    @Size(max = 30)
    @Column(name = "type", length = 30)
    private String type;
    
    @Size(max = 30)
    @Column(name = "status", length = 30)
    private String status;
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

   

    public String getSinger() {
		return singer;
	}

	public void setSinger(String singer) {
		this.singer = singer;
	}

	public String getSong() {
		return song;
	}

	public void setSong(String song) {
		this.song = song;
	}

	public String getPlayurl() {
		return playurl;
	}

	public void setPlayurl(String playurl) {
		this.playurl = playurl;
	}

	public String getMiguId() {
		return miguId;
	}

	public void setMiguId(String miguId) {
		this.miguId = miguId;
	}
	

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getCate() {
		return cate;
	}

	public void setCate(String cate) {
		this.cate = cate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        HrBestSong user = (HrBestSong) o;
        return !(user.getId() == null || getId() == null) && Objects.equals(getId(), user.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

	@Override
	public String toString() {
	  return ReflectionToStringBuilder.reflectionToString(this,ToStringStyle.DEFAULT_STYLE);
	}
}
