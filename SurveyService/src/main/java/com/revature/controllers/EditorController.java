package com.revature.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

import javax.validation.Valid;

import com.revature.models.Editor;
import com.revature.services.EditorServiceImpl;

@RestController
@RequestMapping("editors")//Maps this class to table editors in DB
public class EditorController {
    
	//Tells Spring to connect bean automatically
	@Autowired
	private EditorServiceImpl eSI;

	// we find all editors here using repo method findAll()
	@GetMapping
	List<Editor> findAll() {
		return eSI.findAll();
	}

	// Obtain id from URL and pass it to method find editor by id
	@GetMapping("/{id}")
	public List<Editor> findEditorById(@PathVariable int id) {
		return eSI.findById(id);
	}

	 /* Obtains email from URL and pass it to method to find editor by email. We used
	@PostMapping because correct email cant be passed in using
	GetMapping*/
	@PostMapping("/email")
	public List<Editor> findByEmail(@Valid @RequestBody String email) {
		return eSI.findByEmail(email);
	}

	@GetMapping("/surveyId/{id}")
	public List<Editor> findBySurveyIdSurveyId(@PathVariable int id) {
		return eSI.findBySurveyIdSurveyId(id);
	}

	// Creates editor by calling method createEditor from EditorServiceImpl class
	@PostMapping
	public Editor createEditor(@RequestBody Editor editor) {
		return eSI.createEditor(editor);
	}

	// Updates editor by calling method updateEditor from the EditorServiceImpl
	// class
	@PatchMapping
	public Editor updateEditor(@RequestBody Editor editor) {
		return eSI.updateEditor(editor);
	}

    ////Deletes editor by calling method updateEditor from the EditorServiceImpl class
	@DeleteMapping
	public String deleteEditor(int id) {
		return eSI.deleteEditor(id);
		
	}

//	@ExceptionHandler(Exception.class)
//	public ResponseEntity<String> handleExceptions(Exception e) {
//		return new ResponseEntity<String>("An error has occurred", HttpStatus.INTERNAL_SERVER_ERROR);
//	}

}
