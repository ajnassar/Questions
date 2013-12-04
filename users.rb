require_relative 'QuestionsDatabase.rb'

class Users
  attr_accessor :id
  def initialize(options)
    @id = options[id]
    @fname = options[fname]
    @lname = options[lname]
  end

  def find_by_id(id)
    found_user = QuestionsDatabase.instance.execute(<<-SQL, :id => id)
    SELECT
      *
    FROM
      Users
    WHERE
      id = :id
    SQL

    found_user.last_insert_row_id
  end


end