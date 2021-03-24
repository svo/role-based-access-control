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

    it "a user" do
      id = 101
      user = double(User)
      @subject = described_class.new([user])

      expect(user).to receive(:id).and_return(id)
      expect(@subject.retrieve(id)).to eq(user)
    end

    it "user with role" do
      user1 = double(User)
      user2 = double(User)
      user3 = double(User)
      role1 = double(Role)
      role2 = double(Role)
      @subject = described_class.new([user1, user2, user3])

      expect(user1).to receive(:role).and_return(role1)
      expect(user2).to receive(:role).and_return(role2)
      expect(user3).to receive(:role).and_return(double(Role))

      expect(@subject.retrieve_with_role([role1, role2])).to eq([user1, user2])
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
