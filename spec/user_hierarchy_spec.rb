# frozen_string_literal: true

RSpec.describe UserHiearchy do
  before(:each) do
    @converter = double(RoleConverter)
    @repository = double(RoleRepository)

    @subject = described_class.new(@converter, @repository)
  end

  it "provides converted roles to repository" do
    role_transfer_object = double
    role = double(Role)

    expect(@converter).to receive(:convert).with(role_transfer_object).and_return([role])
    expect(@repository).to receive(:insert).with(role)

    @subject.create_role(role_transfer_object)
  end
end
