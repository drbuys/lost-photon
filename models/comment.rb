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
      sql = "INSERT INTO comments (user_id, photo_id, rating, post) VALUES (#{@user_id}, #{@photo_id}, #{@rating}, $$#{@post}$$);"
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
            post = $$#{params['post']}$$
            WHERE id = #{params['comment_id']};"
            return Comment.map_item(sql)
    end

    def self.destroy(id)
      sql = "DELETE FROM comments WHERE id = #{id}"
      return SqlRunner.run(sql)
    end

# this function should pull out the user commenting on the photo
  def user
      sql = "SELECT * FROM users WHERE id = #{@user_id};"
      return User.map_item(sql)
  end

# this function should pull out the photo being commented on
  def photo
      sql = "SELECT * FROM photos WHERE id = #{@photo_id};"
      return Photo.map_item(sql)
  end

  # # this function should pull out the photographer of the photo
  #   def photographer
  #       sql = "SELECT username FROM photographers INNER JOIN photos ON photos.user_id = photographers.id WHERE photo.id = #{@photo_id};"
  #       return User.map_item(sql)
  #   end

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
