package com.TTSS03.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;


import com.TTSS03.Entity.MasterMapping;

public interface MasterMappingRepository extends JpaRepository<MasterMapping, Long> {
	
	
	
	@Modifying
    @Query(value = "?1", nativeQuery = true)
    void saveOrUpdateEntityWithQuery(String query);
	
}
