require_relative('../db/sql_runner.rb')

class User

  attr_accessor :id, :username, :fullname, :isphotographer, :password

  def initialize(params)
      @id = params['id'].to_i
      @username = params['username']
      @fullname = params['fullname']
      @password = params['password']
      @isphotographer = params['isphotographer']
    #   @isphotographer = isphotographer?(params['isphotographer'])
  end

  def save()
      sql = "INSERT INTO users (username, fullname, password, isphotographer) VALUES ('#{@username}', '#{@fullname}', '#{@password}', #{@isphotographer}) RETURNING *;"
      begin
            return User.map_item(sql)
      rescue PG::UniqueViolation
   end
  end

  def self.login(options)
      sql = "SELECT * FROM users WHERE username = '#{options['username']}' AND password = '#{options['password']}';"
      return User.map_item(sql)
  end

  def self.all()
      sql = "SELECT * FROM users;"
      return User.map_items(sql)
  end

  def self.delete_all()
      sql = "DELETE FROM users;"
      SqlRunner.run(sql)
  end

  def self.find(id)
      sql = "SELECT * FROM users WHERE id = #{id};"
      return User.map_item(sql)
  end

  def self.photographers
      sql = "SELECT * FROM photographers;"
      return User.map_items(sql)
  end

  # def isphotographer?(val)
  #     @isphotographer = val == TRUE ? true : false
  # end


  def self.update(params)
    sql = "UPDATE users SET
            username = '#{params['username']}',
            fullname = '#{params['fullname']}',
            password = '#{params['password']}',
            isphotographer = #{params['isphotographer']}
            WHERE id = #{params['id']}"
            return User.map_item(sql)
    end

    def self.destroy(id)
      sql = "DELETE FROM users WHERE id = #{id}"
      return SqlRunner.run(sql)
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
