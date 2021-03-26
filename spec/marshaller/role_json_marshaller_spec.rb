# frozen_string_literal: true

require "json-schema"
require "marshaller/role_json_marshaller"

VALID_ROLE_JSON = '[{"Id":1,"Name":"System Administrator","Parent":0}]'
PROVIDED_EXAMPLE_ROLE_JSON = '[{"Id":1,"Name":"System Administrator","Parent":0},
{"Id":2,"Name":"Location Manager","Parent":1},
{"Id":3,"Name":"Supervisor","Parent":2},
{"Id":4,"Name":"Employee","Parent":3},
{"Id":5,"Name":"Trainer","Parent":3}]'

RSpec.describe RoleJsonMarshaller do
  before(:each) do
    @subject = described_class.new
  end

  describe "from json" do
    describe "marshalls to a hash" do
      it "has an Id property" do
        expect(@subject.from_json(VALID_ROLE_JSON)).to include(include({ "Id" => 1 }))
      end

      it "has a Name property" do
        expect(@subject.from_json(VALID_ROLE_JSON)).to include(include({ "Name" => "System Administrator" }))
      end

      it "has a Parent property" do
        expect(@subject.from_json(VALID_ROLE_JSON)).to include(include({ "Parent" => 0 }))
      end

      it "matches provided example" do
        expect(@subject.from_json(PROVIDED_EXAMPLE_ROLE_JSON)).to eq(
          [{ "Id" => 1, "Name" => "System Administrator", "Parent" => 0 },
           { "Id" => 2, "Name" => "Location Manager", "Parent" => 1 },
           { "Id" => 3, "Name" => "Supervisor", "Parent" => 2 },
           { "Id" => 4, "Name" => "Employee", "Parent" => 3 },
           { "Id" => 5, "Name" => "Trainer", "Parent" => 3 }]
        )
      end
    end

    describe "error whens" do
      it "is missing the Id property" do
        json = '{"Name":"System Administrator","Parent":0}'

        expect { @subject.from_json(json) }.to raise_error(ArgumentError, "Invalid role JSON")
      end

      it "is missing the Name property" do
        json = '{"Id":1,"Parent":0}'

        expect { @subject.from_json(json) }.to raise_error(ArgumentError, "Invalid role JSON")
      end

      it "is missing the Parent property" do
        json = '{"Id":1,"Name":"System Administrator"}'

        expect { @subject.from_json(json) }.to raise_error(ArgumentError, "Invalid role JSON")
      end

      it "is given an unexpected property" do
        json = '{"Id":1,"Name":"System Administrator","Parent":0,"Coconuts":1}'

        expect { @subject.from_json(json) }.to raise_error(ArgumentError, "Invalid role JSON")
      end
    end
  end

  describe "to json" do
    it "marshalls role with no parent role" do
      expected = '[{"Id":1,"Name":"System Administrator","Parent":0}]'
      expect(@subject.to_json([Role.new(1, "System Administrator")])).to eq(expected)
    end

    it "marshalls role with a parent role" do
      parent = Role.new(1, "System Administrator")
      child = Role.new(2, "Location Manager")
      child.parent = parent

      expect(@subject.to_json([child])).to eq('[{"Id":2,"Name":"Location Manager","Parent":1}]')
    end
  end
end
