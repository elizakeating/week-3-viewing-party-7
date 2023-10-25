require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: "1234")
    user2 = User.create(name: "User Two", email: "user2@test.com", password: "5678")
    visit '/'
  end 

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    click_button "Create New User"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  it 'lists out existing users if you are logged in' do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: "1234")
    user2 = User.create(name: "User Two", email: "user2@test.com", password: "5678")

    visit login_path

    fill_in :email, with: user1.email
    fill_in :password, with: user1.password
    click_button "Log In"
    
    visit root_path

    expect(page).to have_content('Existing Users:')

    within('.existing-users') do 
      expect(page).to have_content(user1.email)
      expect(page).to have_content(user2.email)
    end     
  end 

  it "has a link for log in that takes you to the log in page /login" do
    expect(page).to have_link "Log In"

    click_link "Log In"

    expect(current_path).to eq("/login")
  end

  it "i should not see the section of the page that lists users if i am a visitor" do
    user1 = User.create(name: "User One", email: "user1@test.com")
    user2 = User.create(name: "User Two", email: "user2@test.com")

    visit root_path

    expect(page).to_not have_content("Existing Users:")
    expect(page).to_not have_content(user1.email)
    expect(page).to_not have_content(user2.email)
  end
  
  it "redirects a vistor back to the landing page with a message if they try to go to a dashboard" do
    user1 = User.create(name: "User One", email: "user1@test.com")
    user2 = User.create(name: "User Two", email: "user2@test.com")

    visit root_path

    visit "/users/1"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You must be logged in or registered to access the dashboard")
  end
end
