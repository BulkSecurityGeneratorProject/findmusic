package com.hshbic.ai.service;


import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hshbic.ai.domain.HrBestSong;
import com.hshbic.ai.repository.HrBestSongRepository;
import com.hshbic.ai.service.dto.HrBestSongDTO;
import com.hshbic.ai.service.mapper.HrBestSongMapper;


/**
 * Service Implementation for managing HrBestSong.
 */
@Service
@Transactional
public class HrBestSongService{

    private final Logger log = LoggerFactory.getLogger(HrBestSongService.class);

    private final HrBestSongRepository hrBestSongRepository;

    private final HrBestSongMapper hrBestSongMapper;

    public HrBestSongService(HrBestSongRepository hrBestSongRepository, HrBestSongMapper hrBestSongMapper) {
        this.hrBestSongRepository = hrBestSongRepository;
        this.hrBestSongMapper = hrBestSongMapper;
    }

    /**
     * Save a HrBestSong.
     *
     * @param HrBestSongDTO the entity to save
     * @return the persisted entity
     */
    public HrBestSongDTO save(HrBestSongDTO HrBestSongDTO) {
        log.debug("Request to save HrBestSong : {}", HrBestSongDTO);
        HrBestSong HrBestSong = hrBestSongMapper.toEntity(HrBestSongDTO);
        HrBestSong = hrBestSongRepository.save(HrBestSong);
        return hrBestSongMapper.toDto(HrBestSong);
    }

    /**
     * Get all the activities.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Transactional(readOnly = true)
    public Page<HrBestSongDTO> findAll(Pageable pageable) {
        log.debug("Request to get all HrBestSong");
        return hrBestSongRepository.findAll(pageable)
            .map(hrBestSongMapper::toDto);
    }

    /**
     * Get one HrBestSong by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Transactional(readOnly = true)
    public HrBestSongDTO findOne(Long id) {
        log.debug("Request to get HrBestSong : {}", id);
        Optional<HrBestSong> HrBestSong = hrBestSongRepository.findById(id);
        return hrBestSongMapper.toDto(HrBestSong.get());
    }

    /**
     * Delete the HrBestSong by id.
     *
     * @param id the id of the entity
     */
    public void delete(Long id) {
        log.debug("Request to delete HrBestSong : {}", id);
        hrBestSongRepository.deleteById(id);
    }

    public Page<HrBestSongDTO> findAllByType(Pageable pageable,String type){
      return hrBestSongRepository.findAllByType(pageable,type).map(hrBestSongMapper::toDto);
    }
	
}
