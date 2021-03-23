# frozen_string_literal: true

require "repository/user_repository"

RSpec.describe UserRepository do
  describe "should retrieve" do
    it "no records by default" do
      @subject = described_class.new

      expect(@subject.retrieve_all).to eq([])
    end

    it "all users" do
      user = [double(User)]
      @subject = described_class.new(user)

      expect(@subject.retrieve_all).to eq(user)
    end
  end

  it "should delete all records" do
    user = [double(User)]
    @subject = described_class.new(user)

    @subject.delete_all

    expect(@subject.retrieve_all).to eq([])
  end

  it "should insert record" do
    user = double(User)
    @subject = described_class.new

    @subject.insert user

    expect(@subject.retrieve_all).to eq([user])
  end
end
