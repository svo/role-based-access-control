# frozen_string_literal: true

RSpec.describe UserHierarchy do
  before(:each) do
    @role_domain_factory = double(RoleDomainFactory)
    @role_repository = double(RoleRepository)
    @user_domain_factory = double(UserDomainFactory)
    @user_repository = double(UserRepository)

    @subject = described_class.new(@role_domain_factory, @role_repository, @user_domain_factory, @user_repository)
  end

  describe "roles" do
    it "has provided the domain representation to the repository" do
      role_transfer_object = double
      role = double(Role)

      expect(@role_domain_factory).to receive(:build).with(role_transfer_object).and_return([role])
      allow(@user_repository).to receive(:delete_all)
      allow(@role_repository).to receive(:delete_all)
      expect(@role_repository).to receive(:insert).with(role)

      @subject.create_role(role_transfer_object)
    end

    it "has cleared records before inserting new ones" do
      role_transfer_object = double
      role = double(Role)

      allow(@role_domain_factory).to receive(:build).with(role_transfer_object).and_return([role])
      allow(@user_repository).to receive(:delete_all)
      expect(@role_repository).to receive(:delete_all).ordered
      expect(@role_repository).to receive(:insert).with(role).ordered

      @subject.create_role(role_transfer_object)
    end

    it "has cleared users when recreating to avoid stale/incorrect associations" do
      role_transfer_object = double
      role = double(Role)

      allow(@role_domain_factory).to receive(:build).with(role_transfer_object).and_return([role])
      expect(@user_repository).to receive(:delete_all)
      allow(@role_repository).to receive(:delete_all)
      allow(@role_repository).to receive(:insert).with(role)

      @subject.create_role(role_transfer_object)
    end

    it "has retrieved all the roles" do
      role = [double(Role)]

      expect(@role_repository).to receive(:retrieve_all).and_return(role)

      expect(@subject.retrieve_role).to eq(role)
    end
  end

  describe "users" do
    it "has provided the domain representation to the repository" do
      user_transfer_object = double
      user = double(User)

      expect(@user_domain_factory).to receive(:build).with(user_transfer_object).and_return([user])
      allow(@user_repository).to receive(:delete_all)
      expect(@user_repository).to receive(:insert).with(user)

      @subject.create_user(user_transfer_object)
    end

    it "has cleared records before inserting new ones" do
      user_transfer_object = double
      user = double(Role)

      allow(@user_domain_factory).to receive(:build).with(user_transfer_object).and_return([user])
      expect(@user_repository).to receive(:delete_all).ordered
      expect(@user_repository).to receive(:insert).with(user).ordered

      @subject.create_user(user_transfer_object)
    end

    it "has retrieved all the users" do
      user = double(User)

      expect(@user_repository).to receive(:retrieve_all).and_return(user)

      expect(@subject.retrieve_user).to eq(user)
    end

    describe "subordinate" do
      it "has retrieved all the subordinates for a given user" do
        id = 101
        user = double(User)
        parent_role = double(Role)
        subordinate_role = [double(Role)]
        subordinate_user = [double(User)]

        expect(@user_repository).to receive(:retrieve).with(id).and_return(user)
        expect(user).to receive(:role).and_return(parent_role)
        expect(parent_role).to receive(:subordinate).and_return(subordinate_role)
        expect(@user_repository).to receive(:retrieve_with_role).and_return(subordinate_user)

        expect(@subject.retrieve_user_subordinate(id)).to eq(subordinate_user)
      end

      it "errors when user for subordinate request is not found" do
        id = 101

        expect(@user_repository).to receive(:retrieve).with(id).and_return(nil)

        expect do
          @subject.retrieve_user_subordinate(id)
        end.to raise_error(NotFoundError, "Missing user 101")
      end
    end
  end
end
