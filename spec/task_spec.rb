require 'spec_helper'



describe Task do
  before do
    @test_task = Task.new({ description: 'learn SQL', list_id: 1, due_date: '2015-09-12', complete: false})
    @test_task2 = Task.new({ description: 'learn SQL', list_id: 1, due_date: '2015-09-12', complete: false})
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

     it 'returns the tasks sorted by date' do
       sort_task = Task.new({ description: 'learn SQL', list_id: 1, due_date: '2015-09-12', complete: false })
       sort_task2 = Task.new({ description: 'learn SQL', list_id: 1, due_date: '2015-08-12', complete: false })
       sort_task.save
       sort_task2.save
       expect(Task.all.first).to eq sort_task2
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

  describe '#complete?' do
    it 'returns false by default' do
      expect(@test_task.complete?).to eq false
    end
  end

  describe '#completed' do
    it 'set complete to true' do
      @test_task.save
      @test_task.completed
      
      expect(@test_task.complete?).to eq true
    end
  end

end
