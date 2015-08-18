require('sinatra')
require('sinatra/reloader')
require('./lib/list')
require('./lib/task')
require('pg')
# require('./spec/spec_helper')
also_reload('lib/**/*.rb')

DB = PG.connect({dbname: 'to_do'})

get '/'  do
	@lists = List.all
	erb(:index)
end

get('/list/new') do
	erb(:list_form)
end

post('/list/new') do
	category = params.fetch('category')
	name = params.fetch('name')

	List.new({category: category, name: name}).save

	@lists = List.all

	erb(:index)
end

get '/list/:id' do
	id = params.fetch('id').to_i
	@lists = List.all
	@list = List.find(id)
	@tasks = @list.tasks # to build #tasks

	erb(:list_detail)
end

post '/list/:id/task/new' do
	id = params.fetch('id').to_i
	description = params.fetch('description')
	due_date = params.fetch('due_date')

	@list = List.find(id)

	Task.new({description: description, due_date: due_date, list_id: id}).save

	@tasks = @list.tasks

	erb(:list_detail)
end
