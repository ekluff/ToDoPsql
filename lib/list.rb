class List
  attr_reader :name, :id, :category

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id, nil).to_i
    @category = attributes.fetch(:category, "")
  end

  def self.all
    returned_lists = DB.exec('SELECT * FROM lists;')
    lists = []
    returned_lists.each do |list|
      name = list.fetch('name')
      id = list.fetch('id')
      category = list.fetch('category')
      lists.push(List.new({ name: name, id: id, category: category }))
    end
    lists
  end

  def save
    result = DB.exec("INSERT INTO lists (name, category) VALUES ('#{@name}', '#{@category}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.find(id)
    List.all.each do |list|
      if list.id == id
        return list
      end
    end
  end

  def ==(another_list)
    self.name == another_list.name && self.id == another_list.id && self.category == another_list.category
  end
end
