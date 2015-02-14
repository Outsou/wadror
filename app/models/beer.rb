class Beer < ActiveRecord::Base
  include RatingAverage

  validates :name, :style, presence: true

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user

  def to_s
    "#{name}, brewery: #{brewery.name}"
  end
end
