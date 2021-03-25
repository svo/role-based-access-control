# frozen_string_literal: true

require_relative "../role"

class RoleDomainFactory
  def build(data_transfer_object)
    domain = data_transfer_object.map { |role| Role.new(role["Id"], role["Name"]) }

    validate_no_duplicate(domain)

    configure_parent(domain, data_transfer_object)
    configure_children(domain)
  end

  private

  def configure_parent(domain, data_transfer_object)
    domain.each do |role|
      parent_id = data_transfer_object.find { |item| item["Id"] == role.id }["Parent"]
      role.parent = domain.find { |item| item.id == parent_id }
      validate_parent(role.parent, parent_id) unless parent_id.zero?
    end
  end

  def configure_children(domain)
    domain.each do |parent|
      children = domain.select { |role| role.parent == parent }
      children.each { |child| parent.add_child child }
    end
  end

  def validate_no_duplicate(domain)
    id = domain.map(&:id)
    duplicate_id = id.detect { |role_id| id.count(role_id) > 1 }

    raise ArgumentError, "Duplicate id #{duplicate_id}" unless duplicate_id.nil?
  end

  def validate_parent(parent, parent_id)
    raise ArgumentError, "Missing parent role #{parent_id}" if parent.nil?
  end
end
