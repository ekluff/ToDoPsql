require 'spec_helper'
require 'pry'



describe List do
  describe '.all' do
    it 'starts off with no lists' do
      expect(List.all).to eq []
    end
  end

  describe '#name' do
    it 'tells you its name' do
      list = List.new({ name: 'Epicodus stuff', id: nil })
      expect(list.name).to eq 'Epicodus stuff'
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      expect(list.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#category") do
    it("returns the category of a list") do
      list = List.new({ name: 'Animals to Wash', id: nil, category: 'Personal'})
      list.save()
      expect(list.category()).to(eq('Personal'))
    end
  end

  describe("#save") do
    it("lets you save lists to the database") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      expect(List.all()).to(eq([list]))
    end
  end

  describe("#==") do
    it("is the same list if it has the same name") do
      list1 = List.new({:name => "Epicodus stuff", :id => nil})
      list2 = List.new({:name => "Epicodus stuff", :id => nil})
      expect(list1).to(eq(list2))
    end
  end

  describe(".find") do
    it('finds the list by it\'s id') do
      list1 = List.new({:name => "Epicodus stuff", :id => nil})
      list2 = List.new({:name => "Epicodus stuff", :id => nil})
      list1.save
      list2.save
      expect(List.find(list1.id)).to eq list1
    end
  end

  describe("#tasks") do
    it('returns an array of all tasks with one list_id') do
      list = List.new({name: 'Animals to maintain', category: 'Private'})
      list.save
      task1 = Task.new({description: 'Pluck the duck', due_date: 'June 6, 1885', list_id: list.id})
      task2 = Task.new({description: 'Eat some tacos', due_date: '2014-08-17', list_id: 0})
      task3 = Task.new({description: 'Dry clean the hamster', due_date: '2107-02-06', list_id: list.id})
      task1.save
      task2.save
      task3.save
      # binding.pry
      expect(list.tasks).to(eq([task1, task3]))
    end
  end

end
