# frozen_string_literal: true

RSpec.describe UserHierarchy do
  before(:each) do
    @role_converter = double(RoleConverter)
    @role_repository = double(RoleRepository)
    @user_converter = double(UserConverter)
    @user_repository = double(UserRepository)

    @subject = described_class.new(@role_converter, @role_repository, @user_converter, @user_repository)
  end

  describe "roles" do
    it "are provided converted to repository" do
      role_transfer_object = double
      role = double(Role)

      expect(@role_converter).to receive(:convert_to_domain).with(role_transfer_object).and_return([role])
      allow(@user_repository).to receive(:delete_all)
      allow(@role_repository).to receive(:delete_all)
      expect(@role_repository).to receive(:insert).with(role)

      @subject.create_role(role_transfer_object)
    end

    it "are cleared before inserting new ones" do
      role_transfer_object = double
      role = double(Role)

      allow(@role_converter).to receive(:convert_to_domain).with(role_transfer_object).and_return([role])
      allow(@user_repository).to receive(:delete_all)
      expect(@role_repository).to receive(:delete_all).ordered
      expect(@role_repository).to receive(:insert).with(role).ordered

      @subject.create_role(role_transfer_object)
    end

    it "will clear users when recreating to avoid stale/incorrect associations" do
      role_transfer_object = double
      role = double(Role)

      allow(@role_converter).to receive(:convert_to_domain).with(role_transfer_object).and_return([role])
      expect(@user_repository).to receive(:delete_all)
      allow(@role_repository).to receive(:delete_all)
      allow(@role_repository).to receive(:insert).with(role)

      @subject.create_role(role_transfer_object)
    end

    it "are retrieved" do
      role = double(Role)

      expect(@role_repository).to receive(:retrieve_all).and_return(role)

      @subject.retrieve_role
    end
  end

  describe "users" do
    it "are provided converted to repository" do
      user_transfer_object = double
      user = double(User)

      expect(@user_converter).to receive(:convert_to_domain).with(user_transfer_object).and_return([user])
      allow(@user_repository).to receive(:delete_all)
      expect(@user_repository).to receive(:insert).with(user)

      @subject.create_user(user_transfer_object)
    end

    it "are cleared before inserting new ones" do
      user_transfer_object = double
      user = double(Role)

      allow(@user_converter).to receive(:convert_to_domain).with(user_transfer_object).and_return([user])
      expect(@user_repository).to receive(:delete_all).ordered
      expect(@user_repository).to receive(:insert).with(user).ordered

      @subject.create_user(user_transfer_object)
    end

    it "are retrieved" do
      user = double(User)

      expect(@user_repository).to receive(:retrieve_all).and_return(user)

      @subject.retrieve_user
    end
  end
end
