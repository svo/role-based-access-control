# frozen_string_literal: true

require "converter/role_converter"

RSpec.describe RoleConverter do
  before(:each) do
    @subject = described_class.new
  end

  it "converts to Role with Id and Name" do
    expected = Role.new(1, "System Administrator")
    expect(@subject.convert_to_domain([{ "Id" => 1, "Name" => "System Administrator" }])).to eq([expected])
  end
end
