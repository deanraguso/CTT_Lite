require_relative 'spec_helper'
require_relative "../UserManager.rb"

describe UserManager do
    describe '.read_to_comma' do
      context "given a string containing a comma" do
        it "returns the sub-string up to the first comma" do
            test_string = "asdfasdf,asdfasdf"
            result = UserManager.new.read_to_comma(test_string)
            expect(result).to eq("asdfasdf")
        end
      end
    end
end