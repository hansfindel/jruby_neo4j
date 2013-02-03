require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :username => "MyString",
      :email => "MyString",
      :password_hash => "MyString",
      :password_salt => "MyString",
      :pending_account => false
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
      assert_select "input#user_username", :name => "user[username]"
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_password_hash", :name => "user[password_hash]"
      assert_select "input#user_password_salt", :name => "user[password_salt]"
      assert_select "input#user_pending_account", :name => "user[pending_account]"
    end
  end
end
