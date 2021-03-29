# frozen_string_literal: true

require "sinatra"
require_relative "user_hierarchy"
require_relative "marshaller/role_json_marshaller"
require_relative "domain/transformer/role_data_transfer_object_transformer"
require_relative "repository/role_repository"
require_relative "marshaller/user_json_marshaller"
require_relative "domain/transformer/user_data_transfer_object_transformer"
require_relative "repository/user_repository"

module Context
  def self.role_json_marshaller
    @role_json_marshaller ||= RoleJsonMarshaller.new
  end

  def self.user_json_marshaller
    @user_json_marshaller ||= UserJsonMarshaller.new
  end

  def self.role_repository
    @role_repository ||= RoleRepository.new
  end

  def self.role_data_transfer_object_transformer
    @role_data_transfer_object_transformer ||= RoleDataTransferObjectTransformer.new
  end

  def self.user_repository
    @user_repository ||= UserRepository.new
  end

  def self.user_data_transfer_object_transformer
    @user_data_transfer_object_transformer ||= UserDataTransferObjectTransformer.new(@role_repository)
  end

  def self.user_hierarchy
    @user_hierarchy ||= UserHierarchy.new(role_data_transfer_object_transformer,
                                          role_repository,
                                          user_data_transfer_object_transformer,
                                          user_repository)
  end
end

post "/role" do
  begin
    Context.user_hierarchy.create_role Context.role_json_marshaller.from_json request.body.read
  rescue ArgumentError => e
    halt 400, { "message" => e.message }.to_json
  end
end

get "/role" do
  Context.role_json_marshaller.to_json Context.user_hierarchy.retrieve_role
end

post "/user" do
  begin
    Context.user_hierarchy.create_user Context.user_json_marshaller.from_json request.body.read
  rescue ArgumentError => e
    halt 400, { "message" => e.message }.to_json
  end
end

get "/user" do
  Context.user_json_marshaller.to_json Context.user_hierarchy.retrieve_user
end

get "/user/:id/subordinate" do |id|
  begin
    Context.user_json_marshaller.to_json Context.user_hierarchy.retrieve_user_subordinate id.to_i
  rescue NotFoundError => e
    halt 404, { "message" => e.message }.to_json
  end
end
