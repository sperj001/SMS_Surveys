package com.revature.controllers;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.revature.models.Answers;
import com.revature.services.AnswersService;

@RestController
@RequestMapping("answers")
public class AnswersController {

	@Autowired 
	private AnswersService answerService;
	
	
	@GetMapping
	public List<Answers> findAll(){
		return answerService.findAll();
	}
	
	@GetMapping("/{id}")
	public Answers findById(@PathVariable int id) {
		return answerService.findById(id);
	}

	@GetMapping("/question/{questionId}")
	public List<Answers> findByQuestionId(@PathVariable int questionId) {
		return answerService.findByQuestionId(questionId);
	}
	
	@PostMapping
	public Answers save(@Valid @RequestBody Answers A) {
		return answerService.save(A);
	}
	
	@PostMapping("/multi-answers")
	public List<Answers> multipleAnswers(@RequestBody List<Answers> answers) {
		return answerService.saveMultiple(answers);
	}
	
	@ExceptionHandler(Exception.class)
	public ResponseEntity<String> handleExceptions(Exception e) {
		return new ResponseEntity<String>("An error has occured", HttpStatus.INTERNAL_SERVER_ERROR);
	}

}
