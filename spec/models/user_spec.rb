require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(email: "kevin@gmail.com") }

  it "#email returns an email" do
    expect(user.email).to eq("kevin@gmail.com")
  end
end
