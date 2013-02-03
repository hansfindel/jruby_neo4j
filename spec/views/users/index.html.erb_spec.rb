require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :username => "Username",
        :email => "Email",
        :password_hash => "Password Hash",
        :password_salt => "Password Salt",
        :pending_account => false
      ),
      stub_model(User,
        :username => "Username",
        :email => "Email",
        :password_hash => "Password Hash",
        :password_salt => "Password Salt",
        :pending_account => false
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Username".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Password Hash".to_s, :count => 2
    assert_select "tr>td", :text => "Password Salt".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
