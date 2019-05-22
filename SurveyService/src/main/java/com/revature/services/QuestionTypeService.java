package com.revature.services;

import java.util.List;
import com.revature.models.QuestionType;

public interface QuestionTypeService {

	public List<QuestionType> findAll();

	public QuestionType findById(int id);

}
