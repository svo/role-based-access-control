# frozen_string_literal: true

require_relative "../user"
require_relative "../../repository/role_repository"

class UserDomainFactory
  def initialize(role_repository)
    @role_repository = role_repository
  end

  def build(data_transfer_object)
    data_transfer_object.map { |user| User.new(user["Id"], user["Name"], @role_repository.retrieve(user["Role"])) }
  end
end
