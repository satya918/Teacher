package com.TTSS03.Repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.TTSS03.Entity.ViewMyTrainings;


public interface ViewMyTrainingsRepository extends JpaRepository<ViewMyTrainings, Integer> {

	@Query("SELECT sv FROM ViewMyTrainings sv WHERE sv.treasuryid = :treasuryid")
	List<ViewMyTrainings> findByTreasuryId(@Param("treasuryid") String treasuryid);
	
	@Query("SELECT m FROM ViewMyTrainings m WHERE m.treasuryid = :treasuryid AND m.ref_planner_id = :ref_planner_id")
    List<ViewMyTrainings> findByTreasuryIdAndRefPlannerId(@Param("treasuryid") String treasuryid, @Param("ref_planner_id") String ref_planner_id);

    
	@Query(value = "SELECT mt.tname, mt.tmode,  mt.treasuryid, mt.tdescription,mt.vaddress,tm.mobilenumberteacher,tm.desig,tm.DOB,tm.teacher_name,tm.school_code,tm.district_name,mt.applydateandtime,mt.resourcetype, mt.ref_planner_id "
			+ "FROM mytrainings mt " + "JOIN tteacher_master tm ON mt.treasuryid = tm.treasuryid "
			+ "WHERE mt.status = 'waiting for approval'", nativeQuery = true)
	List<Object[]> findCustomData();

	@Query(value = "SELECT mt.tname, mt.tmode, mt.treasuryid, mt.tdescription,mt.vaddress, mt.secondlevelapproval ,tm.mobilenumberteacher,tm.desig,tm.DOB,tm.teacher_name,tm.school_code,tm.district_name,mt.applydateandtime,mt.resourcetype,mt.ref_planner_id  "
			+ "FROM mytrainings mt " + "JOIN tteacher_master tm ON mt.treasuryid = tm.treasuryid "
			+ "WHERE mt.status ='approved'", nativeQuery = true)
	List<Object[]> findApprovedData();
	
	
	
	@Query(value = "SELECT mt.tname, mt.tmode, mt.treasuryid, mt.tdescription, mt.vaddress, mt.remarks, " +
            "tm.mobilenumberteacher, tm.desig, tm.DOB, tm.teacher_name, tm.school_code, tm.district_name, " +
            "mt.applydateandtime, mt.resourcetype, mt.ref_planner_id " +
            "FROM mytrainings mt " +
            "JOIN tteacher_master tm ON mt.treasuryid = tm.treasuryid " +
            "WHERE mt.status = 'rejected'", nativeQuery = true)
List<Object[]> findRejectedData();

	@Modifying
	@Query("UPDATE ViewMyTrainings v SET v.status = 'approved' WHERE v.treasuryid = :treasuryId  AND v.ref_planner_id = :refPlannerId")
	void updateStatusByTreasuryId(@Param("treasuryId") String treasuryId, @Param("refPlannerId") String refPlannerId);

	@Query("SELECT a FROM ViewMyTrainings a WHERE a.treasuryid = :treasuryid AND a.tname = :tname")
	List<ViewMyTrainings> findByTreasuryIdAndTname(@Param("treasuryid") String treasuryid,
			@Param("tname") String tname);

	@Modifying
	@Query("UPDATE ViewMyTrainings v SET v.status = 'rejected' WHERE v.treasuryid = :treasuryId  AND v.ref_planner_id = :refPlannerId")
	void rejectStatusByTreasuryId(@Param("treasuryId") String treasuryId, @Param("refPlannerId") String refPlannerId);
	
	
	//
	@Query("SELECT COUNT(e) FROM ViewMyTrainings e WHERE e.status = 'waiting for approval'")
    long countByStatusWaitingForApproval();
	
	
	//
	@Query("SELECT COUNT(e) FROM ViewMyTrainings e WHERE e.status = 'approved'")
	long countByStatusAppoved();
	
	
	//
	@Query("SELECT COUNT(e) FROM ViewMyTrainings e WHERE e.status = 'rejected'")
	long countByStatusRejected();
	
	
	//
	@Modifying
    @Transactional
    @Query("UPDATE ViewMyTrainings t SET t.status = 'rejected', t.remarks = :remarks WHERE t.treasuryid = :treasuryId AND t.ref_planner_id = :refPlannerIds")
    void updateStatusAndRemarks(@Param("treasuryId") String treasuryId, @Param("refPlannerIds") String refPlannerIds, @Param("remarks") String remarks);
	
	
	//
	@Modifying
	@Transactional
	@Query("UPDATE ViewMyTrainings m SET m.status = 'approved', m.secondlevelapproval = :secondlevelapproval WHERE m.treasuryid = :treasuryId AND m.tname = :trainingName")
	void updateStatusAndRemarksForSecondLevelApproval(@Param("treasuryId") String treasuryId, @Param("trainingName") String trainingName, @Param("secondlevelapproval") String secondlevelapproval);

	@Query(value = "SELECT mt.tname, mt.tmode, mt.treasuryid, mt.tdescription, mt.vname, mt.vaddress, mt.secondlevelapproval ,tm.mobilenumberteacher,tm.desig,tm.DOB,tm.teacher_name,tm.school_code,tm.district_name,mt.applydateandtime,mt.resourcetype,mt.ref_planner_id "
			+ "FROM mytrainings mt " + "JOIN tteacher_master tm ON mt.treasuryid = tm.treasuryid "
			+ "WHERE mt.appliedtype ='self' AND mt.status='Waiting For Approval'", nativeQuery = true)
	List<Object[]> findSelfAttendedTeachersData();
	
	@Query(value = "SELECT mt.treasuryid, tm.tdescription, tm.ref_planner_id, tm.venue_name, mt.mobilenumberteacher, mt.designation, mt.dob, tm.tname, tm.tmode, tm.vaddress, tm.resourcetype, mt.teacher_name, mt.school_code, mt.district_name, mt.applydateandtime " +
	        "FROM mytrainings mt " +
	        "JOIN ttransactiontraining tm ON mt.ref_planner_id = tm.ref_planner_id " +
	        "WHERE mt.appliedtype = 'Nominated' AND mt.status='Waiting For Approval'", nativeQuery = true)
	List<Object[]> findNominatedTrainings();
	
	
//	@Query("SELECT mt.venueid,mt.ref_planner_id, mt.treasuryid,tm.tname, vm.vname, tm.tmode, tm.tdescription, tm.training_start_dt, tm.training_end_dt,"
//			+ " vm.vaddress, vm.vcontactno, vm.vcontactmailid, vm.maplocation,tm.resourcetype "
//			+ "FROM AppliedTrainingsFromTrainee mt "
//			+ "JOIN ScheduleTrainings tm ON mt.ref_planner_id = tm.ref_planner_id "
//			+ "JOIN SearchVenue vm ON mt.venueid = vm.vid " + "WHERE mt.treasuryid = :treasuryid and mt.ref_planner_id = :ref_planner_id and mt.venueid =:venueid")
//	List<Object[]> findTrainingDetailsByTreasuryIdAndRef_plannerIdAndVid(@Param("treasuryid") String treasuryid,@Param("ref_planner_id") String ref_planner_id,@Param("venueid") String venueid );

	
	@Query("SELECT tr.ref_planner_id, tr.tname, tr.tdescription, tr.tagency, tr.tmode, tr.training_start_dt, " +
	        "tr.training_end_dt,  tr.resourcetype, " +
	        "vm.vaddress, vm.vid, vm.vcontactname, vm.vcontactmailid, vm.vcontactno, vm.vname , vm.maplocation, " +
	        "tm.treasuryid ,tr.tstarttime,tr.tendtime " +
	        "FROM ScheduleTrainings tr, SearchVenue vm, TreasuryGovt tm " +
	        "WHERE ( tr.ref_planner_id = :ref_planner_id) " +
	        "AND ( vm.vid = :vid) " +
	        "AND ( tm.treasuryid = :treasuryid)")
	List<Object[]> findTrainingDetails(
	        @Param("ref_planner_id") String ref_planner_id,
	        @Param("vid") long vid,
	        @Param("treasuryid") String treasuryid
	);

	

}
