package com.TTSS03.Service;

import java.util.List;

import com.TTSS03.Entity.MasterMapping;

public interface MasterMappingService {
	
	
	//List<MasterMapping> saveOne (List<MasterMapping> mastermapping);
	
    void saveOrUpdateEntity(MasterMapping masterMapping, String type);
    
    List<MasterMapping>findAllMappedtrainingsBhyId(long trainingid,String venueid);
    
    List<MasterMapping>findAllMappedtrainings();



}
