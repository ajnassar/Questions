require_relative 'QuestionsDatabase.rb'
require_relative 'question.rb'
require_relative 'user.rb'

class QuestionLike
  attr_accessor :id, :user_id, :question_id
  def initialize(options)
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end

  def self.find_by_id(id)
    found_question_likes = QuestionsDatabase.instance.execute(<<-SQL, :id => id)
    SELECT
      *
    FROM
      question_likes
    WHERE
      id = :id
    SQL
    QuestionLike.new(found_question_likes[0])
  end

  def self.likers_for_question_id(question_id)
    question_likers = QuestionsDatabase.instance.execute(<<-SQL, :question_id => question_id)
    SELECT
      users.*
    FROM
      question_likes
    JOIN
      users
    ON
      question_likes.user_id = users.id
    WHERE
      question_likes.question_id = :question_id
    SQL

    question_likers.map do |user|
      User.new(user)
    end
  end

  def self.num_likes_for_question_id(question_id)
    question_likers = QuestionsDatabase.instance.execute(<<-SQL, :question_id => question_id)
    SELECT
      COUNT(*)
    FROM
      question_likes
    JOIN
      users
    ON
      question_likes.user_id = users.id
    WHERE
      question_likes.question_id = :question_id
    SQL
    question_likers[0].values[0]
  end

  def self.liked_questions_for_user_id(user_id)
    questions_user_likes = QuestionsDatabase.instance.execute(<<-SQL, :user_id => user_id)
    SELECT
      questions.*
    FROM
      question_likes
    JOIN
      questions
    ON
      question_likes.question_id = questions.id
    WHERE
      question_likes.user_id = :user_id
    SQL

    questions_user_likes.map do |question|
      Question.new(question)
    end
  end

    def self.most_liked_questions(n)
      liked_questions = QuestionsDatabase.instance.execute(<<-SQL, :n => n)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
      questions
      ON
      questions.id = question_likes.question_id
      GROUP BY
        question_id
      ORDER BY
        COUNT(questions.id) DESC
      LIMIT
        :n
      SQL

      liked_questions.map do |question|
        Question.new(question)
      end


    end




end