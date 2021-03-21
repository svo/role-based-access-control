# frozen_string_literal: true

require "marshaller/role_json_marshaller"

RSpec.describe RoleJsonMarshaller do
  before(:each) do
    @subject = described_class.new
  end

  it "converts a valid json array into the domain array" do
    json = '{"Id":1,"Name":"System Administrator","Parent":0}'

    expect(@subject.from_json(json)).to eq({ "Id" => 1, "Name" => "System Administrator", "Parent" => 0 })
  end
end
