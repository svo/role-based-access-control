# frozen_string_literal: true

require_relative "error/not_found_error"

class UserHierarchy
  def initialize(role_data_transfer_object_transformer,
                 role_repository,
                 user_data_transfer_object_transformer,
                 user_repository)
    @role_data_transfer_object_transformer = role_data_transfer_object_transformer
    @role_repository = role_repository
    @user_data_transfer_object_transformer = user_data_transfer_object_transformer
    @user_repository = user_repository
  end

  def create_role(role_transfer_object)
    role = @role_data_transfer_object_transformer.transform(role_transfer_object)

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
    user = @user_data_transfer_object_transformer.transform(user_transfer_object)

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
    user = @user_repository.retrieve(id)

    raise NotFoundError, "Missing user #{id}" if user.nil?

    @user_repository.retrieve_with_role(user.role.subordinate)
  end
end
