CREATE TABLE users (
	id INTEGER PRIMARY KEY,
	fname VARCHAR(255) NOT NULL,
	lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
	id INTEGER PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	body VARCHAR(255) NOT NULL
);

CREATE TABLE question_followers (
	id INTEGER PRIMARY KEY,
	user_id INTEGER NOT NULL,
	question_id INTEGER NOT NULL,

	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
	id INTEGER PRIMARY KEY,
	subject_question INTEGER NOT NULL,
	parent_reply_id INTEGER,
	user_id VARCHAR(255) NOT NULL,
	body VARCHAR(255) NOT NULL,

	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
	id INTEGER PRIMARY KEY,
	user_id INTEGER NOT NULL,
	question_id INTEGER NOT NULL,

	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
	users (fname, lname)
VALUES
	('Jacob', 'Haile'),
  ('Anthony', 'Nassar');

INSERT INTO
	questions (title, body)
VALUES
	('You mad?', 'Why you mad?'),
  ('You MAD BRO?', 'Why you mad bro?');

INSERT INTO
	question_followers (user_id, question_id)
VALUES
	(1, 1),
  (2, 2);

INSERT INTO
	replies (subject_question, parent_reply_id, user_id, body)
VALUES
	(1, null, 1, "Nah"),
  (1, 1, 2, "ya you mad");


INSERT INTO
	question_likes (user_id, question_id)
VALUES
	(1, 1),
  (2, 2);




