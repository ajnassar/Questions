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

end