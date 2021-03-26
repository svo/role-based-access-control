# frozen_string_literal: true

require "domain/factory/user_domain_factory"

RSpec.describe UserDomainFactory do
  before(:each) do
    @role_repository = double(RoleRepository)

    @subject = described_class.new(@role_repository)
  end

  it "builds user" do
    role = double(Role)
    user = User.new(1, "Adam Admin", role)

    allow(@role_repository).to receive(:retrieve).with(101).and_return(role)

    expect(@subject.build([{ "Id" => 1,
                             "Name" => "Adam Admin",
                             "Role" => 101 }])).to eq([user])
  end

  it "errors when user role doesn't exist" do
    allow(@role_repository).to receive(:retrieve).with(101).and_return(nil)

    expect do
      @subject.build([{ "Id" => 1,
                        "Name" => "Adam Admin",
                        "Role" => 101 }])
    end.to raise_error(ArgumentError, "Missing role 101")
  end

  it "errors when a user has a duplicate id" do
    data_transfer_object = [{ "Id" => 1, "Name" => "Adam Admin", "Role" => 1 },
                            { "Id" => 1, "Name" => "Emily Employee", "Parent" => 1 }]

    expect { @subject.build(data_transfer_object) }.to raise_error(ArgumentError, "Duplicate id 1")
  end
end
