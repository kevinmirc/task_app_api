require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(email: "kevin@gmail.com") }

  describe "#email" do
    it "returns an email" do
      expect(user.email).to eq("kevin@gmail.com")
    end
  end

  describe "#tasks" do
    it "returns the tasks assigned to that user" do
      task = Task.new(title: "Make Wire Frame", description: "Build something great.")
      user.tasks << task
      expect(user.tasks).to include(task)
    end
  end

  describe "#tasks_created" do
    it "#tasks_created returns all the tasks that user is the author of" do
      task = Task.create(author: user, title: "Make Wire Frame", description: "Build something great.")
      expect(user.tasks_created).to include(task)
    end
  end
end
