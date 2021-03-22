# frozen_string_literal: true

require "facade"
require "rack/test"

RSpec.describe "Facade" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "creates roles" do
    json = '{"Id":1,"Name":"System Administrator","Parent":0}'
    marshaller = double(RoleJsonMarshaller)
    user_hierarchy = double(UserHierarchy)
    role = double

    expect(Facade).to receive(:role_json_marshaller).and_return(marshaller)
    expect(marshaller).to receive(:from_json).with(json).and_return([role])
    expect(Facade).to receive(:user_hierarchy).and_return(user_hierarchy)
    expect(user_hierarchy).to receive(:create_role).with([role])

    post "/create-role", json

    expect(last_response).to be_ok
  end
end
