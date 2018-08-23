package com.hshbic.ai.dubbo.common;

import java.util.HashMap;
import java.util.Map;

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
import org.springframework.util.StringUtils;

import com.alibaba.dubbo.config.annotation.Service;
import com.alibaba.fastjson.JSONObject;
import com.hshbic.ai.config.Constants;
import com.hshbic.ai.service.HrBestSongService;
import com.hshbic.ai.service.dto.HrBestSongDTO;
import com.hshbic.ai.service.dto.MusicDTO;
@Service(
        version = "${app.service.version}",
        application = "${dubbo.application.id}",
        protocol = "${dubbo.protocol.id}",
        registry = "${dubbo.registry.id}"
)
public class MusicService implements LocalCommonService{
	private static Logger log = LoggerFactory.getLogger(MusicService.class);
	@Autowired
    private ElasticsearchTemplate esTemplate; 
	@Autowired
    private HrBestSongService bestSongService; 
	@Override
	public Map<String, Object> getService(Map<String, Object> params) {
		log.info("dubbo req:{}",params);
		BoolQueryBuilder bqb = QueryBuilders.boolQuery();
		boolean randomFlag = true;
		if(!StringUtils.isEmpty(params.get("singer"))) {
			bqb.must(QueryBuilders.termQuery("singer.keyword",(String)params.get("singer")));
			randomFlag = false;
		}
		if(!StringUtils.isEmpty(params.get("song"))) {
			bqb.must(QueryBuilders.termQuery("song.keyword",(String)params.get("song")));
			randomFlag = false;
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		//歌手与歌曲都为空则返回云端精选100首
		if(randomFlag) {
			int returnSize = 100;
			Page<HrBestSongDTO> bestSongPage = bestSongService.findAllByType(PageRequest.of(0, returnSize),"cloud");
			resultMap.put("find", "N");
			resultMap.put("content", JSONObject.toJSONString(bestSongPage.getContent()));
			resultMap.put("numberOfElements" ,bestSongPage.getNumberOfElements());
			log.info("bestSong resultMap:{}",resultMap);
			return resultMap;
		}
		int pageNo=0;
		int pageSize = Constants.DEFAULT_PAGE_SIZE;
		if(params.containsKey("pageNo")) {
			pageNo = (Integer)params.get("pageNo");
		}
		if(params.containsKey("pageSize")) {
			pageSize = (Integer)params.get("pageSize");
		}
        Pageable pageable = PageRequest.of(pageNo, pageSize);
    	log.info("bestSong pageable:{}",pageable);
        SortBuilder<?> sortBuilder = SortBuilders.fieldSort("score")
                .order(SortOrder.ASC);
        SearchQuery searchQuery = new NativeSearchQueryBuilder().withQuery(bqb).withSort(sortBuilder)
        		.withPageable(pageable).build();
        Page<MusicDTO> musicPage = esTemplate.queryForPage(searchQuery, MusicDTO.class);
       
        resultMap.put("find", "Y");
        resultMap.put("content", JSONObject.toJSONString(musicPage.getContent()));
        resultMap.put("totalElements" , musicPage.getTotalElements());
        resultMap.put("totalPages" , musicPage.getTotalPages());
        resultMap.put("pageNo", musicPage.getNumber());
        resultMap.put("pageSize" , musicPage.getSize());
        resultMap.put("first", musicPage.isFirst());
        resultMap.put("numberOfElements", musicPage.getNumberOfElements());
        resultMap.put("last", musicPage.isLast());
        resultMap.put("retCode", "0");
        
   /*     Map<String, Object> responseMap = new HashMap<String, Object>();
        //转为字符串存入
        responseMap.put("response", JSONObject.toJSONString(resultMap));
        responseMap.put("retCode", "0");*/
    	log.info("resultMap={}",resultMap);
		return resultMap;
	}

}
