package com.revature.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.revature.cognito.utils.CognitoUtil;
import com.revature.models.Survey;
import com.revature.repos.SurveyRepo;
import com.revature.services.SurveyService;

@Service
public class SurveyServiceImpl implements SurveyService {
	@Autowired
	private SurveyRepo surveyRepo;
	
	@Autowired
	private CognitoUtil cognitoUtil;

	@Override
	public Survey update(Survey s) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Survey delete(Survey s) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Survey> findAll() {
		return surveyRepo.findAll();
	}

	@Override
	public Survey findById(int id) {
		return surveyRepo.getOne(id);
	}

	@Override
	public List<Survey> findByTitle(String title) {
		return surveyRepo.findByTitle(title);
	}

	@Override
	public Survey save(Survey s) {
		s.setSurveyId(0);
		return surveyRepo.save(s);
	}

}