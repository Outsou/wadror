require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved, if name and style have been set" do
    beer = Beer.create name:"testname", style:"teststyle"

    expect(beer.name).to eq("testname")
    expect(beer.style).to eq("teststyle")
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name" do
    beer = Beer.create style:"teststyle"

    expect(beer).to_not be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"testname"

    expect(beer).to_not be_valid
    expect(Beer.count).to eq(0)
  end
end
