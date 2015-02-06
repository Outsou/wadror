class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true,
            length: { minimum: 3,
                      maximum: 15 }
  validates :password, length: { minimum: 4 }
  validates_format_of :password, :with => /(?=.*[A-Z])(?=.*[0-9])/

  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships

  has_secure_password

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    style_averages = get_styles.map{ |s| { style:s, average:get_style_average(s) } }

    style_averages.sort{ |left, right| left[:average] <=> right[:average] }.last[:style]
  end

  def get_styles
    ratings.map{ |r| r.beer.style }.uniq
  end

  def get_style_average(style)
    ratings_for_style = ratings.select{|r| r.beer.style == style}
    ratings_for_style.inject(0){ |sum, r| sum + r.score }.to_f / ratings_for_style.count
  end
end
