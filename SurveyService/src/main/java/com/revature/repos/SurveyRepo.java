package com.revature.repos;

import org.springframework.data.jpa.repository.JpaRepository;
import com.revature.models.Survey;
import java.util.List;

public interface SurveyRepo extends JpaRepository<Survey, Integer> {

	List<Survey> findByTitle(String title);

}