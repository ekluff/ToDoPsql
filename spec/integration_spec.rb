require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new list', {:type => :feature}) do
  it('allows a user to add a list and to see all lists') do
    visit('/')
    click_link('+ List')
    fill_in('name', with: 'Epicodus Work')
    select('School', from: 'category')
    click_button('Add List')
    expect(page).to have_content('Epicodus Work')
  end
end

describe('adding a new task', {:type => :feature}) do
  it('allows a user to click a list to see the tasks and a task') do
    list = List.new({name: 'Animals to Wash', category: 'Work'})
    list.save
    visit("/list/#{list.id}")

    fill_in('description', with: 'Platypus')
    fill_in('due_date', with: '1986-05-29')

    click_button('+ Task')
    expect(page).to have_content('Platypus')
  end

  describe('complete a task', {:type => :feature}) do
    it('allows a user to mark a task as complete') do
      list = List.new({name: 'Animals to Wash', category: 'Work'})
      list.save
      task = Task.new({description: 'Camel Coat Cleaning', list_id: list.id, due_date: '1988-08-09'})
      task.save
      visit("/list/#{list.id}")
      click_link 'Done!'

    end
end
