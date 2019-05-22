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
@Table(name = "surveys")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class Survey {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)	
	@Column(name = "id")
	private int surveyId;
	
	@NotNull
	private String title;
	
	@NotNull
	private String description;
	
	@Column(name = "date_created")
	@NotNull
	private Date dateCreated;
	
	@Column(name = "closing_date")
	private Date closingDate;
	
	private boolean template;
	
	private boolean published;

	public Survey(int surveyId, @NotNull String title, @NotNull String description, @NotNull Date dateCreated,
			Date closingDate, boolean template, boolean published) {
		super();
		this.surveyId = surveyId;
		this.title = title;
		this.description = description;
		this.dateCreated = dateCreated;
		this.closingDate = closingDate;
		this.template = template;
		this.published = published;
	}

	public Survey() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @return the surveyId
	 */
	public int getSurveyId() {
		return surveyId;
	}

	/**
	 * @param surveyId the surveyId to set
	 */
	public void setSurveyId(int surveyId) {
		this.surveyId = surveyId;
	}

	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * @return the dateCreated
	 */
	public Date getDateCreated() {
		return dateCreated;
	}

	/**
	 * @param dateCreated the dateCreated to set
	 */
	public void setDateCreated(Date dateCreated) {
		this.dateCreated = dateCreated;
	}

	/**
	 * @return the closingDate
	 */
	public Date getClosingDate() {
		return closingDate;
	}

	/**
	 * @param closingDate the closingDate to set
	 */
	public void setClosingDate(Date closingDate) {
		this.closingDate = closingDate;
	}

	/**
	 * @return the template
	 */
	public boolean isTemplate() {
		return template;
	}

	/**
	 * @param template the template to set
	 */
	public void setTemplate(boolean template) {
		this.template = template;
	}

	/**
	 * @return the published
	 */
	public boolean isPublished() {
		return published;
	}

	/**
	 * @param published the published to set
	 */
	public void setPublished(boolean published) {
		this.published = published;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((closingDate == null) ? 0 : closingDate.hashCode());
		result = prime * result + ((dateCreated == null) ? 0 : dateCreated.hashCode());
		result = prime * result + ((description == null) ? 0 : description.hashCode());
		result = prime * result + (published ? 1231 : 1237);
		result = prime * result + surveyId;
		result = prime * result + (template ? 1231 : 1237);
		result = prime * result + ((title == null) ? 0 : title.hashCode());
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
		Survey other = (Survey) obj;
		if (closingDate == null) {
			if (other.closingDate != null)
				return false;
		} else if (!closingDate.equals(other.closingDate))
			return false;
		if (dateCreated == null) {
			if (other.dateCreated != null)
				return false;
		} else if (!dateCreated.equals(other.dateCreated))
			return false;
		if (description == null) {
			if (other.description != null)
				return false;
		} else if (!description.equals(other.description))
			return false;
		if (published != other.published)
			return false;
		if (surveyId != other.surveyId)
			return false;
		if (template != other.template)
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		return true;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Survey [surveyId=" + surveyId + ", title=" + title + ", description=" + description + ", dateCreated="
				+ dateCreated + ", closingDate=" + closingDate + ", template=" + template + ", published=" + published
				+ "]";
	}

}