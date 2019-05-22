package com.revature.repos;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.revature.models.Answers;

@Repository
public interface AnswersRepo  extends JpaRepository <Answers, Integer>{

	List<Answers> findByQuestionId(int questionId);
	
	
}
