class Dog

  attr_accessor :id, :name, :breed

  def initialize(id)
    binding.pry
    @id = id
    @name = name
    @breed = breed
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
