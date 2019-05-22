package com.revature.repos;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import com.revature.models.Responses;

public interface ResponsesRepo  extends JpaRepository<Responses, Integer>{

	List<Responses> findBySurveyIdSurveyId(int id);
	List<Responses> findByUserEmail(String userEmail);

}