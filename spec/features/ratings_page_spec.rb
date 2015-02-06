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

      ratings = create_ratings(user)

      visit ratings_path


      expect(page).to have_content "Number of ratings: #{ratings.count}"
      ratings.each do |rating|
        expect(page).to have_content rating[0].name
      end

    end
  end

end