# frozen_string_literal: true

require "repository/role_repository"

RSpec.describe RoleRepository do
  describe "retrieves" do
    it "has no records by default" do
      @subject = described_class.new

      expect(@subject.retrieve_all).to eq([])
    end

    it "has all the roles" do
      role = [double(Role)]
      @subject = described_class.new(role)

      expect(@subject.retrieve_all).to eq(role)
    end

    it "has a given role" do
      id = 101
      role = double(Role)
      @subject = described_class.new([role])

      expect(role).to receive(:id).and_return(id)
      expect(@subject.retrieve(id)).to eq(role)
    end
  end

  it "deletes all records" do
    role = [double(Role)]
    @subject = described_class.new(role)

    @subject.delete_all

    expect(@subject.retrieve_all).to eq([])
  end

  it "inserts a record" do
    role = double(Role)
    @subject = described_class.new

    @subject.insert role

    expect(@subject.retrieve_all).to eq([role])
  end
end
