class User < ActiveRecord::Base
  attr_accessible :name

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, order: "users.name"

  has_many :acquaintanceships, class_name: "Friendship", foreign_key: :friend_id, dependent: :destroy
  has_many :acquaintances, through: :acquaintanceships, source: :user, order: "users.name"

  has_many :messages, dependent: :destroy
  has_many :receivers, dependent: :destroy
  has_many :all_incoming_messages, through: :receivers, source: :message

  def incoming_messages
    all_incoming_messages.where("messages.user_id in (?)", friends)
  end

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

  def friendship_for(other)
    friendships.where("friend_id = ?", other)
  end

end
