# frozen_string_literal: true

class RoleConverter
  def convert_to_domain(data_transfer_object)
    data_transfer_object.map { |role| Role.new(role["Id"]) }
  end
end
