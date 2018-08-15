package com.hshbic.ai.service;

import java.util.List;

import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.sort.SortBuilder;
import org.elasticsearch.search.sort.SortBuilders;
import org.elasticsearch.search.sort.SortOrder;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.data.elasticsearch.core.query.SearchQuery;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hshbic.ai.FindmusicApp;
import com.hshbic.ai.service.dto.MusicDTO;

/**
 * Test class for the UserResource REST controller.
 *
 * @see UserService
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(classes = FindmusicApp.class)
public class ElasticSearchTest {

	@Autowired
    private ElasticsearchTemplate esTemplate; 

    @Before
    public void init() {
       
    }

    @Test
    public void test() {
    	 // SumBuilder sb = AggregationBuilders.sum("tpPrice").field("payPrice");
          BoolQueryBuilder bqb = QueryBuilders.boolQuery();
          bqb.must(QueryBuilders.termQuery("singer.keyword","阿杜"));
         // bqb.must(QueryBuilders.termQuery("song.keyword","简单爱 (Live)"));
      /*    bqb.must(QueryBuilders.boolQuery()
                  .should(QueryBuilders.matchQuery("payPlatform", SuperAppConstant.PAY_PLATFORM_TL))
                  .should(QueryBuilders.matchQuery("payPlatform", SuperAppConstant.PAY_PLATFORM_TL_WX_APP))
                  .should(QueryBuilders.matchQuery("payPlatform", SuperAppConstant.PAY_PLATFORM_TL_ALI))
                  .should(QueryBuilders.matchQuery("payPlatform", SuperAppConstant.PAY_PLATFORM_TL_WX_JS))
                  .should(QueryBuilders.matchQuery("payPlatform", SuperAppConstant.PAY_PLATFORM_TL_APP))
                  .should(QueryBuilders.matchQuery("payPlatform", SuperAppConstant.PAY_PLATFORM_TL_WX_H5))
                  .should(QueryBuilders.matchQuery("payPlatform", SuperAppConstant.PAY_PLATFORM_WX_GWORLD))
                  .should(QueryBuilders.matchQuery("payPlatform", SuperAppConstant.PAY_PLATFORM_ALI_GWORLD))
                  );*/
    	  SearchQuery searchQuery = new NativeSearchQueryBuilder().withQuery(bqb).build();
          List<MusicDTO> MusicDTOs = esTemplate.queryForList(searchQuery, MusicDTO.class);
          for (MusicDTO MusicDTO : MusicDTOs) {
              System.out.println(MusicDTO.toString());
          }
    }
    
    
    @Test
    public void testSongs() {
    	BoolQueryBuilder bqb = QueryBuilders.boolQuery();
    	String songName = "大海";
        bqb.must(QueryBuilders.termQuery("song.keyword",songName));
        Pageable pageable = PageRequest.of(0, 10);
        SortBuilder<?> sortBuilder = SortBuilders.fieldSort("score")
                .order(SortOrder.ASC);
        SearchQuery searchQuery = new NativeSearchQueryBuilder().withQuery(bqb).withSort(sortBuilder).withPageable(pageable).build();
        List<MusicDTO> musicDTOs = esTemplate.queryForList(searchQuery, MusicDTO.class);
        System.out.println(musicDTOs);
    }

    @Test
    public void testSingers() {
    	BoolQueryBuilder bqb = QueryBuilders.boolQuery();
    	String singerName = "刘德华";
        bqb.must(QueryBuilders.termQuery("singer.keyword",singerName));
        Pageable pageable = PageRequest.of(0, 10);
        SortBuilder<?> sortBuilder = SortBuilders.fieldSort("score")
                .order(SortOrder.ASC);
        SearchQuery searchQuery = new NativeSearchQueryBuilder().withQuery(bqb).withSort(sortBuilder).withPageable(pageable).build();
        List<MusicDTO> musicDTOs = esTemplate.queryForList(searchQuery, MusicDTO.class);
        System.out.println(musicDTOs);
    }
}
