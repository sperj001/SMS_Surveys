package com.revature.repos;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.revature.models.Question;

public interface QuestionRepo extends JpaRepository<Question, Integer> {

	List<Question> findByTypeId(int typeId);

}