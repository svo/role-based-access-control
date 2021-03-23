# frozen_string_literal: true

require "model/role"

RSpec.describe Role do
  it "has subordinate hierarchy" do
    parent = Role.new(1, "System Administrator")
    child = Role.new(2, "Location Manager")
    child_of_child = Role.new(3, "Supervisor")

    parent.add_child(child)
    child.add_child(child_of_child)

    expect(parent.subordinate).to eq([child, child_of_child])
  end
end
