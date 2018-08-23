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
	@Override
	public Map<String, Object> getService(Map<String, Object> params) {
		log.info("dubbo req:{}",params);
		BoolQueryBuilder bqb = QueryBuilders.boolQuery();
		if(!StringUtils.isEmpty(params.get("singer"))) {
			bqb.must(QueryBuilders.termQuery("singer.keyword",(String)params.get("singer")));
		}
		if(!StringUtils.isEmpty(params.get("song"))) {
			bqb.must(QueryBuilders.termQuery("song.keyword",(String)params.get("song")));
		}
		int pageNo=0;
		int pageSize = Constants.DEFAULT_PAGE_SIZE;
		if(params.containsKey("page")) {
			pageNo = (Integer)params.get("page");
		}
		if(params.containsKey("size")) {
			pageSize = (Integer)params.get("size");
		}
        Pageable pageable = PageRequest.of(pageNo, pageSize);
        SortBuilder<?> sortBuilder = SortBuilders.fieldSort("score")
                .order(SortOrder.ASC);
        SearchQuery searchQuery = new NativeSearchQueryBuilder().withQuery(bqb).withSort(sortBuilder)
        		.withPageable(pageable).build();
        Page<MusicDTO> musicDTOs = esTemplate.queryForPage(searchQuery, MusicDTO.class);
        log.info("musicDTOs={}",musicDTOs);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        //转为字符串存入
    	resultMap.put("response", JSONObject.toJSONString(musicDTOs));
    	resultMap.put("retCode", "0");
		return resultMap;
	}

}
