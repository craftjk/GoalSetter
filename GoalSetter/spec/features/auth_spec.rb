require 'spec_helper'

describe "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  describe "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'username', :with => "test_username"
      fill_in 'password', :with => "asdfasdf"
      click_on "Create User"
    end

    it "shows username on the homepage after signup" do
      expect(page).to have_content "test_username"
    end
  end

end

describe "logging in" do
  before(:each) do
    visit new_session_url
    fill_in 'username', :with => "test_username"
    fill_in 'password', :with => "asdfasdf"
    click_on "Sign In"
  end

  it "shows username on the homepage after login" do
    expect(page).to have_content "test_username"
  end
end

describe "logging out" do
  before(:each) do
    visit new_session_url
    fill_in 'username', :with => "test_username"
    fill_in 'password', :with => "asdfasdf"
    click_on "Sign In"
    click_on "Sign Out"
  end


  it "begins with logged out state" do
    expect(page).to have_button?("Sign In")
  end

  it "doesn't show username on the homepage after logout" do
    expect(page).not_to have_content('test_username')
  end
end