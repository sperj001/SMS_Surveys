package com.revature.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "responses")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Responses {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "user_email")
	private String userEmail;
	
	@ManyToOne
	@JoinColumn(name = "survey_id")
	private Survey surveyId;
	
	@ManyToOne
	@JoinColumn(name = "answer_id")
	private Answers answerId;

	public Responses(int id, String userEmail, Survey surveyId, Answers answerId) {
		super();
		this.id = id;
		this.userEmail = userEmail;
		this.surveyId = surveyId;
		this.answerId = answerId;
	}

	public Responses() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * @return the userEmailString
	 */
	public String getUserEmailString() {
		return userEmail;
	}

	/**
	 * @param userEmailString the userEmailString to set
	 */
	public void setUserEmailString(String userEmailString) {
		this.userEmail = userEmailString;
	}

	/**
	 * @return the surveyId
	 */
	public Survey getSurveyId() {
		return surveyId;
	}

	/**
	 * @param surveyId the surveyId to set
	 */
	public void setSurveyId(Survey surveyId) {
		this.surveyId = surveyId;
	}

	/**
	 * @return the answerId
	 */
	public Answers getAnswerId() {
		return answerId;
	}

	/**
	 * @param answerId the answerId to set
	 */
	public void setAnswerId(Answers answerId) {
		this.answerId = answerId;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((answerId == null) ? 0 : answerId.hashCode());
		result = prime * result + id;
		result = prime * result + ((surveyId == null) ? 0 : surveyId.hashCode());
		result = prime * result + ((userEmail == null) ? 0 : userEmail.hashCode());
		return result;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Responses other = (Responses) obj;
		if (answerId == null) {
			if (other.answerId != null)
				return false;
		} else if (!answerId.equals(other.answerId))
			return false;
		if (id != other.id)
			return false;
		if (surveyId == null) {
			if (other.surveyId != null)
				return false;
		} else if (!surveyId.equals(other.surveyId))
			return false;
		if (userEmail == null) {
			if (other.userEmail != null)
				return false;
		} else if (!userEmail.equals(other.userEmail))
			return false;
		return true;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Responses [id=" + id + ", userEmailString=" + userEmail + ", surveyId=" + surveyId + ", answerId="
				+ answerId + "]";
	}
	
	
}
