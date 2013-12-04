require_relative 'QuestionsDatabase.rb'

class QuestionFollowers
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
    QuestionFollowers.new(found_question_followers[0])
  end
end