class Style < ActiveRecord::Base
  include RatingAverage

  has_many :beers
  has_many :ratings, through: :beers

  def to_s
    self.style
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |r| -(r.average_rating||0) }.first(n)
  end
end
