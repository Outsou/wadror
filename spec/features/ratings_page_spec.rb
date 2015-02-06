require 'rails_helper'

describe "Ratings page" do
  it "should not have any before been created" do
    visit ratings_path
    expect(page).to have_content 'List of ratings'
    expect(page).to have_content 'Number of ratings: 0'
  end

  describe "when ratings exist" do
    it "lists the existing ratings and their total number" do
      user = FactoryGirl.create(:user)
      beer1 = FactoryGirl.create(:beer, name:"Beer1")
      beer2 = FactoryGirl.create(:beer, name:"Beer2")

      ratings = [ [beer1, 20], [beer2, 10], [beer1, 30] ]

      ratings.each do |rating|
        FactoryGirl.create(:rating, beer:rating[0], score:rating[1], user:user)
      end

      visit ratings_path


      expect(page).to have_content "Number of ratings: #{ratings.count}"
      ratings.each do |rating|
        expect(page).to have_content rating[0].name
      end

    end
  end

end