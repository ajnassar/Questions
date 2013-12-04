require_relative 'QuestionsDatabase.rb'

class Users
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
    SQL
    Users.new(found_user[0])
  end

  def self.find_by_name(fname, lname)
    found_user = QuestionsDatabase.instance.execute(<<-SQL, :fname => fname, :lname => lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = :fname AND lname = :lname
    SQL
    Users.new(found_user[0])
  end

  def authored_questions
    found_questions = QuestionsDatabase.instance.execute(<<-SQL, :author_id => self.id)
    SELECT
      question_id
    FROM
      question_followers
    WHERE
      user_id = :author_id
    SQL
  end

  def authored_replies
    found_replies = QuestionsDatabase.instance.execute(<<-SQL, :author_id => self.id)
    SELECT
      id
    FROM
      replies
    WHERE
      user_id = :author_id
    SQL
  end

end