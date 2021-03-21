# frozen_string_literal: true

class UserHiearchy
  def initialize(role_converter, role_repository)
    @role_converter = role_converter
    @role_repository = role_repository
  end

  def create_role(role_transfer_object)
    @role_converter.convert(role_transfer_object).each { |role| @role_repository.insert(role) }
  end
end
