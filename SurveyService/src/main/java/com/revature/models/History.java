package com.revature.models;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "survey_history")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class History {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int historyId;

	@NotNull
	@Column(name = "survey_id")
	private int surveyId;

	@NotNull
	@Column(name = "user_email")
	private String userEmail;

	@Column(name = "date_assigned")
	@NotNull
	private Date dateAssigned;

	@Column(name = "date_completed")
	private Date dateCompleted;

	public History() {
		super();
	}

	public History(int historyId, @NotNull int surveyId, @NotNull String userEmail, @NotNull Date dateAssigned,
			Date dateCompleted) {
		super();
		this.historyId = historyId;
		this.surveyId = surveyId;
		this.userEmail = userEmail;
		this.dateAssigned = dateAssigned;
		this.dateCompleted = dateCompleted;
	}

	public int getHistoryId() {
		return historyId;
	}

	public void setHistoryId(int historyId) {
		this.historyId = historyId;
	}

	public int getSurveyId() {
		return surveyId;
	}

	public void setSurveyId(int surveyId) {
		this.surveyId = surveyId;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public Date getDateAssigned() {
		return dateAssigned;
	}

	public void setDateAssigned(Date dateAssigned) {
		this.dateAssigned = dateAssigned;
	}

	public Date getDateCompleted() {
		return dateCompleted;
	}

	public void setDateCompleted(Date dateCompleted) {
		this.dateCompleted = dateCompleted;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((dateAssigned == null) ? 0 : dateAssigned.hashCode());
		result = prime * result + ((dateCompleted == null) ? 0 : dateCompleted.hashCode());
		result = prime * result + historyId;
		result = prime * result + surveyId;
		result = prime * result + ((userEmail == null) ? 0 : userEmail.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		History other = (History) obj;
		if (dateAssigned == null) {
			if (other.dateAssigned != null)
				return false;
		} else if (!dateAssigned.equals(other.dateAssigned))
			return false;
		if (dateCompleted == null) {
			if (other.dateCompleted != null)
				return false;
		} else if (!dateCompleted.equals(other.dateCompleted))
			return false;
		if (historyId != other.historyId)
			return false;
		if (surveyId != other.surveyId)
			return false;
		if (userEmail == null) {
			if (other.userEmail != null)
				return false;
		} else if (!userEmail.equals(other.userEmail))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "History [historyId=" + historyId + ", surveyId=" + surveyId + ", userEmail=" + userEmail
				+ ", dateAssigned=" + dateAssigned + ", dateCompleted=" + dateCompleted + "]";
	}

}
