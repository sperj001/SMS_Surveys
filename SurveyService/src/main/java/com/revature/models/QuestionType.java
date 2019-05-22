package com.revature.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@Table(name = "question_type")
public class QuestionType {

	@Id
	@Column(name = "id", unique = true)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int id;
	
	@NotNull
	String questionType;
	
	
	public QuestionType() {
		super();
		// TODO Auto-generated constructor stub
	}

	public QuestionType(int id, @NotNull String questionType) {
		super();
		this.id = id;
		this.questionType = questionType;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getQuestionType() {
		return questionType;
	}
	public void setQuestionType(String questionType) {
		this.questionType = questionType;
	}
	
	@Override
	public String toString() {
		return "QuestionTypeController [Id=" + id + ", questionType=" + questionType + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		result = prime * result + ((questionType == null) ? 0 : questionType.hashCode());
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
		QuestionType other = (QuestionType) obj;
		if (id != other.id)
			return false;
		if (questionType == null) {
			if (other.questionType != null)
				return false;
		} else if (!questionType.equals(other.questionType))
			return false;
		return true;
	}



}
