class Membership < ActiveRecord::Base
  validate :user_already_member

  belongs_to :user
  belongs_to :beer_club

  def user_already_member
    if not Membership.find_by(user_id:user_id, beer_club_id:beer_club_id).nil?
      errors.add(:base, "You are a member of this club already.")
    end
  end
end
