package com.revature.controllers;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.revature.models.History;
import com.revature.services.HistoryService;

@RestController
@RequestMapping("history")
public class HistoryController {

	@Autowired
	private HistoryService historyService;

	@GetMapping("")
	public List<History> findAll() {
		return historyService.findAll();
	}

	@GetMapping("/{id}")
	public History findById(@PathVariable int id) {
		return historyService.findById(id);
	}
	
	@GetMapping("/survey/{surveyId}")
	public List<History> findBySurveyId(@PathVariable int surveyId) {
		return historyService.findBySurveyId(surveyId);
	}
	
	// Query for email. Uses post mapping so that the @ symbol can be send in the body rather than in the URL
	@PostMapping("/email")
	public List<History> findByEmail(@Valid @RequestBody String email) {
		return historyService.findByEmail(email);
	}
	
	@GetMapping("/completed")
	public List<History> findCompleted() {
		return historyService.findCompleted();
	}
	
	@GetMapping("/incomplete")
	public List<History> findIncomplete() {
		return historyService.findIncomplete();
	}

	@PostMapping
	public History save(@Valid @RequestBody History h) {
		History history = historyService.save(h);
		return history;
	}
	
	@PatchMapping("/taken")
	public History update(@Valid @RequestBody History h) {
		History history = historyService.update(h);
		System.out.println("Success");
		return history;
	}
}