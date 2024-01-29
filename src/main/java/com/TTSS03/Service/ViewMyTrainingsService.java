package com.TTSS03.Service;

import java.util.List;
import java.util.Map;

import com.TTSS03.Entity.NominateTrainings;
import com.TTSS03.Entity.ViewMyTrainings;
import com.TTSS03.utill.NominateTrainingsDto;

public interface ViewMyTrainingsService {

	
	List<ViewMyTrainings> savemyTrainingsxyz(String treasuryid,String ref_planner_id,long venueid);

	List<ViewMyTrainings>findByTreasuryId(String treasuryid );

	List<Map<String, Object>> getCustomData();

	List<Map<String, Object>> getAppovedData();

	List<Map<String, Object>> getRejectedData();

	void updateStatusToApproved(String treasuryId, String refPlannerId);

	void rejectStatusToApproved(String treasuryId, String refPlannerId);

	long countWaitingForApprovalUsersList();

	long countApprovedUsersList();

	long countRejectedUsersList();

	void updateStatusAndRemarks(String treasuryId, String refPlannerIds, String remarks);

	void updateStatusAndRemarksForSecondLevelApproval(String treasuryId, String trainingName,
			String secondlevelapproval);

	void storeDataNominate(List<NominateTrainingsDto> selectedRowsData);
	
	
	
	List<Map<String, Object>> getSelfAttendedData();
	
	List<NominateTrainings> getNominatedTrainings();
	
	List<Map<String, Object>> getNominateTeacher();
	
	void updateStatusToApprovedNomonate(String treasuryId, String refPlannerId);

	List<ViewMyTrainings>checkIfAlreadyAppliedTrainings(String treasuryId, String refPlannerIds);
	
	List<Map<String, Object>> findApprovedDataTeacherTrainingVenueId(String trainingId, String venueId );
	
	List<Map<String, Object>> findApprovedDataTeacher();

}
