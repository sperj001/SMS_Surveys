package com.revature.repos;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.revature.models.History;
import java.util.List;

public interface HistoryRepo extends JpaRepository<History, Integer> {
	
	List<History> findBySurveyId(int surveyId);

	List<History> findByUserEmail(String email);

	@Query(value = "SELECT * FROM survey.survey_history WHERE date_completed IS NOT NULL", nativeQuery = true)
	List<History> findCompleted();

	@Query(value = "SELECT * FROM survey.survey_history WHERE date_completed IS NULL", nativeQuery = true)
	List<History> findIncomplete();

}