package com.revature.models;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "survey_history")
public class SurveyHistory {
	
	@Id
	@Column(name = "id", unique = true)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int id;
	
	@NotNull//needs to be join column and vairble needs to be the survey model
	int survey_id;
	
	@NotNull
	String useremail;
	
	@NotNull
	Date date_assigned;
	
	@NotNull
	Date date_completed;
}
