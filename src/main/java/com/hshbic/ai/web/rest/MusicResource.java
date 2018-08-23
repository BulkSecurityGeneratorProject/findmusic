package com.hshbic.ai.web.rest;

import java.util.List;

import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.sort.SortBuilder;
import org.elasticsearch.search.sort.SortBuilders;
import org.elasticsearch.search.sort.SortOrder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.data.elasticsearch.core.query.SearchQuery;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hshbic.ai.config.Constants;
import com.hshbic.ai.service.HrBestSongService;
import com.hshbic.ai.service.dto.HrBestSongDTO;
import com.hshbic.ai.service.dto.MusicDTO;

@RestController
@RequestMapping(value ="/ai-music-service/api/v1")
public class MusicResource{
	private static Logger log = LoggerFactory.getLogger(MusicResource.class);
	
	@Autowired
    private ElasticsearchTemplate esTemplate; 
	
	@Autowired
    private HrBestSongService bestSongService; 
	
/*
page，第几页，从0开始，默认为第0页
size，每一页的大小，默认为20
sort，排序相关的信息，以property,property(,ASC|DESC)的方式组织，例如sort=firstname&sort=lastname,desc表示在按firstname正序排列基础上按lastname倒序排列。*/
	@RequestMapping(value = "/bestsong/{type}", method = RequestMethod.GET)
	public  Page<HrBestSongDTO>  bestsong(@PageableDefault(value = Constants.DEFAULT_PAGE_SIZE) Pageable pageable,@PathVariable String type) {
		return bestSongService.findAllByType(pageable,type);
	}
	
	/**
	 *   某个歌手的所有歌曲
	 * @param singerName 歌手名
	 * @return 歌曲列表
	 */
	@RequestMapping(value = "/singers/{singerName}/songs", method = RequestMethod.GET)
	public Page<MusicDTO> singerAllSongs(@PageableDefault(value = Constants.DEFAULT_PAGE_SIZE) Pageable pageable,@PathVariable String singerName) {
	    BoolQueryBuilder bqb = QueryBuilders.boolQuery();
        bqb.must(QueryBuilders.termQuery("singer.keyword",singerName));
        SortBuilder<?> sortBuilder = SortBuilders.fieldSort("score")
                .order(SortOrder.ASC);
		SearchQuery searchQuery = new NativeSearchQueryBuilder().withQuery(bqb).withSort(sortBuilder)
				.withPageable(pageable).build();
		Page<MusicDTO> musicDTOs = esTemplate.queryForPage(searchQuery, MusicDTO.class);
        log.info("singerName={},musicDTOs={}",singerName,musicDTOs);
		return musicDTOs;
	}
	
	/**
	 *   按歌曲名查询，可能有多首
	 * @param songName
	 * @return 歌曲列表
	 */
	@RequestMapping(value = "/songs/{songName}", method = RequestMethod.GET)
	public Page<MusicDTO> song(@PageableDefault(value = Constants.DEFAULT_PAGE_SIZE) Pageable pageable,@PathVariable String songName) {
		BoolQueryBuilder bqb = QueryBuilders.boolQuery();
        bqb.must(QueryBuilders.termQuery("song.keyword",songName));
        SortBuilder<?> sortBuilder = SortBuilders.fieldSort("score")
                .order(SortOrder.ASC);
        SearchQuery searchQuery = new NativeSearchQueryBuilder().withQuery(bqb).withSort(sortBuilder)
        		.withPageable(pageable).build();
        Page<MusicDTO> musicDTOs = esTemplate.queryForPage(searchQuery, MusicDTO.class);
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
	public Page<MusicDTO> singerOneSong(@PageableDefault(value = Constants.DEFAULT_PAGE_SIZE) Pageable pageable,@PathVariable String singerName,@PathVariable String songName) {
		BoolQueryBuilder bqb = QueryBuilders.boolQuery();
        bqb.must(QueryBuilders.termQuery("singer.keyword",singerName));
        bqb.must(QueryBuilders.termQuery("song.keyword",songName));
        SearchQuery searchQuery = new NativeSearchQueryBuilder().withQuery(bqb).withPageable(pageable).build();
        Page<MusicDTO> musicDTOs = esTemplate.queryForPage(searchQuery, MusicDTO.class);
        log.info("singerName={},songName={},musicDTOs={}",singerName,songName,musicDTOs);
		return musicDTOs;
	}

}
	

