require 'spec_helper'

describe InputOutput do

  let(:io) { InputOutput.new }

  describe "input" do
    it "gets input from user" do
      io.should_receive(:gets).and_return('X')
      io.input.should == 'X'
    end
  end

  describe "output" do
    it "puts messages to the screen" do
      test = "Test"
      io.should_receive(:puts).with(test)
      io.output(test)
    end
  end
end
