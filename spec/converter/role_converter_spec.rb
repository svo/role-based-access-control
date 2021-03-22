# frozen_string_literal: true

require "converter/role_converter"

RSpec.describe RoleConverter do
  before(:each) do
    @subject = described_class.new
  end

  it "converts the Id property" do
    expected = Role.new(1)
    expect(@subject.convert_to_domain([{ "Id" => 1 }])).to eq([expected])
  end
end
