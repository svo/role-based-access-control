# frozen_string_literal: true

class UserRepository
  def initialize(user = [])
    @user = user
  end

  def retrieve_all
    @user.clone
  end

  def delete_all
    @user.clear
  end

  def insert(user)
    @user.push user
  end
end
