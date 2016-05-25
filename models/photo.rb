require_relative('../db/sql_runner.rb')

class Photo

  attr_accessor :id, :name, :object, :datetaken, :location, :aperture, :shutterspeed, :photographer_id, :camera_id, :lens_id

  def initialize(params)
      @id = params['id'].to_i
      @name = params['name']
      if params['object'].is_a? String
          @object = params['object']
      else
          @object = params['object'][:filename]
          File.open('public/img/'+ params['object'][:filename], "w") do |f|
              f.write(params['object'][:tempfile].read)
          end
      end
      @datetaken = params['datetaken']
      @location = params['location']
      @aperture = params['aperture'].to_f
      @shutterspeed = params['shutterspeed']
      @photographer_id = params['photographer_id'].to_i
      @camera_id = params['camera_id'].to_i
      @lens_id = params['lens_id'].to_i

  end

  def save()
      sql = "INSERT INTO photos (
      name,
      object,
      datetaken,
      location,
      aperture,
      shutterspeed,
      photographer_id,
      camera_id,
      lens_id) VALUES (
      '#{@name}',
      '#{@object}',
      '#{@datetaken}',
      '#{@location}',
      #{@aperture},
      '#{@shutterspeed}',
      #{@photographer_id},
      #{@camera_id},
      #{@lens_id});"
      return SqlRunner.run(sql)
  end

  def self.all()
      sql = "SELECT * FROM photos;"
      return Photo.map_items(sql)
  end

  def self.delete_all()
      sql = "DELETE FROM photos;"
      SqlRunner.run(sql)
  end

  def self.find(id)
      sql = "SELECT * FROM photos WHERE id = #{id};"
      return Photo.map_item(sql)
  end

  def self.update(params)
    sql = "UPDATE photos SET
            name = '#{params['name']}',
            object = '#{params['object']}',
            datetaken = '#{params['datetaken']}',
            location = '#{params['location']}',
            aperture = #{params['aperture']},
            shutterspeed = '#{params['shutterspeed']}',
            photographer_id = #{params['photographer_id']},
            camera_id = #{params['camera_id']},
            lens_id = #{params['lens_id']}
            WHERE id = #{params['id']}"
            return Photo.map_item(sql)
    end

    def self.destroy(id)
      sql = "DELETE FROM photos WHERE id = #{id}"
      return SqlRunner.run(sql)
    end

# this function should pull out the photographer of the photo
  def photographer
      sql = "SELECT * FROM photographers WHERE id = #{@photographer_id};"
      return User.map_item(sql)
  end

  def self.photographercount
      sql = "SELECT photographer_id, COUNT(*) FROM photos GROUP BY photographer_id;"
      result = SqlRunner.run(sql)
    #   return result.sort_by {|id, count| count}
      return result.sort{ |a,b| b['count'] <=> a['count'] }
  end

# this function should pull out the camera used to take the photo
  def camera
      sql = "SELECT * FROM cameras WHERE id = #{@camera_id};"
      return Camera.map_item(sql)
  end

  def self.cameracount
      sql = "SELECT camera_id, COUNT(*) FROM photos GROUP BY camera_id;"
      result = SqlRunner.run(sql)
    #   return result.sort_by {|id, count| count}
      return result.sort{ |a,b| b['count'] <=> a['count'] }
  end

# this function should pull out the lens used to take the photo
  def lens
      sql = "SELECT * FROM lenses WHERE id = #{@lens_id};"
      return Lens.map_item(sql)
  end

  def self.lenscount
      sql = "SELECT lens_id, COUNT(*) FROM photos GROUP BY lens_id;"
      result = SqlRunner.run(sql)
    #   return result.sort_by {|id, count| count}
      return result.sort{ |a,b| b['count'] <=> a['count'] }
  end

# this function should pull out all of the comments for a given photograph
  def comments
      sql = "SELECT * FROM comments WHERE comments.photo_id = #{id};"
      return Comment.map_items(sql)
  end

  def avg_rating
      num_comments = comments.length > 0 ? comments.length : 1
      return (comments.inject(0) {|sum, comment| sum + comment.rating}/num_comments)
  end

  def self.top_rated_photo
      allratings = Photo.all().map {|photo| [photo.avg_rating, photo]}
      return allratings.sort_by {|rating| rating[0] }.reverse
  end

  def self.map_items(sql)
    photos = SqlRunner.run( sql )
    result = photos.map { |user| Photo.new( user ) }
    return result
  end

  def self.map_item(sql)
    result = Photo.map_items(sql)
    return result.first
  end

end
