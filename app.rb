require 'sinatra'

get '/'  do
	@lists = List.all
	erb(:index)
end

get('list/new') do
	erb(:list_form)
end

post('list/new') do
	category = params.fetch('category')
	name = params.fetch('name')

	List.new({category: category, name: name}).save

	@lists = List.all

	erb(:index)
end
