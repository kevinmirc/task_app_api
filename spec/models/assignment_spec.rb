require 'rails_helper'

RSpec.describe Assignment, type: :model do
  let(:user) { User.new(email: 'kevin@gmail.com') }
  let(:task) { Task.new(title: "Make Wire Frames", description: "Create Greatness.") }
  
  it "references a user" do
    assignment = Assignment.new(user: user)
    expect(assignment.user).to be(user) 
  end

  it "references a task" do
    assignment = Assignment.new(task: task)
    expect(assignment.task).to be(task) 
  end

  it "validates presense of user" do
    assignment = Assignment.new(task: task)
    expect {assignment.save!}.to raise_error ActiveRecord::RecordInvalid
  end

  it "validates presense of task" do
    assignment = Assignment.new(user: user)
    expect {assignment.save!}.to raise_error ActiveRecord::RecordInvalid
  end
end