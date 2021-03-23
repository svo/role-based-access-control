# frozen_string_literal: true

class RoleRepository
  def initialize(role = [])
    @role = role
  end

  def retrieve_all
    @role.clone
  end

  def delete_all
    @role.clear
  end

  def insert(role)
    @role.push role
  end
end
