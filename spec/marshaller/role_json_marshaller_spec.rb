# frozen_string_literal: true

require "json-schema"
require "marshaller/role_json_marshaller"

RSpec.describe RoleJsonMarshaller do
  before(:each) do
    @subject = described_class.new
  end

  describe "converts" do
    it "Id property" do
      json = '{"Id":1}'

      expect(@subject.from_json(json)).to eq({ "Id" => 1 })
    end
  end

  describe "errors" do
    it "when missing 'Id' property" do
      json = "{}"

      expect { @subject.from_json(json) }.to raise_error(ArgumentError, "Invalid role JSON")
    end
  end
end
