require 'rails_helper'

RSpec.describe Content, type: :model do

  let(:user) { User.create(email: "test@example.com", password: "password") }
  it "is valid with valid attributes" do
    content = Content.new(
      title: "Test Title",
      body: "Test Body",
      user: user
    )
    expect(content).to be_valid
  end

  it "is invalid without a title" do
    content = Content.new(
      body: "Test Body",
      user: user
    )
    expect(content).not_to be_valid
    expect(content.errors[:title]).to be_present
  end

  it "is invalid without a body" do
    content = Content.new(
      title: "Test Title",
      user: user
    )
    expect(content).not_to be_valid
    expect(content.errors[:body]).to be_present
  end

  it "is invalid without a user" do
    content = Content.new(
      title: "Test Title",
      body: "Test Body"
    )
    expect(content).not_to be_valid
  end
  
end
