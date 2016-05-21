require_relative('../db/sql_runner.rb')

class Lens

  attr_accessor :id, :make, :model

  def initialize(params)
      @id = params['id'].to_i
      @make = params['make']
      @model = params['model']
  end

  def save()
      sql = "INSERT INTO lenses (make, model) VALUES ('#{@make}', '#{@model}');"
      return SqlRunner.run(sql)
  end

  def self.all()
      sql = "SELECT * FROM lenses;"
      return Lens.map_items(sql)
  end

  def self.delete_all()
      sql = "DELETE FROM lenses;"
      SqlRunner.run(sql)
  end

  def self.find(id)
      sql = "SELECT * FROM lenses WHERE id = #{id};"
      return Lens.map_item(sql)
  end

  def self.update(params)
    sql = "UPDATE lenses SET
            make = '#{params['make']}',
            model = '#{params['model']}'
            WHERE id = #{params['id']}"
            return Lens.map_item(sql)
    end

    def self.destroy(id)
      sql = "DELETE FROM lenses WHERE id = #{id}"
      return SqlRunner.run(sql)
    end

  def self.map_items(sql)
    lenses = SqlRunner.run( sql )
    result = lenses.map { |user| Lens.new( user ) }
    return result
  end

  def self.map_item(sql)
    result = Lens.map_items(sql)
    return result.first
  end

end
