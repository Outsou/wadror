class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def average_rating
    ratings.inject(0) { |sum, r| sum + r.score }.to_f / ratings.count
  end
end
