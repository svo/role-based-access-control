# frozen_string_literal: true

require_relative "../model/role"
require_relative "../repository/role_repository"

class UserConverter
  def initialize(role_repository)
    @role_repository = role_repository
  end

  def convert_to_domain(data_transfer_object)
    data_transfer_object.map { |user| User.new(user["Id"], user["Name"], @role_repository.retrieve(user["Role"])) }
  end
end
