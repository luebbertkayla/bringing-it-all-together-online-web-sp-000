class Dog 
  attr_accessor :id, :name, :breed
  
  def initialize(id: nil, name:, breed:)
    @id = id 
    @name = name 
    @breed = breed
  end 
  
  def self.create_table 
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
      id INTEGER KEY, 
      name TEXT,
      breed TEXT
      )
      SQL
      
      DB[:conn].execute(sql)
  end 
  
  def self.drop_table 
        sql = "DROP TABLE IF EXISTS dogs"
    DB[:conn].execute(sql)
  end 
  
  def save 
    sql = <<-SQL
      INSERT INTO dogs (name, breed)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.breed)
    
    self 
  end 
  
  def self.create(attributes_hash)
    dog = Dog.new(attributes_hash)
    dog.save
    dog
  end 
  
  def self.new_from_db(row)
    attributes_hash = {
      id = row[0]
    name = row[1]
    breed = row[2]
    self.new(id, name, breed)
  end 
end 