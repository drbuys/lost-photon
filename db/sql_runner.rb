require('pg')
class SqlRunner

  def self.run( sql )
    begin
    #   db = PG.connect({ dbname: 'lostphoton', host: 'localhost' })
        db = PG.connect( {dbname: 'd472eci68fgu0n', host: 'ec2-54-243-201-116.compute-1.amazonaws.com', port: 5432, user: 'buugykozsbhvdp', password: 'qy3fJjRhVSDJH0loLVPcxBIybP'})
      result = db.exec( sql )
    ensure
      db.close
    end
    return result
  end

end
