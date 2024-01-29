package com.TTSS03.Controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	@GetMapping("/training/mapped")
	public ResponseEntity<List<MasterMapping>> findMappedTrainingById(@RequestParam long trainingid,@RequestParam String venueid) {
	    List<MasterMapping> findAllMappedtrainingsBhyId = MasterMappingServ.findAllMappedtrainingsBhyId(trainingid,venueid);

	    if (findAllMappedtrainingsBhyId == null || findAllMappedtrainingsBhyId.isEmpty()) {
	        // If no mapped trainings found, return 404 Not Found
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    } else {
	        // If mapped trainings found, return 200 OK with the list of mapped trainings
	        return new ResponseEntity<>(findAllMappedtrainingsBhyId, HttpStatus.OK);
	    }
	}
	@GetMapping("/mapped/trainings")
	public ResponseEntity<List<MasterMapping>> findAll(){
		List<MasterMapping> findAllMappedtrainings = MasterMappingServ.findAllMappedtrainings();
		return ResponseEntity.ok(findAllMappedtrainings);
	}

}
