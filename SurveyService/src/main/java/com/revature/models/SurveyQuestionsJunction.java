package com.revature.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "junction_survey_questions")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SurveyQuestionsJunction {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name = "survey_id")
	private Survey surveyId;
	
	@ManyToOne
	@JoinColumn(name = "question_id")
	private Question questionId;
	
	@NotNull
	@Column(name = "question_order")
	private int questionOrder;

	public SurveyQuestionsJunction(int id, Survey surveyId, Question questionId, @NotNull int questionOrder) {
		super();
		this.id = id;
		this.surveyId = surveyId;
		this.questionId = questionId;
		this.questionOrder = questionOrder;
	}

	public SurveyQuestionsJunction() {
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
	 * @return the questionId
	 */
	public Question getQuestionId() {
		return questionId;
	}

	/**
	 * @param questionId the questionId to set
	 */
	public void setQuestionId(Question questionId) {
		this.questionId = questionId;
	}

	/**
	 * @return the questionOrder
	 */
	public int getQuestionOrder() {
		return questionOrder;
	}

	/**
	 * @param questionOrder the questionOrder to set
	 */
	public void setQuestionOrder(int questionOrder) {
		this.questionOrder = questionOrder;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		result = prime * result + ((questionId == null) ? 0 : questionId.hashCode());
		result = prime * result + questionOrder;
		result = prime * result + ((surveyId == null) ? 0 : surveyId.hashCode());
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
		SurveyQuestionsJunction other = (SurveyQuestionsJunction) obj;
		if (id != other.id)
			return false;
		if (questionId == null) {
			if (other.questionId != null)
				return false;
		} else if (!questionId.equals(other.questionId))
			return false;
		if (questionOrder != other.questionOrder)
			return false;
		if (surveyId == null) {
			if (other.surveyId != null)
				return false;
		} else if (!surveyId.equals(other.surveyId))
			return false;
		return true;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SurveyQuestionsJunction [id=" + id + ", surveyId=" + surveyId + ", questionId=" + questionId
				+ ", questionOrder=" + questionOrder + "]";
	}

}
