require "rails_helper"

RSpec.describe "Logout" do
  it "should see the log out button when logged in and not the log in or create user button, and should see those buttons again after hitting log out" do
    user1 = User.create(name: "User One", email: "user1@test.com", password: "1234")

    visit login_path

    fill_in :email, with: user1.email
    fill_in :password, with: user1.password
    click_button "Log In"

    visit root_path

    expect(page).to have_button("Log Out")
    expect(page).not_to have_link("Log In")
    expect(page).not_to have_button("Create New User")

    click_button "Log Out"

    expect(page).to_not have_button("Log Out")
    expect(page).to have_link("Log In")
    expect(page).to have_button("Create New User")
  end
end