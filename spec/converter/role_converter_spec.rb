# frozen_string_literal: true

require "converter/role_converter"

RSpec.describe RoleConverter do
  before(:each) do
    @subject = described_class.new
  end

  it "converts to Role with Id and Name" do
    expected = [Role.new(1, "System Administrator")]
    expect(@subject.convert_to_domain([{ "Id" => 1,
                                         "Name" => "System Administrator",
                                         "Parent" => nil }])).to eq(expected)
  end

  it "sets the parent role" do
    data_transfer_object = [{ "Id" => 1, "Name" => "System Administrator", "Parent" => 0 },
                            { "Id" => 2, "Name" => "Location Manager", "Parent" => 1 }]
    parent_role = Role.new(1, "System Administrator")
    child_role = Role.new(2, "Location Manager")
    parent_role.add_child child_role
    child_role.parent = parent_role
    expected = [parent_role, child_role]

    expect(@subject.convert_to_domain(data_transfer_object)).to eq(expected)
  end

  it "sets the child roles" do
    data_transfer_object = [{ "Id" => 1, "Name" => "System Administrator", "Parent" => 0 },
                            { "Id" => 2, "Name" => "Location Manager", "Parent" => 1 }]
    parent_role = Role.new(1, "System Administrator")
    child_role = Role.new(2, "Location Manager")
    parent_role.add_child child_role
    child_role.parent = parent_role
    expected = [parent_role, child_role]

    expect(@subject.convert_to_domain(data_transfer_object)).to eq(expected)
  end
end
