-- Code to initially create and populate the sql database

--Make the schema
DROP SCHEMA IF EXISTS survey CASCADE;
CREATE SCHEMA survey;

SET SCHEMA 'survey';

-------------------
-- Create Tables --
-------------------

CREATE TABLE surveys (
	id SERIAL PRIMARY KEY,
	title TEXT NOT NULL,
	description TEXT,
	date_created DATE NOT NULL,
	closing_date DATE,
	"template" BOOL NOT NULL,
	published BOOL NOT NULL
	CONSTRAINT template_or_published CHECK (
		("template" IS FALSE AND published IS FALSE)
		OR ("template" IS TRUE AND published IS FALSE)
		OR ("template" IS FALSE AND published IS TRUE)
));

CREATE TABLE editors (
	id SERIAL PRIMARY KEY,
	email TEXT NOT NULL,
	survey_id INT REFERENCES surveys(id) ON DELETE RESTRICT
);

CREATE TABLE survey_history (
	id SERIAL PRIMARY KEY,
	survey_id INT REFERENCES surveys(id) ON DELETE RESTRICT,
	user_email TEXT NOT NULL,
	date_assigned DATE NOT NULL,
	date_completed DATE
);

CREATE TABLE question_type (
	id SERIAL PRIMARY KEY,
	question_type TEXT NOT NULL UNIQUE
);

CREATE TABLE questions (
	id SERIAL PRIMARY KEY,
	question TEXT NOT NULL,
	type_id INT REFERENCES question_type(id) ON DELETE RESTRICT
);

CREATE TABLE junction_survey_questions (
	id SERIAL PRIMARY KEY,
	survey_id INT REFERENCES surveys(id) ON DELETE RESTRICT,
	question_id INT REFERENCES questions(id) ON DELETE RESTRICT,
	question_order INT
);

CREATE TABLE answers (
	id SERIAL PRIMARY KEY,
	answer TEXT NOT NULL,
	question_id INT REFERENCES questions(id) ON DELETE RESTRICT
);

CREATE TABLE responses (
	id SERIAL PRIMARY KEY,
	user_email TEXT,
	survey_id INT REFERENCES surveys(id) ON DELETE RESTRICT,
	answer_id INT REFERENCES answers(id) ON DELETE RESTRICT
);

------------------
-- Create Views --
------------------
CREATE VIEW user_responses AS
SELECT
	sh.user_email AS "User",
	s.title AS "Title",
	s.description AS "Description",
	s.date_created AS "Survey Created",
	s.closing_date AS "Survey Closes",
	sh.date_assigned AS "Assigned to User",
	sh.date_completed AS "Completed",
	q.question AS "Question",
	a.answer AS "Response"
FROM surveys s
JOIN survey_history sh ON s.id = sh.survey_id
JOIN junction_survey_questions j ON s.id = j.survey_id
JOIN questions q ON  q.id = j.question_id
JOIN answers a ON q.id = a.question_id
JOIN responses r ON a.id = r.answer_id AND r.user_email = sh.user_email;

---------------------
-- Populate Tables --
---------------------
INSERT INTO question_type (question_type) VALUES ('Boolean'), ('Single Choice'), ('Multiple Answer'), ('Rating'), ('Open Ended'), ('Yes/No'), ('Agree/Disagree');

-- Insert Template 1
INSERT INTO surveys (title, description, date_created, "template", published) VALUES ('QC Survey', 'A survey for training feedback.', '02-28-2019', TRUE, FALSE);
INSERT INTO questions (question, type_id) VALUES ('Name (Optional)', 5);
INSERT INTO questions (question, type_id) VALUES ('Email (Optional)', 5);
INSERT INTO questions (question, type_id) VALUES ('What was your most recently completed week of training?', 3);
INSERT INTO questions (question, type_id) VALUES ('How satisfied were you with the Training? ', 4);
INSERT INTO questions (question, type_id) VALUES ('Materials provided were helpful', 7);
INSERT INTO questions (question, type_id) VALUES ('Content/Project Planning was well organized', 7);
INSERT INTO questions (question, type_id) VALUES ('Questions were encouraged and answered', 7);
INSERT INTO questions (question, type_id) VALUES ('Training and Projects met my expectations', 7);
INSERT INTO questions (question, type_id) VALUES ('Have you started working on your portfolio?', 6);
INSERT INTO questions (question, type_id) VALUES ('Any additional comments regarding above ratings', 5);
INSERT INTO questions (question, type_id) VALUES ('Any overall feedback (Training / Trainer / QC)', 5);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (1, 1, 1);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (1, 2, 2);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (1, 3, 3);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (1, 4, 4);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (1, 5, 5);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (1, 6, 6);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (1, 7, 7);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (1, 8, 8);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (1, 9, 9);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (1, 10, 10);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (1, 11, 11);
INSERT INTO answers (answer, question_id) VALUES ('Week 1', 3);
INSERT INTO answers (answer, question_id) VALUES ('Week 2', 3);
INSERT INTO answers (answer, question_id) VALUES ('Week 3', 3);
INSERT INTO answers (answer, question_id) VALUES ('Week 4', 3);
INSERT INTO answers (answer, question_id) VALUES ('Week 5', 3);
INSERT INTO answers (answer, question_id) VALUES ('Week 6', 3);
INSERT INTO answers (answer, question_id) VALUES ('Week 7', 3);
INSERT INTO answers (answer, question_id) VALUES ('Week 8', 3);
INSERT INTO answers (answer, question_id) VALUES ('Week 9', 3);
INSERT INTO answers (answer, question_id) VALUES ('Week 10', 3);
INSERT INTO answers (answer, question_id) VALUES ('Week 11', 3);
INSERT INTO answers (answer, question_id) VALUES ('Week 12', 3);
INSERT INTO answers (answer, question_id) VALUES ('Week 13', 3);
INSERT INTO answers (answer, question_id) VALUES ('Week 14 or Later', 3);
INSERT INTO answers (answer, question_id) VALUES ('1', 4);
INSERT INTO answers (answer, question_id) VALUES ('2', 4);
INSERT INTO answers (answer, question_id) VALUES ('3', 4);
INSERT INTO answers (answer, question_id) VALUES ('4', 4);
INSERT INTO answers (answer, question_id) VALUES ('5', 4);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Agree', 5);
INSERT INTO answers (answer, question_id) VALUES ('Agree', 5);
INSERT INTO answers (answer, question_id) VALUES ('Disagree', 5);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Disagree', 5);
INSERT INTO answers (answer, question_id) VALUES ('N/A', 5);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Agree', 6);
INSERT INTO answers (answer, question_id) VALUES ('Agree', 6);
INSERT INTO answers (answer, question_id) VALUES ('Disagree', 6);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Disagree', 6);
INSERT INTO answers (answer, question_id) VALUES ('N/A', 6);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Agree', 7);
INSERT INTO answers (answer, question_id) VALUES ('Agree', 7);
INSERT INTO answers (answer, question_id) VALUES ('Disagree', 7);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Disagree', 7);
INSERT INTO answers (answer, question_id) VALUES ('N/A', 6);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Agree', 8);
INSERT INTO answers (answer, question_id) VALUES ('Agree', 8);
INSERT INTO answers (answer, question_id) VALUES ('Disagree', 8);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Disagree', 8);
INSERT INTO answers (answer, question_id) VALUES ('N/A', 8);
INSERT INTO answers (answer, question_id) VALUES ('Yes', 9);
INSERT INTO answers (answer, question_id) VALUES ('No', 9);

-- Insert Template 2
INSERT INTO surveys (title, description, date_created, "template", published) VALUES ('Staging Manager Evaluation', 'A survey for associates in staging to evaluate the staging manager.', '03-07-2019', TRUE, FALSE);
INSERT INTO questions (question, type_id) VALUES ('Name (Optional)', 5);
INSERT INTO questions (question, type_id) VALUES ('Email (Optional)', 5);
INSERT INTO questions (question, type_id) VALUES ('How many weeks have you been in staging?', 3);
INSERT INTO questions (question, type_id) VALUES ('My time in staging been productive.', 6);
INSERT INTO questions (question, type_id) VALUES ('How well has the staging manager helped you with being prepared for interviews?', 4);
INSERT INTO questions (question, type_id) VALUES ('Any additional comments regarding above ratings?', 5);
INSERT INTO questions (question, type_id) VALUES ('Any overall feedback?', 5);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (2, 12, 1);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (2, 13, 2);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (2, 14, 3);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (2, 15, 4);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (2, 16, 5);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (2, 17, 6);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (2, 18, 7);
INSERT INTO answers (answer, question_id) VALUES ('<1 Week', 14);
INSERT INTO answers (answer, question_id) VALUES ('1 Week', 14);
INSERT INTO answers (answer, question_id) VALUES ('2 Weeks', 14);
INSERT INTO answers (answer, question_id) VALUES ('3 Weeks', 14);
INSERT INTO answers (answer, question_id) VALUES ('4 Weeks', 14);
INSERT INTO answers (answer, question_id) VALUES ('5 Weeks', 14);
INSERT INTO answers (answer, question_id) VALUES ('6 Weeks', 14);
INSERT INTO answers (answer, question_id) VALUES ('7 Weeks', 14);
INSERT INTO answers (answer, question_id) VALUES ('8 Weeks', 14);
INSERT INTO answers (answer, question_id) VALUES ('9 Weeks', 14);
INSERT INTO answers (answer, question_id) VALUES ('10 Weeks', 14);
INSERT INTO answers (answer, question_id) VALUES ('>10 Weeks', 14);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Agree', 15);
INSERT INTO answers (answer, question_id) VALUES ('Agree', 15);
INSERT INTO answers (answer, question_id) VALUES ('Disagree', 15);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Disagree', 15);
INSERT INTO answers (answer, question_id) VALUES ('N/A', 15);
INSERT INTO answers (answer, question_id) VALUES ('1', 16);
INSERT INTO answers (answer, question_id) VALUES ('2', 16);
INSERT INTO answers (answer, question_id) VALUES ('3', 16);
INSERT INTO answers (answer, question_id) VALUES ('4', 16);
INSERT INTO answers (answer, question_id) VALUES ('5', 16);

--Insert Template 3
INSERT INTO surveys (title, description, date_created, "template", published) VALUES ('Check In Survey', 'A survey for associates in virtual staging to check in.', '03-11-2019', TRUE, FALSE);
INSERT INTO questions (question, type_id) VALUES ('How long do you have until you begin work at your assigned location?', 5);
INSERT INTO questions (question, type_id) VALUES ('Are you prepared to start work at your work location?', 6);
INSERT INTO questions (question, type_id) VALUES ('How smooth was the transition to virtual staging?', 4);
INSERT INTO questions (question, type_id) VALUES ('Any additional comments regarding above ratings?', 5);
INSERT INTO questions (question, type_id) VALUES ('Any overall feedback?', 5);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (3, 19, 1);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (3, 20, 2);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (3, 21, 3);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (3, 22, 4);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (3, 23, 5);
INSERT INTO answers (answer, question_id) VALUES ('Yes', 20);
INSERT INTO answers (answer, question_id) VALUES ('No', 20);
INSERT INTO answers (answer, question_id) VALUES ('1', 21);
INSERT INTO answers (answer, question_id) VALUES ('2', 21);
INSERT INTO answers (answer, question_id) VALUES ('3', 21);
INSERT INTO answers (answer, question_id) VALUES ('4', 21);
INSERT INTO answers (answer, question_id) VALUES ('5', 21);

-- Insert Survey 1
INSERT INTO surveys (title, description, date_created, "template", published) VALUES ('QC Survey', 'A survey for training feedback.', '02-28-2019', FALSE, TRUE);
INSERT INTO questions (question, type_id) VALUES ('Name (Optional)', 5);
INSERT INTO questions (question, type_id) VALUES ('Email (Optional)', 5);
INSERT INTO questions (question, type_id) VALUES ('What was your most recently completed week of training?', 3);
INSERT INTO questions (question, type_id) VALUES ('How satisfied were you with the Training? ', 4);
INSERT INTO questions (question, type_id) VALUES ('Materials provided were helpful', 7);
INSERT INTO questions (question, type_id) VALUES ('Content/Project Planning was well organized', 7);
INSERT INTO questions (question, type_id) VALUES ('Questions were encouraged and answered', 7);
INSERT INTO questions (question, type_id) VALUES ('Training and Projects met my expectations', 7);
INSERT INTO questions (question, type_id) VALUES ('Have you started working on your portfolio?', 6);
INSERT INTO questions (question, type_id) VALUES ('Any additional comments regarding above ratings', 5);
INSERT INTO questions (question, type_id) VALUES ('Any overall feedback (Training / Trainer / QC)', 5);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (4, 24, 1);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (4, 25, 2);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (4, 26, 3);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (4, 27, 4);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (4, 28, 5);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (4, 29, 6);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (4, 30, 7);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (4, 31, 8);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (4, 32, 9);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (4, 33, 10);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (4, 34, 11);
INSERT INTO answers (answer, question_id) VALUES ('Week 1', 26);
INSERT INTO answers (answer, question_id) VALUES ('Week 2', 26);
INSERT INTO answers (answer, question_id) VALUES ('Week 3', 26);
INSERT INTO answers (answer, question_id) VALUES ('Week 4', 26);
INSERT INTO answers (answer, question_id) VALUES ('Week 5', 26);
INSERT INTO answers (answer, question_id) VALUES ('Week 6', 26);
INSERT INTO answers (answer, question_id) VALUES ('Week 7', 26);
INSERT INTO answers (answer, question_id) VALUES ('Week 8', 26);
INSERT INTO answers (answer, question_id) VALUES ('Week 9', 26);
INSERT INTO answers (answer, question_id) VALUES ('Week 10', 26);
INSERT INTO answers (answer, question_id) VALUES ('Week 11', 26);
INSERT INTO answers (answer, question_id) VALUES ('Week 12', 26);
INSERT INTO answers (answer, question_id) VALUES ('Week 13', 26);
INSERT INTO answers (answer, question_id) VALUES ('Week 14 or Later', 26);
INSERT INTO answers (answer, question_id) VALUES ('1', 27);
INSERT INTO answers (answer, question_id) VALUES ('2', 27);
INSERT INTO answers (answer, question_id) VALUES ('3', 27);
INSERT INTO answers (answer, question_id) VALUES ('4', 27);
INSERT INTO answers (answer, question_id) VALUES ('5', 27);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Agree', 28);
INSERT INTO answers (answer, question_id) VALUES ('Agree', 28);
INSERT INTO answers (answer, question_id) VALUES ('Disagree', 28);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Disagree', 28);
INSERT INTO answers (answer, question_id) VALUES ('N/A', 28);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Agree', 29);
INSERT INTO answers (answer, question_id) VALUES ('Agree', 29);
INSERT INTO answers (answer, question_id) VALUES ('Disagree', 29);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Disagree', 29);
INSERT INTO answers (answer, question_id) VALUES ('N/A', 29);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Agree', 30);
INSERT INTO answers (answer, question_id) VALUES ('Agree', 30);
INSERT INTO answers (answer, question_id) VALUES ('Disagree', 30);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Disagree', 30);
INSERT INTO answers (answer, question_id) VALUES ('N/A', 30);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Agree', 31);
INSERT INTO answers (answer, question_id) VALUES ('Agree', 31);
INSERT INTO answers (answer, question_id) VALUES ('Disagree', 31);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Disagree', 31);
INSERT INTO answers (answer, question_id) VALUES ('N/A', 31);
INSERT INTO answers (answer, question_id) VALUES ('Yes', 32);
INSERT INTO answers (answer, question_id) VALUES ('No', 32);

INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 77, 'srtucker28@icloud.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 78, 'hankzimmer7@gmail.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 71, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 71, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 71, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 71, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 72, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 72, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 72, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 72, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 72, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 73, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 73, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 73, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 73, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 73, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 73, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 73, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 73, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 73, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 73, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 73, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 73, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 73, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 73, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 73, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 74, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 74, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 74, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 74, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 74, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 75, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 75, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 76, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 76, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 77, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 78, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 78, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 78, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 78, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 78, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 78, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 78, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 78, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 78, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 79, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 80, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 81, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 81, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 81, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 82, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 82, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 83, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 83, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 84, null);

INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 88, 'srtucker28@icloud.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 89, 'hankzimmer7@gmail.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 85, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 85, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 86, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 86, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 86, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 86, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 86, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 87, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 87, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 87, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 88, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 88, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 88, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 88, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 88, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 88, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 88, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 88, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 88, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 88, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 88, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 89, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 89, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 89, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 89, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 89, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 89, null);

INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, 'srtucker28@icloud.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 90, 'hankzimmer7@gmail.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 90, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 90, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 90, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 90, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 90, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 90, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 90, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 91, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 92, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 92, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 92, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 93, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 93, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 93, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 93, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 94, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 94, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 94, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 94, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 94, null);

INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 96, 'srtucker28@icloud.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 95, 'hankzimmer7@gmail.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 95, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 95, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 95, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 95, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 95, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 95, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 95, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 95, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 95, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 96, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 96, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 96, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 96, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 97, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 97, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 98, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 98, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 99, null);

INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 101, 'srtucker28@icloud.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 100, 'hankzimmer7@gmail.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 100, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 100, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 100, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 101, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 101, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 101, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 101, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 101, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 101, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 101, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 101, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 102, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 102, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 102, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 103, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 103, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 103, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 104, null);

INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 106, 'srtucker28@icloud.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 105, 'hankzimmer7@gmail.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 105, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 105, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 105, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 105, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 105, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 105, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 105, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 105, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 105, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 106, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 106, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 106, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 106, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 106, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 106, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 107, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 107, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 107, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 107, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 108, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 108, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 108, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 109, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 109, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 109, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 109, null);

INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 110, 'srtucker28@icloud.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 110, 'hankzimmer7@gmail.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 110, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 110, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 110, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 110, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 110, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 110, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 110, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 110, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 110, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 110, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 110, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 110, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 110, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 110, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 111, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 111, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 111, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (4, 111, null);

-- Insert Survey 2
INSERT INTO surveys (title, description, date_created, "template", published) VALUES ('Staging Manager Evaluation', 'A survey for associates in staging to evaluate the staging manager.', '03-07-2019', FALSE, TRUE);
INSERT INTO questions (question, type_id) VALUES ('Name (Optional)', 5);
INSERT INTO questions (question, type_id) VALUES ('Email (Optional)', 5);
INSERT INTO questions (question, type_id) VALUES ('How many weeks have you been in staging?', 3);
INSERT INTO questions (question, type_id) VALUES ('My time in staging been productive.', 6);
INSERT INTO questions (question, type_id) VALUES ('How well has the staging manager helped you with being prepared for interviews?', 4);
INSERT INTO questions (question, type_id) VALUES ('Any additional comments regarding above ratings?', 5);
INSERT INTO questions (question, type_id) VALUES ('Any overall feedback?', 5);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (5, 35, 1);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (5, 36, 2);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (5, 37, 3);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (5, 38, 4);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (5, 39, 5);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (5, 40, 6);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (5, 41, 7);
INSERT INTO answers (answer, question_id) VALUES ('<1 Week', 37);
INSERT INTO answers (answer, question_id) VALUES ('1 Week', 37);
INSERT INTO answers (answer, question_id) VALUES ('2 Weeks', 37);
INSERT INTO answers (answer, question_id) VALUES ('3 Weeks', 37);
INSERT INTO answers (answer, question_id) VALUES ('4 Weeks', 37);
INSERT INTO answers (answer, question_id) VALUES ('5 Weeks', 37);
INSERT INTO answers (answer, question_id) VALUES ('6 Weeks', 37);
INSERT INTO answers (answer, question_id) VALUES ('7 Weeks', 37);
INSERT INTO answers (answer, question_id) VALUES ('8 Weeks', 37);
INSERT INTO answers (answer, question_id) VALUES ('9 Weeks', 37);
INSERT INTO answers (answer, question_id) VALUES ('10 Weeks', 37);
INSERT INTO answers (answer, question_id) VALUES ('>10 Weeks', 37);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Agree', 38);
INSERT INTO answers (answer, question_id) VALUES ('Agree', 38);
INSERT INTO answers (answer, question_id) VALUES ('Disagree', 38);
INSERT INTO answers (answer, question_id) VALUES ('Strongly Disagree', 38);
INSERT INTO answers (answer, question_id) VALUES ('N/A', 38);
INSERT INTO answers (answer, question_id) VALUES ('1', 39);
INSERT INTO answers (answer, question_id) VALUES ('2', 39);
INSERT INTO answers (answer, question_id) VALUES ('3', 39);
INSERT INTO answers (answer, question_id) VALUES ('4', 39);
INSERT INTO answers (answer, question_id) VALUES ('5', 39);

INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 113, 'imandavisy@gmail.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 114, 'dunieskior@gmail.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 112, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 112, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 112, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 112, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 112, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 112, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 112, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 112, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 112, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 112, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 112, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 112, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 112, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 112, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 112, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 112, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 113, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 113, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 113, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 113, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 113, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 113, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 113, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 113, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 113, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 113, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 114, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 114, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 114, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 114, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 114, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 115, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 115, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 116, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 117, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 117, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 117, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 117, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 118, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 118, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 119, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 121, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 122, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 123, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 123, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 123, null);

INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, 'imandavisy@gmail.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, 'dunieskior@gmail.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 124, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 124, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 124, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 124, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 124, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 124, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 124, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 124, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 124, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 124, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 125, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 126, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 126, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 126, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 126, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 126, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 126, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 126, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 127, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 127, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 127, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 128, null);

INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 133, 'imandavisy@gmail.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 131, 'dunieskior@gmail.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 129, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 130, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 130, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 130, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 131, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 131, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 131, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 131, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 131, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 131, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 131, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 132, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 132, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 132, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 132, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 132, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 132, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 132, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 132, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 132, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 132, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 132, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 133, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 133, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 133, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 133, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 133, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (5, 133, null);

--Insert Survey 3
INSERT INTO surveys (title, description, date_created, "template", published) VALUES ('Check In Survey', 'A survey for associates in virtual staging to check in.', '03-11-2019', FALSE, TRUE);
INSERT INTO questions (question, type_id) VALUES ('How long do you have until you begin work at your assigned location?', 5);
INSERT INTO questions (question, type_id) VALUES ('Are you prepared to start work at your work location?', 6);
INSERT INTO questions (question, type_id) VALUES ('How smooth was the transition to virtual staging?', 4);
INSERT INTO questions (question, type_id) VALUES ('Any additional comments regarding above ratings?', 5);
INSERT INTO questions (question, type_id) VALUES ('Any overall feedback?', 5);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (6, 42, 1);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (6, 43, 2);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (6, 44, 3);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (6, 45, 4);
INSERT INTO junction_survey_questions (survey_id, question_id, question_order) VALUES (6, 46, 5);
INSERT INTO answers (answer, question_id) VALUES ('Yes', 43);
INSERT INTO answers (answer, question_id) VALUES ('No', 43);
INSERT INTO answers (answer, question_id) VALUES ('1', 44);
INSERT INTO answers (answer, question_id) VALUES ('2', 44);
INSERT INTO answers (answer, question_id) VALUES ('3', 44);
INSERT INTO answers (answer, question_id) VALUES ('4', 44);
INSERT INTO answers (answer, question_id) VALUES ('5', 44);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, 'loricodes@gmail.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 135, 'srtucker28@icloud.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 134, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 135, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 135, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 135, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 135, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 135, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 135, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 135, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 135, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 135, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 135, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 135, null);

INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 139, 'loricodes@gmail.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 140, 'srtucker28@icloud.com');
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 136, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 136, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 137, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 137, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 137, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 137, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 137, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 137, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 138, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 138, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 138, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 138, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 138, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 138, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 138, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 138, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 139, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 139, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 139, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 139, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 139, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 139, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 139, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 139, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 139, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 139, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 139, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 140, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 140, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 140, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 140, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 140, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 140, null);
INSERT INTO responses (survey_id, answer_id, user_email) VALUES (6, 140, null);

-- Insert Dummy Feedback for Surveys 1, 2, and 3
INSERT INTO answers (answer, question_id) VALUES ('Hank', 24);
INSERT INTO answers (answer, question_id) VALUES ('Scott', 24);
INSERT INTO answers (answer, question_id) VALUES ('hankzimmer7@gmail.com', 25);
INSERT INTO answers (answer, question_id) VALUES ('srtucker28@icloud.com', 25);
INSERT INTO answers (answer, question_id) VALUES ('I struggled with the pace of training this week.', 33);
INSERT INTO answers (answer, question_id) VALUES ('The extra materials provided helped me a lot understanding with React.', 33);
INSERT INTO answers (answer, question_id) VALUES ('My trainer is great!', 34);
INSERT INTO answers (answer, question_id) VALUES ('No additional feedback.', 34);
INSERT INTO answers (answer, question_id) VALUES ('Iman', 35);
INSERT INTO answers (answer, question_id) VALUES ('Dunieski', 35);
INSERT INTO answers (answer, question_id) VALUES ('imandavisy@gmail.com', 36);
INSERT INTO answers (answer, question_id) VALUES ('dunieskior@gmail.com', 36);
INSERT INTO answers (answer, question_id) VALUES ('I have been able to build up my skills quite a bit during staging.', 40);
INSERT INTO answers (answer, question_id) VALUES ('My staging manager is very organized.', 40);
INSERT INTO answers (answer, question_id) VALUES ('I am excited to be placed on a position.', 41);
INSERT INTO answers (answer, question_id) VALUES ('Nothing to add.', 41);
INSERT INTO answers (answer, question_id) VALUES ('One week', 42);
INSERT INTO answers (answer, question_id) VALUES ('3 days', 42);
INSERT INTO answers (answer, question_id) VALUES ('I had no issues transitioning into virtual staging.', 45);
INSERT INTO answers (answer, question_id) VALUES ('It has been tough to find an apartment in such a short amount of time.', 45);
INSERT INTO answers (answer, question_id) VALUES ('I cannot wait to start at my position!', 46);
INSERT INTO answers (answer, question_id) VALUES ('The overall process has been very smooth and easy.', 46);

-- Add users as editors
INSERT INTO editors (email, survey_id) VALUES ('loricodes@gmail.com', 4);
INSERT INTO editors (email, survey_id) VALUES ('imandavisy@gmail.com', 4);
INSERT INTO editors (email, survey_id) VALUES ('goncalvesjohnp@gmail.com', 4);
INSERT INTO editors (email, survey_id) VALUES ('srtucker28@icloud.com', 4);
INSERT INTO editors (email, survey_id) VALUES ('hankzimmer7@gmail.com', 4);
INSERT INTO editors (email, survey_id) VALUES ('dunieskior@gmail.com', 4);
INSERT INTO editors (email, survey_id) VALUES ('kyserrecchia@gmail.com', 4);
INSERT INTO editors (email, survey_id) VALUES ('loricodes@gmail.com', 5);
INSERT INTO editors (email, survey_id) VALUES ('imandavisy@gmail.com', 5);
INSERT INTO editors (email, survey_id) VALUES ('goncalvesjohnp@gmail.com', 5);
INSERT INTO editors (email, survey_id) VALUES ('srtucker28@icloud.com', 5);
INSERT INTO editors (email, survey_id) VALUES ('hankzimmer7@gmail.com', 5);
INSERT INTO editors (email, survey_id) VALUES ('dunieskior@gmail.com', 5);
INSERT INTO editors (email, survey_id) VALUES ('kyserrecchia@gmail.com', 5);
INSERT INTO editors (email, survey_id) VALUES ('loricodes@gmail.com', 6);
INSERT INTO editors (email, survey_id) VALUES ('imandavisy@gmail.com', 6);
INSERT INTO editors (email, survey_id) VALUES ('goncalvesjohnp@gmail.com', 6);
INSERT INTO editors (email, survey_id) VALUES ('srtucker28@icloud.com', 6);
INSERT INTO editors (email, survey_id) VALUES ('hankzimmer7@gmail.com', 6);
INSERT INTO editors (email, survey_id) VALUES ('dunieskior@gmail.com', 6);
INSERT INTO editors (email, survey_id) VALUES ('kyserrecchia@gmail.com', 6);

-- Assign users to surveys
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (4, 'loricodes@gmail.com', '03-01-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (4, 'imandavisy@gmail.com', '03-01-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (4, 'goncalvesjohnp@gmail.com', '03-01-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (4, 'srtucker28@icloud.com', '03-01-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (4, 'hankzimmer7@gmail.com', '03-01-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (4, 'dunieskior@gmail.com', '03-01-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (4, 'kyserrecchia@gmail.com', '03-01-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (4, 'kserrec@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (4, 'abatson94@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (4, 'agrav12825@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (4, 'dfeli014@fiu.edu', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (4, 'kenneth.james.currie@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (4, 'mileena.garcia.mg@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (4, 'andrewhsoftware@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (4, 'mohamedwomar21@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (4, 'juan.melendez3.14@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (5, 'loricodes@gmail.com', '03-09-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (5, 'imandavisy@gmail.com', '03-09-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (5, 'goncalvesjohnp@gmail.com', '03-09-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (5, 'srtucker28@icloud.com', '03-09-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (5, 'hankzimmer7@gmail.com', '03-09-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (5, 'dunieskior@gmail.com', '03-09-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (5, 'kyserrecchia@gmail.com', '03-09-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (5, 'kserrec@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (5, 'abatson94@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (5, 'agrav12825@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (5, 'dfeli014@fiu.edu', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (5, 'kenneth.james.currie@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (5, 'mileena.garcia.mg@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (5, 'andrewhsoftware@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (5, 'mohamedwomar21@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (5, 'juan.melendez3.14@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (6, 'loricodes@gmail.com', '03-11-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (6, 'imandavisy@gmail.com', '03-11-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (6, 'goncalvesjohnp@gmail.com', '03-11-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (6, 'srtucker28@icloud.com', '03-11-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (6, 'hankzimmer7@gmail.com', '03-11-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (6, 'dunieskior@gmail.com', '03-11-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (6, 'kyserrecchia@gmail.com', '03-11-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (6, 'kserrec@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (6, 'abatson94@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (6, 'agrav12825@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (6, 'dfeli014@fiu.edu', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (6, 'kenneth.james.currie@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (6, 'mileena.garcia.mg@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (6, 'andrewhsoftware@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (6, 'mohamedwomar21@gmail.com', '03-18-2019', null);
INSERT INTO survey_history (survey_id, user_email, date_assigned, date_completed) VALUES (6, 'juan.melendez3.14@gmail.com', '03-18-2019', null);