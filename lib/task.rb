class Task

  attr_reader :description, :list_id, :due_date
  def initialize(attributes={})
    @description = attributes.fetch(:description, "")
    @list_id = attributes.fetch(:list_id).to_i
    @due_date = Date.parse(attributes.fetch(:due_date))
    @complete = attributes.fetch(:complete, false)
  end

  def ==(another_task)
    description == another_task.description
  end

  def self.all
    returned_tasks = DB.exec('SELECT * FROM tasks ORDER BY due_date;');
    tasks =[]
    returned_tasks.each do |task|
      description = task.fetch('description')
      list_id = task.fetch('list_id')
      due_date = task.fetch('due_date')
      complete = task.fetch('complete')
      complete = false if complete == 'f'
      complete = true  if complete == 't'
      tasks.push(Task.new({ description: description, list_id: list_id, due_date: due_date, complete: complete }))
    end
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (description, list_id, due_date, complete) VALUES ('#{@description}', #{@list_id}, '#{@due_date}', #{@complete} );")
  end

  def ==(another_task)
    self.description == another_task.description &&
    self.due_date == another_task.due_date &&
    self.complete? == another_task.complete? &&
    self.list_id == another_task.list_id
  end

  def complete?
    @complete
  end

  def completed
    result = DB.exec("UPDATE tasks SET complete = TRUE WHERE description = '#{self.description}' RETURNING complete;")
    @complete = true if result.first.fetch('complete') == 't'
  end

end
