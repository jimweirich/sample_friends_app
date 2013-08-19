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

  def incoming_messages_by_sql
    sql = %{
SELECT messages.* FROM messages
  JOIN receivers   ON receivers.message_id = messages.id
  JOIN friendships ON friendships.friend_id = messages.user_id
 WHERE receivers.user_id = ? AND friendships.user_id = ?;
}
    Message.find_by_sql([sql, id, id])
  end

  def incoming_messages_by_ar
    all_incoming_messages.
      joins("JOIN friendships ON friendships.friend_id = messages.user_id").
      where("friendships.user_id = ?", id)
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
