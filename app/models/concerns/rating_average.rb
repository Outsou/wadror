module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    a_rating = ratings.inject(0) { |sum, r| sum + r.score }.to_f / ratings.count
    return 0.to_f if a_rating.nan?
    a_rating
  end
end