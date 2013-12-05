CREATE TABLE users (
	id INTEGER PRIMARY KEY,
	fname VARCHAR(255) NOT NULL,
	lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
	id INTEGER PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	body VARCHAR(255) NOT NULL,
	author_id INTEGER NOT NULL,

	FOREIGN KEY (author_id) REFERENCES users(id)
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
	question_id INTEGER NOT NULL,
	parent_reply_id INTEGER,
	author_id INTEGER NOT NULL,
	body VARCHAR(255) NOT NULL,

	FOREIGN KEY (author_id) REFERENCES users(id)
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
  ('Anthony', 'Nassar'),
	('Anthony', '1'),
	('Anthony', '2'),
	('Anthony', '3');

INSERT INTO
	questions (title, body, author_id)
VALUES
	('You mad?', 'Why you mad?', 1),
  ('You MAD BRO?', 'Why you mad bro?', 1),
	('question 3', 'body 3', 2);

INSERT INTO
	question_followers (user_id, question_id)
VALUES
	(1, 3),
	(2, 3),
	(3, 3),
	(4, 3),
	(5, 3),
  (2, 2),
	(3, 2),
	(4, 2),
	(3, 1);

INSERT INTO
	replies (question_id, parent_reply_id, author_id, body)
VALUES
	(1, null, 1, "Parent reply"),
  (1, 1, 2, "child reply 1"),

	(1, 1, 1, "child reply 2"),
	(1, 1, 1, "child reply 2"),
	(1, 4, 2, "Child reply 3");


INSERT INTO
	question_likes (user_id, question_id)
VALUES
	(1, 3),
	(2, 3),
	(3, 3),
	(4, 3),
	(5, 1),
	(1, 2),
	(3, 2),
  (2, 2);




