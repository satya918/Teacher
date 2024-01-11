package com.TTSS03.Controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.TTSS03.Entity.MasterMapping;
import com.TTSS03.Service.MasterMappingService;

@RestController
@RequestMapping("/api")
public class MasterMappingController {
	
	
	@Autowired
	MasterMappingService MasterMappingServ;
	
	
	@PostMapping("/saveOrUpdate")
	public ResponseEntity<String> saveOrUpdateMasterMapping(@RequestBody MasterMapping masterMapping,
	                                                       @RequestParam String type) {
		MasterMappingServ.saveOrUpdateEntity(masterMapping, type);
	    return ResponseEntity.ok("Saved or updated successfully.");
	}


}
