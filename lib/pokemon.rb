require 'pry'
class Pokemon
  attr_accessor :id, :name, :type, :db
  # attr_reader
  
  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @type = hash[:type]
    @db = hash[:db]
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
        SELECT * FROM pokemon WHERE id = ?
        SQL
    response = db.execute(sql, id)[0]
    Pokemon.new({:id => response[0],:name => response[1],:type => response[2],:db => db})

  end

end
