require_relative 'QuestionsDatabase.rb'
require_relative 'reply.rb'
require_relative 'question_like.rb'
class Question
  attr_accessor :id, :title, :body, :author_id
  def initialize(options)
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
    @author_id = options["author_id"]
  end

  def self.find_by_id(id)
    found_question = QuestionsDatabase.instance.execute(<<-SQL, :id => id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = :id
    SQL
    Question.new(found_question[0])
  end

  def self.find_by_author_id(id)
    found_question = QuestionsDatabase.instance.execute(<<-SQL, :author_id => id)
    SELECT
      *
    FROM
      questions
    WHERE
      author_id = :author_id
    SQL

    found_question.map do |question|
      Question.new(question)
    end
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
    #most_liked = QuestionsDatabase.instance.execute(<<-SQL)
  end

  def author
    found_author = QuestionsDatabase.instance.execute(<<-SQL, :author_id => self.author_id)
    SELECT
      *
    FROM
      users
    WHERE
      id = :author_id
    LIMIT
      1
    SQL
    User.new(found_author[0])
  end

  def replies
    found_replies = QuestionsDatabase.instance.execute(<<-SQL, :question_id => self.id)
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = :question_id
    SQL

    found_replies.map do |reply|
      Reply.new(reply)
    end
  end

  def followers
    QuestionFollower.followers_for_question_id(self.id)
  end

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(self.id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(self.id)
  end

end