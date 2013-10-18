require 'spec_helper'
require '../controllers/s'



# Start with the integration tests for the 'goals' feature.
# Users should be able to CRUD (create, read, update, and delete) their goals.
# Goals can be private or public - other users should not see 'private' goals,
# but a user should see all of their own goals.

describe "the goal creation process" do


  it "requires a signed-in user" do
    visit new_goal_url
    expect(page).to have_button "Sign In"
  end

  it "shows the goal details after creation of goal" do
    create_test_user
    create_public_first_goal
    expect(page).to have_content "pass this test"
  end

end

describe "the goal index page" do
  before (:each) do
    create_test_user
    create_public_first_goal
    create_private_second_goal
    click_button 'Show All Goals'
  end

  it "should show the first (public) goal" do
    expect(page).to have_content "pass this test"
  end

  it "should show the second (private) goal" do
    expect(page).to have_content "pass this private test"
  end

  context "when signed in as a different user" do
    before (:each) do
      click_button 'Sign Out'
      create_test_user2
      visit users_url
      click_on 'test_username'
    end

    it "should not show private goals to other users" do
      expect(page).not_to have_content "pass this private test"
    end

    it "should show public goals to other users" do
      expect(page).not_to have_content "pass this private test"
    end
  end
end

describe "the goal update process" do

  it "should allow user to update goal objective"

  it "should allow user to update goal privacy"

  it "should allow user to update goal status"

end









def create_test_user
  visit new_user_url
  fill_in 'username', :with => "test_username"
  fill_in 'password', :with => "asdfasdf"
  click_on "Create User"
end

def create_test_user2
  visit new_user_url
  fill_in 'username', :with => "test2_username"
  fill_in 'password', :with => "asdfasdf"
  click_on "Create User"
end


def sign_in_test_user
  visit new_session_url
  fill_in 'username', :with => "test_username"
  fill_in 'password', :with => "asdfasdf"
  click_on "Log In"
end

def create_public_first_goal
  visit new_goal_url
  fill_in 'objective', :with => "pass this test"
  choose 'public'
  click_button "Create Goal"
end

def create_private_second_goal
  visit new_goal_url
  fill_in 'objective', :with => "pass this private test"
  choose 'private'
  click_button "Create Goal"
end
