class User < ActiveRecord::Base
  attr_accessible :name

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :acquaintanceships, class_name: "Friendship", foreign_key: :friend_id, dependent: :destroy
  has_many :acquaintances, through: :acquaintanceships, source: :user

  def self.active_users
    order(:name)
  end

  def add_friend(friend)
    if friends.include?(friend)
      false
    else
      friendships.create(friend: friend)
    end
  end

end
