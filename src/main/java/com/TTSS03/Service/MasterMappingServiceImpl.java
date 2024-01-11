package com.TTSS03.Service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.TTSS03.Entity.MasterMapping;
import com.TTSS03.Repository.MasterMappingRepository;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import org.hibernate.Session;

@Service
public class MasterMappingServiceImpl implements MasterMappingService {
	
	
	@Autowired
	MasterMappingRepository MasterMappingRepo;
	
	 @PersistenceContext
	    private EntityManager entityManager;

	@Override
	public List<MasterMapping> saveOne(List<MasterMapping> mastermapping) {
		// TODO Auto-generated method stub
		return MasterMappingRepo.saveAll(mastermapping);
	}

	 @Override
	    @Transactional
	    public void saveOrUpdateEntity(MasterMapping masterMapping, String type) {
	        String queryBase = "INSERT INTO ttraining_to_management_mapping (trainingid, trainingname, venueid, venuename, "
	                + "ccflag, cctreasuryid, ccname, ccdesignation, ccdistrict, ccmandal, ccemail, ccmobile, "
	                + "accflag, acctreasuryid, accname, accdesignation, accdistrict, accmandal, accemail, accmobile, "
	                + "rpflag, rptreasuryid, rpname, rpdesignation, rpdistrict, rpmandal, rpemail, rpmobile, "
	                + "osflag, ostreasuryid, osname, osdesignation, osdistrict, osmandal, osemail, osmobile, "
	                + "ppflag, pptreasuryid, ppname, ppdesignation, ppdistrict, ppmandal, ppemail, ppmobile, "
	                + "status, remark) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "
	                + "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE ";

	        String updatePart = generateUpdatePart(type);

	        String finalQuery = queryBase + updatePart;

	        Session session = entityManager.unwrap(Session.class);
	        Query query = session.createNativeQuery(finalQuery);

	        // Set parameters
	        int parameterIndex = 1; // Start with the first parameter index
	        query.setParameter(parameterIndex++, masterMapping.getTrainingid());
	        query.setParameter(parameterIndex++, masterMapping.getTrainingname());
	        query.setParameter(parameterIndex++, masterMapping.getVenueid());
	        query.setParameter(parameterIndex++, masterMapping.getVenuename());
	        query.setParameter(parameterIndex++, masterMapping.getCcflag());
	        query.setParameter(parameterIndex++, masterMapping.getCctreasuryid());
	        query.setParameter(parameterIndex++, masterMapping.getCcname());
	        query.setParameter(parameterIndex++, masterMapping.getCcdesignation());
	        query.setParameter(parameterIndex++, masterMapping.getCcdistrict());
	        query.setParameter(parameterIndex++, masterMapping.getCcmandal());
	        query.setParameter(parameterIndex++, masterMapping.getCcemail());
	        query.setParameter(parameterIndex++, masterMapping.getCcmobile());
	        query.setParameter(parameterIndex++, masterMapping.getAccflag());
	        query.setParameter(parameterIndex++, masterMapping.getAcctreasuryid());
	        query.setParameter(parameterIndex++, masterMapping.getAccname());
	        query.setParameter(parameterIndex++, masterMapping.getAccdesignation());
	        query.setParameter(parameterIndex++, masterMapping.getAccdistrict());
	        query.setParameter(parameterIndex++, masterMapping.getAccmandal());
	        query.setParameter(parameterIndex++, masterMapping.getAccemail());
	        query.setParameter(parameterIndex++, masterMapping.getAccmobile());
	        query.setParameter(parameterIndex++, masterMapping.getRpflag());
	        query.setParameter(parameterIndex++, masterMapping.getRptreasuryid());
	        query.setParameter(parameterIndex++, masterMapping.getRpname());
	        query.setParameter(parameterIndex++, masterMapping.getRpdesignation());
	        query.setParameter(parameterIndex++, masterMapping.getRpdistrict());
	        query.setParameter(parameterIndex++, masterMapping.getRpmandal());
	        query.setParameter(parameterIndex++, masterMapping.getRpemail());
	        query.setParameter(parameterIndex++, masterMapping.getRpmobile());
	        query.setParameter(parameterIndex++, masterMapping.getOsflag());
	        query.setParameter(parameterIndex++, masterMapping.getOstreasuryid());
	        query.setParameter(parameterIndex++, masterMapping.getOsname());
	        query.setParameter(parameterIndex++, masterMapping.getOsdesignation());
	        query.setParameter(parameterIndex++, masterMapping.getOsdistrict());
	        query.setParameter(parameterIndex++, masterMapping.getOsmandal());
	        query.setParameter(parameterIndex++, masterMapping.getOsemail());
	        query.setParameter(parameterIndex++, masterMapping.getOsmobile());
	        query.setParameter(parameterIndex++, masterMapping.getPpflag());
	        query.setParameter(parameterIndex++, masterMapping.getPptreasuryid());
	        query.setParameter(parameterIndex++, masterMapping.getPpname());
	        query.setParameter(parameterIndex++, masterMapping.getPpdesignation());
	        query.setParameter(parameterIndex++, masterMapping.getPpdistrict());
	        query.setParameter(parameterIndex++, masterMapping.getPpmandal());
	        query.setParameter(parameterIndex++, masterMapping.getPpemail());
	        query.setParameter(parameterIndex++, masterMapping.getPpmobile());
	        query.setParameter(parameterIndex++, masterMapping.getStatus());
	        query.setParameter(parameterIndex++, masterMapping.getRemark());

	        // Execute the query
	        query.executeUpdate();
	    }


	private String generateUpdatePart(String type) {
	    String updatePart = "";

	    if ("CC".equals(type)) {
	        updatePart = " ccflag = VALUES(ccflag), cctreasuryid = VALUES(cctreasuryid), ccname = VALUES(ccname), "
	                + "ccdesignation = VALUES(ccdesignation), ccdistrict = VALUES(ccdistrict), ccmandal = VALUES(ccmandal), "
	                + "ccemail = VALUES(ccemail), ccmobile = VALUES(ccmobile)";
	    } else if ("ACC".equals(type)) {
	        updatePart = " accflag = VALUES(accflag), acctreasuryid = VALUES(acctreasuryid), accname = VALUES(accname), "
	                + "accdesignation = VALUES(accdesignation), accdistrict = VALUES(accdistrict), accmandal = VALUES(accmandal), "
	                + "accemail = VALUES(accemail), accmobile = VALUES(accmobile)";
	    } else if ("RP".equals(type)) {
	        updatePart = " rpflag = VALUES(rpflag), rptreasuryid = VALUES(rptreasuryid), rpname = VALUES(rpname), "
	                + "rpdesignation = VALUES(rpdesignation), rpdistrict = VALUES(rpdistrict), rpmandal = VALUES(rpmandal), "
	                + "rpemail = VALUES(rpemail), rpmobile = VALUES(rpmobile)";
	    } else if ("OS".equals(type)) {
	        updatePart = " osflag = VALUES(osflag), ostreasuryid = VALUES(ostreasuryid), osname = VALUES(osname), "
	                + "osdesignation = VALUES(osdesignation), osdistrict = VALUES(osdistrict), osmandal = VALUES(osmandal), "
	                + "osemail = VALUES(osemail), osmobile = VALUES(osmobile)";
	    } else if ("PP".equals(type)) {
	        updatePart = " ppflag = VALUES(ppflag), pptreasuryid = VALUES(pptreasuryid), ppname = VALUES(ppname), "
	                + "ppdesignation = VALUES(ppdesignation), ppdistrict = VALUES(ppdistrict), ppmandal = VALUES(ppmandal), "
	                + "ppemail = VALUES(ppemail), ppmobile = VALUES(ppmobile)";
	    }

	    return updatePart;
	}

}

