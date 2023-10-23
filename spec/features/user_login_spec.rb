require "rails_helper"

RSpec.describe "User Login", type: :feature do
  it "I can input my correct unique email and password and am taken to my dashboard page" do
    user = User.create(name: 'User One', email: 'notunique@example.com', password: "1234")
    visit login_path

    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_button("Log In")

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Log In"

    expect(current_path).to eq("/users/#{user.id}")
  end

  it "gives me a flash message letting me know my credentials are incorrect and takes me back to the log in page" do
    user = User.create(name: 'User One', email: 'notunique@example.com', password: "1234")

    visit(login_path)

    fill_in :email, with: "notcorrect@example.com"
    fill_in :password, with: user.password
    click_button "Log In"
    expect(current_path).to eq(login_path)
    expect(page).to have_content("Sorry, your credentials are incorrect.")

    fill_in :email, with: user.email
    fill_in :password, with: "5678"
    click_button "Log In"
    expect(current_path).to eq(login_path)
    expect(page).to have_content("Sorry, your credentials are incorrect.")
  end
end