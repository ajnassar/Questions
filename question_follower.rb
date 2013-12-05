require_relative 'QuestionsDatabase.rb'
require_relative 'user.rb'

class QuestionFollower
  attr_accessor :id, :user_id, :question_id
  def initialize(options)
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end

  def self.find_by_id(id)
    found_question_followers = QuestionsDatabase.instance.execute(<<-SQL, :id => id)
    SELECT
      *
    FROM
      question_followers
    WHERE
      id = :id
    SQL
    QuestionFollower.new(found_question_followers[0])
  end

  def self.followers_for_question_id(question_id)
    found_question_followers = QuestionsDatabase.instance.execute(<<-SQL, :question_id => question_id)
    SELECT
      *
    FROM
      question_followers
    JOIN users ON question_followers.user_id = users.id
    WHERE
      question_id = :question_id
    SQL

    found_question_followers.map do |user|
      User.new(user)
    end
  end

  def self.followed_questions_for_user_id(user_id)
    followed_questions = QuestionsDatabase.instance.execute(<<-SQL, :user_id => user_id)
    SELECT
      *
    FROM
      question_followers
    JOIN questions ON question_followers.question_id = questions.id
    WHERE
      user_id = :user_id
    SQL

    followed_questions.map do |question|
      Question.new(question)
    end

  end

  def self.most_followed_questions(n)
    most_followed_questions = QuestionsDatabase.instance.execute(<<-SQL, :n => n)
    SELECT
      *
    FROM
      question_followers
    JOIN
      questions
    ON
      question_followers.question_id = questions.id
    GROUP BY
      question_followers.question_id
    ORDER BY
      COUNT(*) DESC
    LIMIT
      :n
    SQL

    most_followed_questions.map do |question|
      Question.new(question)
    end
  end





end