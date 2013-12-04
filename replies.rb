require_relative 'QuestionsDatabase.rb'

class Replies
  attr_accessor :id, :subject_question, :parent_reply_id, :user_id, :body
  def initialize(options)
    @id = options["id"]
    @subject_question = options["subject_question"]
    @parent_reply_id = options["parent_reply_id"]
    @user_id = options["user_id"]
    @body = options["body"]
  end

  def self.find_by_id(id)
    found_replies = QuestionsDatabase.instance.execute(<<-SQL, :id => id)
    SELECT
      *
    FROM
      replies
    WHERE
      id = :id
    SQL
    Replies.new(found_replies[0])
  end
end