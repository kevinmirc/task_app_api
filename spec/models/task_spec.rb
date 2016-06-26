require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:title) { "Do a coding challenge" }
  let(:description) { "Create the backend APIs to make this app possible.\nAdd the possibility to assign a task to multiple users\nAdd the possibility to create a user via a facebook token \n(BONUS - authenticate the users) \n(BONUS - create a front end)" }
  let(:kevin) { User.new(email: "kevin@gmail.com") }
  
  it "has a title" do
    task = Task.new(title: title)
    expect(task.title).to eq(title)
  end

  it "has a description" do
    task = Task.new(description: description)
    expect(task.description).to eq(description)
  end

  it "validates presence of title before saving" do
    task = Task.create
    expect(task.id).to be_nil
  end

  it "has an #author that references a user" do
    task = Task.new(title: "Write Tests", author: kevin)
    expect(task.author).to be(kevin)
  end
end
