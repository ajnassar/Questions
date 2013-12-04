require_relative 'QuestionsDatabase.rb'

class Questions
  attr_accessor :id, :title, :body
  def initialize(options)
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
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
    Questions.new(found_question[0])
  end
end