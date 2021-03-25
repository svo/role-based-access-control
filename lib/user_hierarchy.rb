# frozen_string_literal: true

class UserHierarchy
  def initialize(role_domain_factory, role_repository, user_domain_factory, user_repository)
    @role_domain_factory = role_domain_factory
    @role_repository = role_repository
    @user_domain_factory = user_domain_factory
    @user_repository = user_repository
  end

  def create_role(role_transfer_object)
    role = @role_domain_factory.build(role_transfer_object)

    @user_repository.delete_all

    @role_repository.delete_all
    role.each do |record|
      @role_repository.insert(record)
    end

    nil
  end

  def retrieve_role
    @role_repository.retrieve_all
  end

  def create_user(user_transfer_object)
    user = @user_domain_factory.build(user_transfer_object)

    @user_repository.delete_all
    user.each do |record|
      @user_repository.insert(record)
    end

    nil
  end

  def retrieve_user
    @user_repository.retrieve_all
  end

  def retrieve_user_subordinate(id)
    @user_repository.retrieve_with_role(@user_repository.retrieve(id).role.subordinate)
  end
end
