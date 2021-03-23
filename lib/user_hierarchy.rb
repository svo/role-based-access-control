# frozen_string_literal: true

class UserHierarchy
  def initialize(role_converter, role_repository)
    @role_converter = role_converter
    @role_repository = role_repository
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
end
