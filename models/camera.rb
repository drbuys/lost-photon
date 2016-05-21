require_relative('../db/sql_runner.rb')

class Camera

  attr_accessor :id, :make, :model

  def initialize(params)
      @id = params['id'].to_i
      @make = params['make']
      @model = params['model']
  end

  def save()
      sql = "INSERT INTO cameras (make, model) VALUES ('#{@make}', '#{@model}');"
      return SqlRunner.run(sql)
  end

  def self.all()
      sql = "SELECT * FROM cameras;"
      return Camera.map_items(sql)
  end

  def self.delete_all()
      sql = "DELETE FROM cameras;"
      SqlRunner.run(sql)
  end

  def self.find(id)
      sql = "SELECT * FROM cameras WHERE id = #{id};"
      return Camera.map_item(sql)
  end

  def self.update(params)
    sql = "UPDATE cameras SET
            make = '#{params['make']}',
            model = '#{params['model']}'
            WHERE id = #{params['id']}"
            return Camera.map_item(sql)
    end

    def self.destroy(id)
      sql = "DELETE FROM cameras WHERE id = #{id}"
      return SqlRunner.run(sql)
    end

  def self.map_items(sql)
    cameras = SqlRunner.run( sql )
    result = cameras.map { |user| Camera.new( user ) }
    return result
  end

  def self.map_item(sql)
    result = Camera.map_items(sql)
    return result.first
  end

end
