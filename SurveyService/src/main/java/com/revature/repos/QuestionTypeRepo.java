package com.revature.repos;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.revature.models.QuestionType;

@Repository
public interface QuestionTypeRepo extends JpaRepository<QuestionType, Integer> {

}
