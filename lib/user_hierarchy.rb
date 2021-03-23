# frozen_string_literal: true

class UserHierarchy
  def initialize(role_converter, role_repository, user_converter, user_repository)
    @role_converter = role_converter
    @role_repository = role_repository
    @user_converter = user_converter
    @user_repository = user_repository
  end

  def create_role(role_transfer_object)
    role = @role_converter.convert_to_domain(role_transfer_object)

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
    user = @user_converter.convert_to_domain(user_transfer_object)

    @user_repository.delete_all
    user.each do |record|
      @user_repository.insert(record)
    end

    nil
  end

  def retrieve_user
    @user_repository.retrieve_all
  end
end
