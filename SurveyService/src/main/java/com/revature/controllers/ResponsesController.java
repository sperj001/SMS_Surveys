package com.revature.controllers;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.revature.models.Responses;
import com.revature.services.ResponsesService;

@RestController
@RequestMapping("responses")
public class ResponsesController {
	
	@Autowired
	private ResponsesService responseService;
	
	@GetMapping("")
	public List<Responses> findAll() {
		return responseService.findAll();
	}
	
	@GetMapping("/{id}")
	public Responses findById(@PathVariable int id) {
		return responseService.findById(id);
	}
	
	@GetMapping("/surveyId/{id}")
	public List<Responses> findBySurveyId(@PathVariable int id) {
		return responseService.findBySurveyIdSurveyId(id);
	}
	
	// Query for email. Uses post mapping so that the @ symbol can be send in the body rather than in the URL
    @PostMapping("/email")
    public List<Responses> findByEmail(@Valid @RequestBody String email) {
        return responseService.findByUserEmail(email);
    }

	@PostMapping("/multi-response")
	public List<Responses> multipleQuestions(@RequestBody List<Responses> responses) {
		return responseService.saveMultiple(responses);
	}

	@PostMapping
	public int save(@Valid @RequestBody Responses r) {
		Responses responses = responseService.save(r);
		return responses.getId();
	}
}
