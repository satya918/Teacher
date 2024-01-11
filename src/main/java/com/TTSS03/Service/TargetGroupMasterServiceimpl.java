package com.TTSS03.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.TTSS03.Entity.TargetGroupMaster;
import com.TTSS03.Repository.TargetGroupMasterRepository;

@Service
public class TargetGroupMasterServiceimpl implements TargetGroupMasterService {

	
	@Autowired
	TargetGroupMasterRepository TargetGroupMasterRepo; 
	
	@Override
	public List<TargetGroupMaster> getAllGroup() {
		return TargetGroupMasterRepo.findAll();
	}

}
