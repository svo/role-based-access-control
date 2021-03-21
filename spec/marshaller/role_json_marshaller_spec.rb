# frozen_string_literal: true

require "json-schema"
require "marshaller/role_json_marshaller"

RSpec.describe RoleJsonMarshaller do
  before(:each) do
    @subject = described_class.new
  end

  describe "converts" do
    it "Id property" do
      json = '{"Id":1,"Name":"System Administrator","Parent":0}'
      expect(@subject.from_json(json)).to include({ "Id" => 1 })
    end

    it "Name property" do
      json = '{"Id":1,"Name":"System Administrator","Parent":0}'
      expect(@subject.from_json(json)).to include({ "Name" => "System Administrator" })
    end

    it "Parent property" do
      json = '{"Id":1,"Name":"System Administrator","Parent":0}'
      expect(@subject.from_json(json)).to include({ "Parent" => 0 })
    end
  end

  describe "errors" do
    it "when missing Id property" do
      json = '{"Name":"System Administrator","Parent":0}'

      expect { @subject.from_json(json) }.to raise_error(ArgumentError, "Invalid role JSON")
    end

    it "when missing Name property" do
      json = '{"Id":1,"Parent":0}'

      expect { @subject.from_json(json) }.to raise_error(ArgumentError, "Invalid role JSON")
    end

    it "when missing Parent property" do
      json = '{"Id":1,"Name":"System Administrator"}'

      expect { @subject.from_json(json) }.to raise_error(ArgumentError, "Invalid role JSON")
    end
  end
end
