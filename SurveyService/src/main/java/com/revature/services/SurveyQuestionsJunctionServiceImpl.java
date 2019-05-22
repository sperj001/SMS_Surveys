package com.revature.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.revature.models.SurveyQuestionsJunction;
import com.revature.repos.SurveyQuestionsJunctionRepo;

@Service
public class SurveyQuestionsJunctionServiceImpl implements SurveyQuestionsJunctionService {
	
	@Autowired
	private SurveyQuestionsJunctionRepo surveyQuestionsJunctionRepo;


	@Override
	public SurveyQuestionsJunction save(SurveyQuestionsJunction sqj) {
		sqj.setId(0);
		return surveyQuestionsJunctionRepo.save(sqj);
	}

	@Override
	public SurveyQuestionsJunction update(SurveyQuestionsJunction sqj) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public SurveyQuestionsJunction delete(SurveyQuestionsJunction sqj) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SurveyQuestionsJunction> findAll() {
		return surveyQuestionsJunctionRepo.findAll();
	}

	@Override
	public SurveyQuestionsJunction findById(int id) {
		return surveyQuestionsJunctionRepo.getOne(id);
	}

	@Override
	public List<SurveyQuestionsJunction> findBySurveyIdSurveyId(int surveyId) {
		return surveyQuestionsJunctionRepo.findBySurveyIdSurveyId(surveyId);
	}

	@Override
	public List<SurveyQuestionsJunction> findByQuestionIdQuestionId(int questionId) {
		return surveyQuestionsJunctionRepo.findByQuestionIdQuestionId(questionId);
	}

	@Override
	public List<SurveyQuestionsJunction> saveMultiple(List<SurveyQuestionsJunction> surveyQuestionsJunctions) {
		surveyQuestionsJunctions.forEach(surveyQuestionsJunction -> {
			save(surveyQuestionsJunction);
		});
		return surveyQuestionsJunctions;
	}

}
