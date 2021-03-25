# frozen_string_literal: true

require "facade"
require "rack/test"

RSpec.describe "Facade" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "role" do
    it "creates roles" do
      json = '{"Id":1,"Name":"System Administrator","Parent":0}'
      marshaller = double(RoleJsonMarshaller)
      user_hierarchy = double(UserHierarchy)
      role = double

      expect(Facade).to receive(:role_json_marshaller).and_return(marshaller)
      expect(marshaller).to receive(:from_json).with(json).and_return([role])
      expect(Facade).to receive(:user_hierarchy).and_return(user_hierarchy)
      expect(user_hierarchy).to receive(:create_role).with([role])

      post "/role", json

      expect(last_response).to be_ok
    end

    it "is a bad request if ArgumentError" do
      json = '{"Id":1,"Name":"System Administrator"}'
      error = "coconuts"
      error_json = '{"message":"coconuts"}'
      marshaller = double(RoleJsonMarshaller)

      expect(Facade).to receive(:role_json_marshaller).and_return(marshaller)
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

      expect(Facade).to receive(:role_json_marshaller).and_return(marshaller)
      expect(marshaller).to receive(:to_json).with([role]).and_return(json)
      expect(Facade).to receive(:user_hierarchy).and_return(user_hierarchy)
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

      expect(Facade).to receive(:user_json_marshaller).and_return(marshaller)
      expect(marshaller).to receive(:from_json).with(json).and_return([user])
      expect(Facade).to receive(:user_hierarchy).and_return(user_hierarchy)
      expect(user_hierarchy).to receive(:create_user).with([user])

      post "/user", json

      expect(last_response).to be_ok
    end

    it "is a bad request if ArgumentError" do
      json = '[{"Id":1,"Name":"Adam Admin","Role":1}]'
      error = "coconuts"
      error_json = '{"message":"coconuts"}'
      marshaller = double(UserJsonMarshaller)

      expect(Facade).to receive(:user_json_marshaller).and_return(marshaller)
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

      expect(Facade).to receive(:user_json_marshaller).and_return(marshaller)
      expect(marshaller).to receive(:to_json).with([user]).and_return(json)
      expect(Facade).to receive(:user_hierarchy).and_return(user_hierarchy)
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

        expect(Facade).to receive(:user_json_marshaller).and_return(marshaller)
        expect(marshaller).to receive(:to_json).with([user]).and_return(json)
        expect(Facade).to receive(:user_hierarchy).and_return(user_hierarchy)
        expect(user_hierarchy).to receive(:retrieve_user_subordinate).and_return([user])

        get "/user/1/subordinate"

        expect(last_response).to be_ok
        expect(last_response.body).to eq(json)
      end

      it "is not found if NotFoundError" do
        error = "coconuts"
        error_json = '{"message":"coconuts"}'
        user_hierarchy = double(UserHierarchy)
        expect(Facade).to receive(:user_hierarchy).and_return(user_hierarchy)
        expect(user_hierarchy).to receive(:retrieve_user_subordinate).and_raise(NotFoundError, error)

        get "/user/1/subordinate"

        expect(last_response).to be_not_found
        expect(last_response.body).to eq(error_json)
      end
    end
  end
end
