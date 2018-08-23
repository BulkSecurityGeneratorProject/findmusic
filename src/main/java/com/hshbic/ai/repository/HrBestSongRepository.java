package com.hshbic.ai.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.hshbic.ai.domain.HrBestSong;

/**
 * Spring Data JPA repository for the User entity.
 */
@Repository
public interface HrBestSongRepository extends JpaRepository<HrBestSong, Long> {
  
	Page<HrBestSong> findAllByType(Pageable pageable,String type);
  
}
