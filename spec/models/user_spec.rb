require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a too short password" do
    user = User.create username:"Pekka", password:"S1", password_confirmation:"S1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password that has letters only" do
    user = User.create username:"Pekka", password:"Secret", password_confirmation:"Secret"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved with a proper password" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "with a proper password and two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){ FactoryGirl.create(:user) }

    it "has method for determining the favorite_beer" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)

      expect(user.favorite_beer).to eq(best)
    end
  end
  describe "favorite style" do
    let(:user){ FactoryGirl.create(:user) }

    it "has method for determining the favorite_style" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have a favorite style" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the one with highest average rating if several rated" do
      create_beers_with_ratings_and_style(1, 2, 3, user, "Test1")
      create_beers_with_ratings_and_style(1, 15, 21, user, "Best")
      create_beers_with_ratings_and_style(4, 5, 6, user, "Test3")

      expect(user.favorite_style).to eq("Best")
    end
  end
end

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating(score, user)
  end
end

def create_beers_with_ratings_and_style(*scores, user, style)
  scores.each do |score|
    create_beer_with_rating(score, user).update style:style
  end
end
