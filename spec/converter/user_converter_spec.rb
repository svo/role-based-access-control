# frozen_string_literal: true

require "converter/user_converter"

RSpec.describe UserConverter do
  before(:each) do
    @role_repository = double(RoleRepository)

    @subject = described_class.new(@role_repository)
  end

  it "converts to User" do
    role = double(Role)
    user = User.new(1, "Adam Admin", role)

    expect(@role_repository).to receive(:retrieve).with(101).and_return(role)
    expect(@subject.convert_to_domain([{ "Id" => 1,
                                         "Name" => "Adam Admin",
                                         "Role" => 101 }])).to eq([user])
  end
end
