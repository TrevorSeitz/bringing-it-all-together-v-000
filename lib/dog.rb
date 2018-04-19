class Dog

  attr_accessor :id, :name, :breed

  def initialize(id=nil, dog)
    @id = id
    @name = dog[:name]
    @breed = dog[:breed]
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IN NOT EXISTS dogs (
      id INTEGER PRIMARY KEY,
      name, TEXT,
      breed TEXT
    )
    SQL
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE IF EXISTS dogs
    SQL

    DB[:conn].execute(sql)
  end

  def save
    if self.id
      self.update
    else
      sql = <<-SQL
        INSERT INTO dogs (name, breed)
        VALUES (?, ?)
      SQL

      DB[:conn].execute(sql, self.name, self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
      self
    end
  end

  def self.create(dog)
    # binding.pry
    new_dog = Dog.new(dog)
    new_dog.save
    new_dog
  end

  def self.find_by_id(id)
    sql = <<-SQL
      SELECT *
      FROM dogs
      WHERE id = ?
      LIMIT 1
    SQL

    DB[:conn].execute(sql, id).map do |row|
      self.new_from_db(row)
    end.first
  end

  def self.new_from_db(row)
    new_dog_details = [[:name, row[1]], [:breed, row[2]]].to_h
    new_dog = self.new(row[0], new_dog_details)
    new_dog
  end

  def self.find_or_create_by(dog)
    # dog_details = [[:name, row[0]], [:breed, row[1]]].to_h
    name = dog[name]
    breed = dog[breed]
    new_dog = DB[:conn].execute("SELECT * FROM dogs WHERE name = ? AND breed = ?", dog[name], dog[breed])
    binding.pry
    if !new_dog.empty?
      dog_data = dog[0]
      dog_details = [[:name, row[1]], [:breed, row[2]]].to_h
      dog = Dog.new
    end
  end


end
