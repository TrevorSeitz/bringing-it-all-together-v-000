class Dog

  attr_accessor :id, :name, :breed

  def initialize(dog)
    # binding.pry
    @id = dog.id
    @name = dog.name
    @breed = dog.breed
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

end
