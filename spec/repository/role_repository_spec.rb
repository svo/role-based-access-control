# frozen_string_literal: true

require "repository/role_repository"

RSpec.describe RoleRepository do
  describe "should retrieve" do
    it "no records by default" do
      @subject = described_class.new

      expect(@subject.retrieve_all).to eq([])
    end

    it "provided roles when primed" do
      role = [double(Role)]
      @subject = described_class.new(role)

      expect(@subject.retrieve_all).to eq(role)
    end
  end

  it "should delete all records" do
    role = [double(Role)]
    @subject = described_class.new(role)

    @subject.delete_all

    expect(@subject.retrieve_all).to eq([])
  end

  it "should instert record" do
    role = double(Role)
    @subject = described_class.new

    @subject.insert role

    expect(@subject.retrieve_all).to eq([role])
  end
end
