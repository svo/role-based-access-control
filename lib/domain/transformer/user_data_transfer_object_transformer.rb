# frozen_string_literal: true

require_relative "../user"
require_relative "../../repository/role_repository"

class UserDataTransferObjectTransformer
  def initialize(role_repository)
    @role_repository = role_repository
  end

  def transform(data_transfer_object)
    validate_no_duplicate(data_transfer_object)

    data_transfer_object.map do |user|
      role_id = user["Role"]
      role = @role_repository.retrieve(role_id)
      validate_role(role, role_id)
      User.new(user["Id"], user["Name"], role)
    end
  end

  private

  def validate_no_duplicate(data_transfer_object)
    id = data_transfer_object.map { |item| item.slice("Id") }
    duplicate = id.detect { |user| id.count(user) > 1 }

    raise ArgumentError, "Duplicate id #{duplicate["Id"]}" unless duplicate.nil?
  end

  def validate_role(role, role_id)
    raise ArgumentError, "Missing role #{role_id}" if role.nil?
  end
end
