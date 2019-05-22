package com.revature.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.revature.models.Responses;
import com.revature.models.Survey;
import com.revature.repos.ResponsesRepo;

@Service
public class ResponsesServiceImpl implements ResponsesService {
	
	@Autowired
	private ResponsesRepo responseRepo;

	@Override
	public List<Responses> findAll() {
		return responseRepo.findAll();
	}

	@Override
	public Responses findById(int id) {
		return responseRepo.getOne(id);
	}

	@Override
	public List<Responses> findBySurveyIdSurveyId(int id) {
		return responseRepo.findBySurveyIdSurveyId(id);
	}

	@Override
	public List<Responses> findByUserEmail(String userEmail) {
		return responseRepo.findByUserEmail(userEmail);
	}

	@Override
	public Responses save(Responses r) {
		r.setId(0);
		return responseRepo.save(r);
	}

	@Override
	public Responses update(Responses r) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Responses delete(Responses r) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Responses> saveMultiple(List<Responses> responses) {
		responses.forEach(response -> {
			save(response);
		});
		return responses;
	}

}
