require 'rails_helper'

describe "Ratings page" do

  describe "when ratings exist" do
    it "lists the existing ratings" do
      user = FactoryGirl.create(:user)

      ratings = create_ratings(user)

      visit ratings_path
      
      ratings.each do |rating|
        expect(page).to have_content rating.beer.name
      end

    end
  end

end