# frozen_string_literal: true

RSpec.describe UserHierarchy do
  before(:each) do
    @converter = double(RoleConverter)
    @repository = double(RoleRepository)

    @subject = described_class.new(@converter, @repository)
  end

  describe "roles" do
    it "are provided converted to repository" do
      role_transfer_object = double
      role = double(Role)

      expect(@converter).to receive(:convert_to_domain).with(role_transfer_object).and_return([role])
      allow(@repository).to receive(:delete_all)
      expect(@repository).to receive(:insert).with(role)

      @subject.create_role(role_transfer_object)
    end

    it "are cleared before inserting new ones" do
      role_transfer_object = double
      role = double(Role)

      allow(@converter).to receive(:convert_to_domain).with(role_transfer_object).and_return([role])
      expect(@repository).to receive(:delete_all).ordered
      expect(@repository).to receive(:insert).with(role).ordered

      @subject.create_role(role_transfer_object)
    end

    it "are retrieved" do
      role = double(Role)

      expect(@repository).to receive(:retrieve_all).and_return(role)

      @subject.retrieve_role
    end
  end
end
