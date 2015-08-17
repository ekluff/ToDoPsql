require 'spec_helper'



describe Task do
  before do
    @test_task = Task.new({ description: 'learn SQL', list_id: 1, due_date: '2015-09-12' })
    @test_task2 = Task.new({ description: 'learn SQL', list_id: 1, due_date: '2015-09-12' })
  end
  describe '#==' do
    it 'is the same task if it has the same description' do
      expect(@test_task).to eq @test_task2
    end
  end


  describe ".all" do
     it "is empty at first" do
       expect(Task.all()).to(eq([]))
     end
  end

  describe '#save' do
    it 'adds a task to the array of saved tasks' do
      @test_task.save
      expect(Task.all).to eq [@test_task]
    end
  end

  describe '#list_id' do
    it 'lets you read the list ID out' do
      expect(@test_task.list_id).to eq 1
    end
  end

  describe '#due_date' do
    it 'returns due date of task' do
      expect(@test_task.due_date).to eq '2015-09-12'
    end
  end

end
