# frozen_string_literal: true

require_relative "../user"
require_relative "../../repository/role_repository"

class UserDomainFactory
  def initialize(role_repository)
    @role_repository = role_repository
  end

  def build(data_transfer_object)
    data_transfer_object.map do |user|
      role_id = user["Role"]
      role = @role_repository.retrieve(role_id)
      validate(role, role_id)
      User.new(user["Id"], user["Name"], role)
    end
  end

  private

  def validate(role, role_id)
    raise ArgumentError, "Missing role #{role_id}" if role.nil?
  end
end
