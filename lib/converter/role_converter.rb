# frozen_string_literal: true

require_relative "../model/role"

class RoleConverter
  def convert_to_domain(data_transfer_object)
    domain = data_transfer_object.map { |role| Role.new(role["Id"], role["Name"]) }

    domain.each do |role|
      parent_id = data_transfer_object.find { |item| item["Id"] == role.id }["Parent"]
      role.parent = domain.find { |item| item.id == parent_id }
    end
  end
end
