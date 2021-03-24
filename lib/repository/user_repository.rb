# frozen_string_literal: true

class UserRepository
  def initialize(user = [])
    @user = user
  end

  def retrieve_all
    @user.clone
  end

  def retrieve(id)
    @user.find { |item| item.id == id }
  end

  def retrieve_with_role(role)
    @user.select { |item| role.include? item.role }
  end

  def delete_all
    @user.clear
  end

  def insert(user)
    @user.push user
  end
end
