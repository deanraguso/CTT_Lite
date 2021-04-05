require_relative 'spec_helper.rb'

describe Session do
    before do
        @session = Session.new
    end
    
    it "exists" do 
        expect(@session).to respond_to(:new)
    end
end