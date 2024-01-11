package com.TTSS03.Controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
 
import com.TTSS03.Entity.AdminLogin;
import com.TTSS03.Entity.LoginCredentials;
import com.TTSS03.Entity.NonGovtMaster;
import com.TTSS03.Entity.TreasuryGovt;
import com.TTSS03.Repository.NonGovtMasterRepository;
import com.TTSS03.Service.AuthenticationService;
 
 
@RestController
@RequestMapping("/api")

public class AuthenticationController {
	
	
	@Autowired
	private NonGovtMasterRepository NonGovtMasterRepo;
	
	@Autowired
	private AuthenticationService authService;
	
	@PostMapping("/teacher/login")
	public ResponseEntity<String> login(@RequestBody LoginCredentials credentials) {
	    Optional<TreasuryGovt> user = authService.findByTreasuryIdAndMobileNumber(credentials.getTreasuryid(), credentials.getMobilenumberteacher());
 
	    if (user.isPresent()) {
	        return ResponseEntity.ok("Login successful for " + credentials.getTreasuryid());
	    } else {
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login failed");
	    }
	}
	@PostMapping("/admin/login")
	public ResponseEntity<String> login(@RequestBody AdminLogin user) {
	    if (authService.isValidUser(user.getUsername(), user.getPassword())) {
	        return ResponseEntity.ok("Login successful!");
	    } else {
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login failed. Please check your username and password.");
	    }
	}
  
//	 @PostMapping("/verify")
//	    public ResponseEntity<String> verifyCredentials(
//	            @RequestParam String role,
//	            @RequestParam String username,
//	            @RequestParam String password) {
//
//	        
//	        String hardcodedRole = "Admin";
//	        String hardcodedUsername = "user01";
//	        String hardcodedPassword = "user01";
//
//	       
//	        if (hardcodedRole.equals(role) && hardcodedUsername.equals(username) && hardcodedPassword.equals(password)) {
//	           
//	            return ResponseEntity.ok("Login successful!");
//	        } else {
//	         
//	            return ResponseEntity.badRequest().body("Invalid credentials");
//	        }
//	    }
	@GetMapping("/teacher/cfmsid")
	public ResponseEntity<String> verifyUser(@RequestParam String cfms_id, @RequestParam String mobileno_teacher) {
		
	    NonGovtMaster findBycfmsIdAndMobileNumber = NonGovtMasterRepo.findBycfmsIdAndMobileNumber(cfms_id, mobileno_teacher);

	    // Check if findBycfmsIdAndMobileNumber is not null before accessing its properties
	    if (findBycfmsIdAndMobileNumber != null) {
	        if (cfms_id.equals(findBycfmsIdAndMobileNumber.getCfms_id()) &&
	            mobileno_teacher.equals(findBycfmsIdAndMobileNumber.getMobileno_teacher())) {
	            // User found and credentials match
	            return ResponseEntity.ok("User found. Credentials match.");
	        } else {
	            // User found but credentials don't match
	            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Credentials mismatch.");
	        }
	    } else {
	        // User not found
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Credentials mismatch User not found.");
	    }
	}

 
}