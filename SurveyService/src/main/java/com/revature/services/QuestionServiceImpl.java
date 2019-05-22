package com.revature.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.revature.models.Question;
import com.revature.repos.QuestionRepo;
import com.revature.services.QuestionService;

@Service
public class QuestionServiceImpl implements QuestionService {
	@Autowired
	private QuestionRepo questionRepo;

	@Override
	public List<Question> findAll() {
		return questionRepo.findAll();
	}

	@Override
	public Question findById(int id) {
		return questionRepo.getOne(id);
	}

	@Override
	public List<Question> findByType(int typeId) {
		return questionRepo.findByTypeId(typeId);
	}
	
	@Override
	public Question save(Question q) {
		q.setQuestionId(0);
		return questionRepo.save(q);
	}

	@Override
	public List<Question> saveMultiple(List<Question> questions) {
		questions.forEach(question -> {
			save(question);
		});
		return questions;
	}
}