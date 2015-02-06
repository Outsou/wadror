require 'rails_helper'

describe "User" do
  before :each do
    @user = FactoryGirl.create(:user)
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'wb bro'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrung")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password nope'
    end
  end

  describe "who is signed in" do
    before :each do
      sign_in(username:"Pekka", password:"Foobar1")

      @ratings = create_ratings(@user)
    end

    it "can see own ratings in user page" do
      visit user_path(@user)
      @ratings.each do |rating|
        expect(page).to have_content "#{rating[0].name} #{rating[1]}"
      end
    end

    it "can't see other users' ratings on user page" do
      user2 = FactoryGirl.create(:user, username:"Pekka2")
      rating = FactoryGirl.create(:rating, beer:@ratings[0][0], score:@ratings[0][1]+1, user:user2)

      visit user_path(@user)

      expect(page).to_not have_content "#{rating.beer.name} #{rating.score}"
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
end