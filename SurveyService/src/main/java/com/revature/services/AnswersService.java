package com.revature.services;


import java.util.List;
import com.revature.models.Answers;

public interface AnswersService {

	Answers save(Answers A);
	Answers update(Answers A);
    Answers delete(Answers A);
    
    List<Answers> findAll();
    Answers findById(int id);
    List<Answers> findByQuestionId(int questionId);
    List<Answers> saveMultiple(List<Answers> answers);

}
