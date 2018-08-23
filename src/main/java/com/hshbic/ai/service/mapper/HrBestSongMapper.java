package com.hshbic.ai.service.mapper;

import org.mapstruct.*;
import com.hshbic.ai.domain.HrBestSong;
import com.hshbic.ai.service.dto.HrBestSongDTO;

/**
 * Mapper for the entity HrBestSong and its DTO HrBestSongDTO.
 */
@Mapper(componentModel = "spring", uses = {})
public interface HrBestSongMapper extends EntityMapper<HrBestSongDTO, HrBestSong> {
	
    default HrBestSong fromId(Long id) {
        if (id == null) {
            return null;
        }
        HrBestSong HrUser = new HrBestSong();
        HrUser.setId(id);
        return HrUser;
    }
}
