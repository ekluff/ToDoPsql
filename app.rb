require('sinatra')
require('sinatra/reloader')
require('./lib/list')
require('./lib/task')
require('pg')
require('spec_helper')
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
