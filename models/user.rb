require_relative('../db/sql_runner.rb')

class User

  attr_reader :id, :username, :fullname, :isphotographer,

  def initialize(params)
    @id = params['id'].to_i
    @username = params['username']
    @username = params['fullname']
    @isphotographer = params['isphotographer']
  end

  def save()
    sql = "INSERT INTO users (username, last_name, isphotographer) VALUES ('#{@username}', '#{@last_name}', '#{@isphotographer}');"
    return SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM users;"
    return User.map_items(sql)
  end

  def self.map_items(sql)
    users = SqlRunner.run( sql )
    result = users.map { |user| User.new( user ) }
    return result
  end

  def self.map_item(sql)
    result = User.map_items(sql)
    return result.first
  end

end
