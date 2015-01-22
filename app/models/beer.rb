class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    ratings.inject(0) { |sum, r| sum + r.score }.to_f / ratings.count
  end

  def to_s
    "#{name}, brewery: #{brewery.name}"
  end
end
