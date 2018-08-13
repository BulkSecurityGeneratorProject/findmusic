package com.hshbic.ai.web.rest;

import java.util.List;

import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.data.elasticsearch.core.query.SearchQuery;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hshbic.ai.service.dto.MusicDTO;

@RestController
@RequestMapping(value ="/ai-music-service/api/v1")
public class MusicResource{
	private static Logger log = LoggerFactory.getLogger(MusicResource.class);
	@Autowired
    private ElasticsearchTemplate esTemplate; 
	
	/**
	 *   某个歌手的所有歌曲
	 * @param singerName 歌手名
	 * @return 歌曲列表
	 */
	@RequestMapping(value = "/singers/{singerName}/songs", method = RequestMethod.GET)
	public List<MusicDTO> singerAllSongs(@PathVariable String singerName) {
	    BoolQueryBuilder bqb = QueryBuilders.boolQuery();
        bqb.must(QueryBuilders.termQuery("singer.keyword",singerName));
        SearchQuery searchQuery = new NativeSearchQueryBuilder().withQuery(bqb).build();
        List<MusicDTO> musicDTOs = esTemplate.queryForList(searchQuery, MusicDTO.class);
        log.info("singerName={},musicDTOs={}",singerName,musicDTOs);
		return musicDTOs;
	}
	
	/**
	 *   按歌曲名查询，可能有多首
	 * @param songName
	 * @return 歌曲列表
	 */
	@RequestMapping(value = "/songs/{songName}", method = RequestMethod.GET)
	public List<MusicDTO> song(@PathVariable String songName) {
		BoolQueryBuilder bqb = QueryBuilders.boolQuery();
        bqb.must(QueryBuilders.termQuery("song.keyword",songName));
        SearchQuery searchQuery = new NativeSearchQueryBuilder().withQuery(bqb).build();
        List<MusicDTO> musicDTOs = esTemplate.queryForList(searchQuery, MusicDTO.class);
        log.info("songName={},musicDTOs={}",songName,musicDTOs);
		return musicDTOs;
    }
	
	
	/**
	 * 某个歌手的某个歌曲，可能有多首
	 * @param singerName 歌手名
	 * @param songName 歌曲名
	 * @return 歌曲列表
	 */
	@RequestMapping(value = "/singers/{singerName}/songs/{songName}", method = RequestMethod.GET)
	public List<MusicDTO> singerOneSongs(@PathVariable String singerName,@PathVariable String songName) {
		BoolQueryBuilder bqb = QueryBuilders.boolQuery();
        bqb.must(QueryBuilders.termQuery("singer.keyword",singerName));
        bqb.must(QueryBuilders.termQuery("song.keyword",songName));
        SearchQuery searchQuery = new NativeSearchQueryBuilder().withQuery(bqb).build();
        List<MusicDTO> musicDTOs = esTemplate.queryForList(searchQuery, MusicDTO.class);
        log.info("singerName={},songName={},musicDTOs={}",singerName,songName,musicDTOs);
		return musicDTOs;
	}

}
	

