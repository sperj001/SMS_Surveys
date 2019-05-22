package com.revature.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.revature.models.QuestionType;
import com.revature.repos.QuestionTypeRepo;

@Service
public class QuestionTypeServiceImpl implements QuestionTypeService {
	
	@Autowired
	private QuestionTypeRepo questionTypeRepo;
	
	@Override
	public List<QuestionType> findAll() {
		// TODO Auto-generated method stub
		return questionTypeRepo.findAll();
	}

	@Override
	public QuestionType findById(int id) {
		// TODO Auto-generated method stub
		return questionTypeRepo.getOne(id);
	}

}
