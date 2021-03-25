# frozen_string_literal: true

require "sinatra"
require_relative "user_hierarchy"
require_relative "marshaller/role_json_marshaller"
require_relative "factory/role_domain_factory"
require_relative "repository/role_repository"
require_relative "marshaller/user_json_marshaller"
require_relative "factory/user_domain_factory"
require_relative "repository/user_repository"

module Facade
  def self.role_json_marshaller
    @role_json_marshaller ||= RoleJsonMarshaller.new
  end

  def self.user_json_marshaller
    @user_json_marshaller ||= UserJsonMarshaller.new
  end

  def self.role_repository
    @role_repository ||= RoleRepository.new
  end

  def self.role_domain_factory
    @role_domain_factory ||= RoleDomainFactory.new
  end

  def self.user_repository
    @user_repository ||= UserRepository.new
  end

  def self.user_domain_factory
    @user_domain_factory ||= UserDomainFactory.new(@role_repository)
  end

  def self.user_hierarchy
    @user_hierarchy ||= UserHierarchy.new(role_domain_factory,
                                          role_repository,
                                          user_domain_factory,
                                          user_repository)
  end
end

post "/role" do
  begin
    Facade.user_hierarchy.create_role Facade.role_json_marshaller.from_json request.body.read
  rescue ArgumentError => e
    halt 400, { "message" => e.message }.to_json
  end
end

get "/role" do
  Facade.role_json_marshaller.to_json Facade.user_hierarchy.retrieve_role
end

post "/user" do
  Facade.user_hierarchy.create_user Facade.user_json_marshaller.from_json request.body.read
end

get "/user" do
  Facade.user_json_marshaller.to_json Facade.user_hierarchy.retrieve_user
end

get "/user/:id/subordinate" do |id|
  Facade.user_json_marshaller.to_json Facade.user_hierarchy.retrieve_user_subordinate id.to_i
end
