require_relative 'QuestionsDatabase.rb'
require_relative 'question.rb'
require_relative 'reply.rb'
require_relative 'question_like.rb'
class User
  attr_accessor :id, :fname, :lname
  def initialize(options)
    @id = options["id"]
    @fname = options["fname"]
    @lname = options["lname"]
  end

  def self.find_by_id(id)
    found_user = QuestionsDatabase.instance.execute(<<-SQL, :id => id)
    SELECT
      *
    FROM
      users
    WHERE
      id = :id
    LIMIT
      1
    SQL
    User.new(found_user[0])
  end

  def self.find_by_name(fname, lname)
    found_user = QuestionsDatabase.instance.execute(<<-SQL, :fname => fname, :lname => lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = :fname AND lname = :lname
    LIMIT
      1
    SQL
    User.new(found_user[0])
  end

  def average_karma

  end

  def authored_questions
    Question.find_by_author_id(self.id)
    # found_questions = QuestionsDatabase.instance.execute(<<-SQL, :author_id => self.id)
#     SELECT
#       *
#     FROM
#       questions
#     WHERE
#       author_id = :author_id
#     SQL
#
#     found_questions.map do |question|
#       Question.new(question)
#     end
  end

  def authored_replies
    Reply.find_by_user_id(self.id)

    # found_replies = QuestionsDatabase.instance.execute(<<-SQL, :author_id => self.id)
#     SELECT
#       *
#     FROM
#       replies
#     WHERE
#       author_id = :author_id
#     SQL
#
#     found_replies.map do |reply|
#       Reply.new(reply)
#     end
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(self.id)
  end

end