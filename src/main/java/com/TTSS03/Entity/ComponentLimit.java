package com.TTSS03.Entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="bdg_compontresource_limit")
public class ComponentLimit {
	
	 @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private Long sl;

	    private String budgetedYear;
	    private String resources;
	    private String resourceType;
	    private String cityType;
	    private String approvedRate;
	    private String unit;
	    private String remarks;
	    private String createdBy;
	    private String modifiedBy;
	    private String createdDt;
	    private String modifiedDt;
	    private String recordStatus;
		public Long getSl() {
			return sl;
		}
		public void setSl(Long sl) {
			this.sl = sl;
		}
		public String getBudgetedYear() {
			return budgetedYear;
		}
		public void setBudgetedYear(String budgetedYear) {
			this.budgetedYear = budgetedYear;
		}
		public String getResources() {
			return resources;
		}
		public void setResources(String resources) {
			this.resources = resources;
		}
		public String getResourceType() {
			return resourceType;
		}
		public void setResourceType(String resourceType) {
			this.resourceType = resourceType;
		}
		public String getCityType() {
			return cityType;
		}
		public void setCityType(String cityType) {
			this.cityType = cityType;
		}
		public String getApprovedRate() {
			return approvedRate;
		}
		public void setApprovedRate(String approvedRate) {
			this.approvedRate = approvedRate;
		}
		public String getUnit() {
			return unit;
		}
		public void setUnit(String unit) {
			this.unit = unit;
		}
		public String getRemarks() {
			return remarks;
		}
		public void setRemarks(String remarks) {
			this.remarks = remarks;
		}
		public String getCreatedBy() {
			return createdBy;
		}
		public void setCreatedBy(String createdBy) {
			this.createdBy = createdBy;
		}
		public String getModifiedBy() {
			return modifiedBy;
		}
		public void setModifiedBy(String modifiedBy) {
			this.modifiedBy = modifiedBy;
		}
		public String getCreatedDt() {
			return createdDt;
		}
		public void setCreatedDt(String createdDt) {
			this.createdDt = createdDt;
		}
		public String getModifiedDt() {
			return modifiedDt;
		}
		public void setModifiedDt(String modifiedDt) {
			this.modifiedDt = modifiedDt;
		}
		public String getRecordStatus() {
			return recordStatus;
		}
		public void setRecordStatus(String recordStatus) {
			this.recordStatus = recordStatus;
		}

	   
}
