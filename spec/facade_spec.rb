# frozen_string_literal: true

require "facade"
require "rack/test"

RSpec.describe "Context" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "context" do
    it "has a role JSON marshaller" do
      expect(Context.role_json_marshaller).to be_an_instance_of(RoleJsonMarshaller)
    end

    it "has a user JSON marshaller" do
      expect(Context.user_json_marshaller).to be_an_instance_of(UserJsonMarshaller)
    end

    it "has a role repository" do
      expect(Context.role_repository).to be_an_instance_of(RoleRepository)
    end

    it "has a role domain factory" do
      expect(Context.role_domain_factory).to be_an_instance_of(RoleDomainFactory)
    end

    it "has a user repository" do
      expect(Context.user_repository).to be_an_instance_of(UserRepository)
    end

    it "has a user domain factory" do
      expect(Context.user_domain_factory).to be_an_instance_of(UserDomainFactory)
    end

    it "has a user hierarchy" do
      expect(Context.user_hierarchy).to be_an_instance_of(UserHierarchy)
    end
  end

  describe "role" do
    it "creates roles" do
      json = '{"Id":1,"Name":"System Administrator","Parent":0}'
      marshaller = double(RoleJsonMarshaller)
      user_hierarchy = double(UserHierarchy)
      role = double

      expect(Context).to receive(:role_json_marshaller).and_return(marshaller)
      expect(marshaller).to receive(:from_json).with(json).and_return([role])
      expect(Context).to receive(:user_hierarchy).and_return(user_hierarchy)
      expect(user_hierarchy).to receive(:create_role).with([role])

      post "/role", json

      expect(last_response).to be_ok
    end

    it "is a BAD REQUEST if it encounters an ArgumentError" do
      json = '{"Id":1,"Name":"System Administrator"}'
      error = "coconuts"
      error_json = '{"message":"coconuts"}'
      marshaller = double(RoleJsonMarshaller)

      expect(Context).to receive(:role_json_marshaller).and_return(marshaller)
      expect(marshaller).to receive(:from_json).with(json).and_raise(ArgumentError, error)

      post "/role", json

      expect(last_response).to be_bad_request
      expect(last_response.body).to eq(error_json)
    end

    it "retrieves roles" do
      json = '{"Id":1,"Name":"System Administrator","Parent":0}'
      marshaller = double(RoleJsonMarshaller)
      user_hierarchy = double(UserHierarchy)
      role = double

      expect(Context).to receive(:role_json_marshaller).and_return(marshaller)
      expect(marshaller).to receive(:to_json).with([role]).and_return(json)
      expect(Context).to receive(:user_hierarchy).and_return(user_hierarchy)
      expect(user_hierarchy).to receive(:retrieve_role).and_return([role])

      get "/role"

      expect(last_response).to be_ok
      expect(last_response.body).to eq(json)
    end
  end

  describe "user" do
    it "creates users" do
      json = '[{"Id":1,"Name":"Adam Admin","Role":1}]'
      marshaller = double(UserJsonMarshaller)
      user_hierarchy = double(UserHierarchy)
      user = double

      expect(Context).to receive(:user_json_marshaller).and_return(marshaller)
      expect(marshaller).to receive(:from_json).with(json).and_return([user])
      expect(Context).to receive(:user_hierarchy).and_return(user_hierarchy)
      expect(user_hierarchy).to receive(:create_user).with([user])

      post "/user", json

      expect(last_response).to be_ok
    end

    it "is a BAD REQUEST if it encounters an ArgumentError" do
      json = '[{"Id":1,"Name":"Adam Admin","Role":1}]'
      error = "coconuts"
      error_json = '{"message":"coconuts"}'
      marshaller = double(UserJsonMarshaller)

      expect(Context).to receive(:user_json_marshaller).and_return(marshaller)
      expect(marshaller).to receive(:from_json).with(json).and_raise(ArgumentError, error)

      post "/user", json

      expect(last_response).to be_bad_request
      expect(last_response.body).to eq(error_json)
    end

    it "retrieves users" do
      json = '[{"Id":1,"Name":"Adam Admin","Role":1}]'
      marshaller = double(UserJsonMarshaller)
      user_hierarchy = double(UserHierarchy)
      user = double

      expect(Context).to receive(:user_json_marshaller).and_return(marshaller)
      expect(marshaller).to receive(:to_json).with([user]).and_return(json)
      expect(Context).to receive(:user_hierarchy).and_return(user_hierarchy)
      expect(user_hierarchy).to receive(:retrieve_user).and_return([user])

      get "/user"

      expect(last_response).to be_ok
      expect(last_response.body).to eq(json)
    end

    describe "subordinate" do
      it "retrieves subordinate for user" do
        json = '{"Id":1,"Name":"System Administrator","Parent":0}'
        marshaller = double(UserJsonMarshaller)
        user_hierarchy = double(UserHierarchy)
        user = double

        expect(Context).to receive(:user_json_marshaller).and_return(marshaller)
        expect(marshaller).to receive(:to_json).with([user]).and_return(json)
        expect(Context).to receive(:user_hierarchy).and_return(user_hierarchy)
        expect(user_hierarchy).to receive(:retrieve_user_subordinate).and_return([user])

        get "/user/1/subordinate"

        expect(last_response).to be_ok
        expect(last_response.body).to eq(json)
      end

      it "is NOT FOUND if it encounters a NotFoundError" do
        error = "coconuts"
        error_json = '{"message":"coconuts"}'
        user_hierarchy = double(UserHierarchy)
        expect(Context).to receive(:user_hierarchy).and_return(user_hierarchy)
        expect(user_hierarchy).to receive(:retrieve_user_subordinate).and_raise(NotFoundError, error)

        get "/user/1/subordinate"

        expect(last_response).to be_not_found
        expect(last_response.body).to eq(error_json)
      end
    end
  end
end
