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

import com.revature.models.SurveyQuestionsJunction;
import com.revature.services.SurveyQuestionsJunctionService;

@RestController
@RequestMapping("junction_survey_questions")
public class SurveyQuestionsJunctionController {
	
	@Autowired
	private SurveyQuestionsJunctionService surveyQuestionsJunctionService;
	
	@GetMapping
	public List<SurveyQuestionsJunction> findAll() {
		return surveyQuestionsJunctionService.findAll();
	}

	@GetMapping("/{id}")
	public SurveyQuestionsJunction findById(@PathVariable int id) {
		return surveyQuestionsJunctionService.findById(id);
	}

	@GetMapping("/surveyId/{id}")
	public List<SurveyQuestionsJunction> findBySurveyIdSurveyId(@PathVariable int id) {
		return surveyQuestionsJunctionService.findBySurveyIdSurveyId(id);
	}
	
	@GetMapping("/questionId/{id}")
	public List<SurveyQuestionsJunction> findByQuestionIdQuestionId(@PathVariable int id) {
		return surveyQuestionsJunctionService.findByQuestionIdQuestionId(id);
	}

	@PostMapping("/multi-question")
	public List<SurveyQuestionsJunction> multipleQuestions(@RequestBody List<SurveyQuestionsJunction> surveyQuestionsJunctions) {
		return surveyQuestionsJunctionService.saveMultiple(surveyQuestionsJunctions);
	}

	@PostMapping
	public int save(@Valid @RequestBody SurveyQuestionsJunction sqj) {
		SurveyQuestionsJunction surveyQuestionsJunction = surveyQuestionsJunctionService.save(sqj);
		return surveyQuestionsJunction.getId();
	}
	
}
