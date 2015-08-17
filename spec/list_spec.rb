require 'rspec'
require 'pg'
require 'list'

DB = PG.connect({dbname: 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lists *;")
  end
end

describe List do
  describe '.all' do
    it 'starts off with no lists' do
      expect(List.all).to eq []
    end
  end
  
end
