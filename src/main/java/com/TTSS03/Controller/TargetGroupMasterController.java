package com.TTSS03.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.TTSS03.Entity.TargetGroupMaster;
import com.TTSS03.Service.TargetGroupMasterService;

@RestController
@RequestMapping("/api")
public class TargetGroupMasterController {
	
	@Autowired
	TargetGroupMasterService targetGroupMasterService;
	
	@GetMapping("/group")
	public ResponseEntity<List<TargetGroupMaster>>findAllgrades(){
		List<TargetGroupMaster> allGroup = targetGroupMasterService.getAllGroup();
		return ResponseEntity.ok(allGroup);
	}

}
