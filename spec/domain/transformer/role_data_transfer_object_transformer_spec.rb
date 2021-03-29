# frozen_string_literal: true

require "domain/transformer/role_data_transfer_object_transformer"

RSpec.describe RoleDataTransferObjectTransformer do
  before(:each) do
    @subject = described_class.new
  end

  it "transforms role with Id and Name" do
    expected = [Role.new(1, "System Administrator")]
    expect(@subject.transform([{ "Id" => 1,
                                 "Name" => "System Administrator",
                                 "Parent" => 0 }])).to eq(expected)
  end

  it "sets the parent role" do
    data_transfer_object = [{ "Id" => 1, "Name" => "System Administrator", "Parent" => 0 },
                            { "Id" => 2, "Name" => "Location Manager", "Parent" => 1 }]
    parent_role = Role.new(1, "System Administrator")
    child_role = Role.new(2, "Location Manager")
    parent_role.add_child child_role
    child_role.parent = parent_role
    expected = [parent_role, child_role]

    expect(@subject.transform(data_transfer_object)).to eq(expected)
  end

  it "sets the child roles" do
    data_transfer_object = [{ "Id" => 1, "Name" => "System Administrator", "Parent" => 0 },
                            { "Id" => 2, "Name" => "Location Manager", "Parent" => 1 }]
    parent_role = Role.new(1, "System Administrator")
    child_role = Role.new(2, "Location Manager")
    parent_role.add_child child_role
    child_role.parent = parent_role
    expected = [parent_role, child_role]

    expect(@subject.transform(data_transfer_object)).to eq(expected)
  end

  it "errors when a parent role doesn't exist" do
    data_transfer_object = [{ "Id" => 2, "Name" => "Location Manager", "Parent" => 1 }]

    expect { @subject.transform(data_transfer_object) }.to raise_error(ArgumentError, "Missing parent role 1")
  end

  it "errors when a role has a duplicate id" do
    data_transfer_object = [{ "Id" => 1, "Name" => "System Administrator", "Parent" => 0 },
                            { "Id" => 1, "Name" => "Location Manager", "Parent" => 0 }]

    expect { @subject.transform(data_transfer_object) }.to raise_error(ArgumentError, "Duplicate id 1")
  end
end
