package com.TTSS03.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.TTSS03.Entity.AttendGradeMaster;
import com.TTSS03.Service.AttendGradeService;

@RestController
@RequestMapping("/api")
public class AttendGradeMasterController {
	
	@Autowired
	AttendGradeService attendGradeService;
	
	
	@GetMapping("/attendGrade")
	public ResponseEntity<List<AttendGradeMaster>>findAllGrade(){
		List<AttendGradeMaster> allGrade = attendGradeService.getAllGrade();
		return ResponseEntity.ok(allGrade);
		
	}

}
