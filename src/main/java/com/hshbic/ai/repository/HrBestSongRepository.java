package com.hshbic.ai.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.hshbic.ai.domain.HrBestSong;

/**
 * Spring Data JPA repository for the User entity.
 */
@Repository
public interface HrBestSongRepository extends JpaRepository<HrBestSong, Long> {
	
	@Query(nativeQuery=true, value="SELECT * FROM hr_best_song where type=?1 ORDER BY rand() LIMIT ?2")
	List<HrBestSong> findAllByTypeOrderByRand(String type,int number);
	
	Page<HrBestSong> findAllByType(Pageable pageable,String type);
  
}
