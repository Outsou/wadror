class Beer < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true

  belongs_to :brewery, touch: true
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user

  def to_s
    "#{name}, brewery: #{brewery.name}"
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) }.first(n)
  end
end
