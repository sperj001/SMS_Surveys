package com.revature.repos;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.revature.models.SurveyQuestionsJunction;

public interface SurveyQuestionsJunctionRepo extends JpaRepository <SurveyQuestionsJunction, Integer>{

	List<SurveyQuestionsJunction> findBySurveyIdSurveyId(int surveyId);
	List<SurveyQuestionsJunction> findByQuestionIdQuestionId(int questionId);

}