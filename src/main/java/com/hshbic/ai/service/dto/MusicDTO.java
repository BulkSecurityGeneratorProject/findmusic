package com.hshbic.ai.service.dto;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.springframework.data.elasticsearch.annotations.Document;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

/**
 * A DTO representing a MusicDTO.
 */
@JsonInclude(Include.NON_NULL)
@Document(indexName="xiaou_music",type="music_list")
public class MusicDTO {
	Long id;
	String area;//地域
	String cate;//性别/类别
	Double score;//分值
	String singer;//歌手
	String singerAlia1;//歌手别名1
	String singerAlia2;//歌手别名2
	String song;//歌曲
	String songAlia1;//歌曲别名1
	String songAlia2;//歌曲别名2
	String version;//版本
	String extra;//附加字段

    public MusicDTO() {
        // Empty constructor needed for Jackson.
    }
    
    public MusicDTO(long id,String area,String cate,Double score,String singer,String singerAlia1,String singerAlia2,String song,String songAlia1,String songAlia2,String version,String extra) {
       this.id = id;
       this.area = area;
       this.cate = cate;
       this.score = score;
       this.singer = singer;
       this.singerAlia1 = singerAlia1;
       this.singerAlia2 = singerAlia2;
       this.song = song;
       this.songAlia1 = songAlia1;
       this.songAlia2 = songAlia2;
       this.version = version;
       this.extra = extra;
    }

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public Double getScore() {
		return score;
	}

	public void setScore(Double score) {
		this.score = score;
	}

	public String getSinger() {
		return singer;
	}

	public void setSinger(String singer) {
		this.singer = singer;
	}

	public String getSingerAlia1() {
		return singerAlia1;
	}

	public void setSingerAlia1(String singerAlia1) {
		this.singerAlia1 = singerAlia1;
	}

	public String getSingerAlia2() {
		return singerAlia2;
	}

	public void setSingerAlia2(String singerAlia2) {
		this.singerAlia2 = singerAlia2;
	}

	public String getSong() {
		return song;
	}

	public void setSong(String song) {
		this.song = song;
	}

	public String getSongAlia1() {
		return songAlia1;
	}

	public void setSongAlia1(String songAlia1) {
		this.songAlia1 = songAlia1;
	}

	public String getSongAlia2() {
		return songAlia2;
	}

	public void setSongAlia2(String songAlia2) {
		this.songAlia2 = songAlia2;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getExtra() {
		return extra;
	}

	public void setExtra(String extra) {
		this.extra = extra;
	}

	@Override
	public String toString() {
	  return ReflectionToStringBuilder.reflectionToString(this,ToStringStyle.SIMPLE_STYLE);
	}
}
