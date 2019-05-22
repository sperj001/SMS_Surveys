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

import com.revature.cognito.annotations.CognitoAuth;
import com.revature.cognito.constants.CognitoRoles;
import com.revature.models.Survey;
import com.revature.services.SurveyService;

@RestController
@RequestMapping("surveys")
public class SurveyController {

	@Autowired
	private SurveyService surveyService;

	// All Surveys and Templates
	@GetMapping("")
	public List<Survey> findAll() {
		return surveyService.findAll();
	}

	@GetMapping("/{id}")
	public Survey findById(@PathVariable int id) {
		return surveyService.findById(id);
	}

	@GetMapping("/title/{title}")
	public List<Survey> findByTitle(@PathVariable String title) {
		return surveyService.findByTitle(title);
	}

	@CognitoAuth(roles= {CognitoRoles.STAGING_MANAGER, CognitoRoles.TRAINER})
	@PostMapping
	public Survey save(@Valid @RequestBody Survey s) {
		Survey survey = surveyService.save(s);
		return survey;
	}
}