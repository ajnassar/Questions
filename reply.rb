require_relative 'QuestionsDatabase.rb'


class Reply
  attr_accessor :id, :subject_question, :parent_reply_id, :author_id, :body
  def initialize(options)
    @id = options["id"]
    @question_id = options["question_id"]
    @parent_reply_id = options["parent_reply_id"]
    @author_id = options["author_id"]
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
    Reply.new(found_replies[0])
  end

  def self.find_by_question_id(question_id)
    found_replies = QuestionsDatabase.instance.execute(<<-SQL, :question_id => question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = :question_id AND parent_reply_id IS NOT NULL
    SQL
    found_replies.map do |reply|
      Reply.new(reply)
    end
  end

  # def author
 #    found_author = QuestionsDatabase.instance.execute(<<-SQL, :question_id => question_id)
 #    SELECT
 #      *
 #    FROM
 #      replies
 #    WHERE
 #      question_id = :question_id AND parent_reply_id IS NOT NULL
 #    SQL
 #    found_replies.map do |reply|
 #      Reply.new(reply)
 #    end
 #  end
 #
 #  def question
 #
 #  end
 #
 #  def parent_reply
 #
 #  end

  def child_replies
    found_child_replies = QuestionsDatabase.instance.execute(<<-SQL, :parent_reply_id => self.id )
    SELECT
      *
    FROM
      replies
    WHERE
    parent_reply_id = :parent_reply_id
    SQL
    found_child_replies.map do |reply|
      Reply.new(reply)
    end
  end
end