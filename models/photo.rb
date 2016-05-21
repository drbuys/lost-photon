require_relative('../db/sql_runner.rb')

class Photo

  attr_accessor :id, :name, :object, :datetaken, :location, :aperture, :shutterspeed, :photographer_id, :camera_id, :lens_id

  def initialize(params)
      @id = params['id'].to_i
      @name = params['name']
      @object = params['object']
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

# this function should pull out the camera used to take the photo
  def camera
      sql = "SELECT * FROM cameras WHERE id = #{@camera_id};"
      return Camera.map_item(sql)
  end

# this function should pull out the lens used to take the photo
  def lens
      sql = "SELECT * FROM lenses WHERE id = #{@lens_id};"
      return Lens.map_item(sql)
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
