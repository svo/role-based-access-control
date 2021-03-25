# frozen_string_literal: true

require_relative "../role"

class RoleDomainFactory
  def build(data_transfer_object)
    domain = data_transfer_object.map { |role| Role.new(role["Id"], role["Name"]) }

    configure_parent(domain, data_transfer_object)
    configure_children(domain)
  end

  private

  def configure_parent(domain, data_transfer_object)
    domain.each do |role|
      parent_id = data_transfer_object.find { |item| item["Id"] == role.id }["Parent"]
      role.parent = domain.find { |item| item.id == parent_id }
    end
  end

  def configure_children(domain)
    domain.each do |parent|
      children = domain.select { |role| role.parent == parent }
      children.each { |child| parent.add_child child }
    end
  end
end
