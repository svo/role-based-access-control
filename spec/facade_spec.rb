# frozen_string_literal: true

require "facade"
require "rspec"
require "rack/test"
require "user_hierarchy"
require "marshaller/role_json_marshaller"
require "model/role"

RSpec.describe "Facade" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "creates roles" do
    json = '{"Id":1,"Name":"System Administrator","Parent":0}'
    marshaller = double(RoleJsonMarshaller)
    user_hierarchy = double(UserHiearchy)
    role = double(Role)

    allow(Facade).to receive(:role_json_marshaller).and_return(marshaller)
    allow(marshaller).to receive(:from_json).with(json).and_return([role])
    allow(Facade).to receive(:user_hierarchy).and_return(user_hierarchy)
    allow(user_hierarchy).to receive(:create_role).with([role])

    post "/create-role", json

    expect(last_response).to be_ok
  end
end
