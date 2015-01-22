class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    ratings.map! { |r| r.score }.inject { |sum, r| sum + r }.to_f / ratings.count
  end
end
