# frozen_string_literal: true

require "json-schema"
require "marshaller/user_json_marshaller"

VALID_USER_JSON = '[{"Id":1,"Name":"Adam Admin","Role":1}]'
PROVIDED_EXAMPLE_USER_JSON = '[{"Id":1,"Name":"Adam Admin","Role":1},
{"Id":2,"Name":"Emily Employee","Role":4},
{"Id":3,"Name":"Sam Supervisor","Role":3},
{"Id":4,"Name":"Mary Manager","Role":2},
{"Id":5,"Name":"Steve Trainer","Role":5}]'

RSpec.describe UserJsonMarshaller do
  before(:each) do
    @subject = described_class.new
  end

  describe "from json" do
    describe "marshalls" do
      it "Id property" do
        expect(@subject.from_json(VALID_USER_JSON)).to include(include({ "Id" => 1 }))
      end

      it "Name property" do
        expect(@subject.from_json(VALID_USER_JSON)).to include(include({ "Name" => "Adam Admin" }))
      end

      it "Role property" do
        expect(@subject.from_json(VALID_USER_JSON)).to include(include({ "Role" => 1 }))
      end

      it "provided example" do
        expect(@subject.from_json(PROVIDED_EXAMPLE_USER_JSON)).to eq(
          [{ "Id" => 1, "Name" => "Adam Admin", "Role" => 1 },
           { "Id" => 2, "Name" => "Emily Employee", "Role" => 4 },
           { "Id" => 3, "Name" => "Sam Supervisor", "Role" => 3 },
           { "Id" => 4, "Name" => "Mary Manager", "Role" => 2 },
           { "Id" => 5, "Name" => "Steve Trainer", "Role" => 5 }]
        )
      end
    end

    describe "errors" do
      it "when missing Id property" do
        json = '{"Name":"System Administrator","Role":0}'

        expect { @subject.from_json(json) }.to raise_error(ArgumentError, "Invalid user JSON")
      end

      it "when missing Name property" do
        json = '{"Id":1,"Role":0}'

        expect { @subject.from_json(json) }.to raise_error(ArgumentError, "Invalid user JSON")
      end

      it "when missing Role property" do
        json = '{"Id":1,"Name":"System Administrator"}'

        expect { @subject.from_json(json) }.to raise_error(ArgumentError, "Invalid user JSON")
      end

      it "when given unexpected property" do
        json = '{"Id":1,"Name":"System Administrator","Role":0,"Coconuts":1}'

        expect { @subject.from_json(json) }.to raise_error(ArgumentError, "Invalid user JSON")
      end
    end
  end

  describe "from json" do
    describe "marshalls" do
      it "user to json" do
        role = Role.new(101, "System Administrator")
        user = User.new(1, "Adam Admin", role)

        expect(@subject.to_json([user])).to eq('[{"Id":1,"Name":"Adam Admin","Role":101}]')
      end
    end
  end
end
