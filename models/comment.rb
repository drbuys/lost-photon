require_relative('../db/sql_runner.rb')

class Comment

  attr_accessor :id, :user_id, :photo_id, :rating, :post

  def initialize(params)
      @id = params['id'].to_i
      @user_id = params['user_id'].to_i
      @photo_id = params['photo_id'].to_i
      @rating = params['rating'].to_i
      @post = params['post']
  end

  def save()
      sql = "INSERT INTO comments (
      user_id,
      photo_id,
      rating,
      post) VALUES (
      #{@user_id},
      #{@photo_id},
      #{@rating},
      '#{@post}');"
      return SqlRunner.run(sql)
  end

  def self.all()
      sql = "SELECT * FROM comments;"
      return Comment.map_items(sql)
  end

  def self.delete_all()
      sql = "DELETE FROM comments;"
      SqlRunner.run(sql)
  end

  def self.find(id)
      sql = "SELECT * FROM comments WHERE id = #{id};"
      return Comment.map_item(sql)
  end

  def self.update(params)
    sql = "UPDATE comments SET
            user_id = #{params['user_id']},
            photo_id = #{params['photo_id']},
            rating = #{params['rating']},
            post = '#{params['post']}'
            WHERE id = #{params['id']}"
            return Comment.map_item(sql)
    end

    def self.destroy(id)
      sql = "DELETE FROM comments WHERE id = #{id}"
      return SqlRunner.run(sql)
    end

  def self.map_items(sql)
    comments = SqlRunner.run( sql )
    result = comments.map { |comment| Comment.new( comment ) }
    return result
  end

  def self.map_item(sql)
    result = Comment.map_items(sql)
    return result.first
  end

end
