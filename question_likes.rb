require_relative 'QuestionsDatabase.rb'

class QuestionLikes
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
    QuestionLikes.new(found_question_likes[0])
  end
end