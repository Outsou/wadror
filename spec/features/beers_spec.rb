require 'rails_helper'

describe "Beer" do
  it "is added, if name is valid" do
    visit new_beer_path
    fill_in("beer_name", with:"Kalija")

    expect {
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "is not added, if name is not valid" do
    visit new_beer_path
    fill_in("beer_name", with:"")

    click_button "Create Beer"
    expect(Beer.count).to eq(0)
    expect(page).to have_content "Name can't be blank"
  end
end