package com.TTSS03.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.TTSS03.Entity.AttendGradeMaster;
import com.TTSS03.Repository.AttendGradeMasterRepository;

@Service
public class AttendGradeMasterServiceImpl implements AttendGradeService {
	
	
	@Autowired
	AttendGradeMasterRepository AttendGradeMasterRepo;

	@Override
	public List<AttendGradeMaster> getAllGrade() {
		// TODO Auto-generated method stub
		return AttendGradeMasterRepo.findAll();
	}

}
