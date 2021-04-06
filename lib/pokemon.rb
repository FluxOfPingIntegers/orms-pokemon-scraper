require 'pry'
class Pokemon
  attr_accessor :name, :type, :db
  attr_reader :id
  
  def initialize(name:, type:, db:, id:)
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    @db = db
    sql = <<-SQL
    SELECT * FROM pokemon 
    WHERE name = ?
    AND type = ?
    SQL
    response = db.execute(sql, name, type)[0]
    if response
        self.find(response[-1])
    else
        sql = <<-SQL
        CREATE TABLE IF NOT EXISTS pokemon (name TEXT, type TEXT, db TEXT, id INTEGER PRIMARY KEY);

        INSERT INTO pokemon (name, type)
        VALUES (?, ?);
        SQL
        response = db.execute(sql, name, type)[0]
    end
  end

  def find(id)
    sql = <<-SQL
        SELECT * FROM pokemon WHERE id = ?
        SQL
    response = @db.execute(sql, id)[0]
    binding.pry

  end

end
