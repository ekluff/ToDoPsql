class List
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_lists = DB.exec('SELECT * FROM lists;')
    lists = []
    returned_lists.each do |list|
      name = list.fetch('name')
      id = list.fetch('id')
      lists.push(List.new({ name: name, id: id }))
    end
    lists
  end

  def save
    result = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end
end
