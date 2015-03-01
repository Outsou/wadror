class BeerClub < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  has_many :confirmed_memberships, -> { where confirmed: true },
      class_name: "Membership"

  has_many :unconfirmed_memberships, -> { where confirmed: [nil, false] },
           class_name: "Membership"
end
