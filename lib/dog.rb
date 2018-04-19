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

  def self.create({dog})
    binding.pry
    # new_dog = Dog.new({dog=>dog})
    new_dog.save
    new_dog
  end

end
