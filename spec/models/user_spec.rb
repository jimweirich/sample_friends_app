require 'spec_helper'

describe User do
  def make_user(name)
    User.create!(name: name)
  end

  def make_friend(name, me)
    friend = make_user(name)
    me.friendships.create!(friend: friend)
    friend
  end

  def make_message(from, to, body)
    msg = from.messages.create!(body: body)
    msg.receivers.create!(user: to)
    msg
  end

  describe "Incoming Messages" do
    Given(:me)          { make_user("Me") }
    Given(:friend)      { make_friend("Friend", me) }
    Given(:other)       { make_user("Other") }
    Given!(:seen_msg)   { make_message(friend, me, "Hi") }
    Given!(:unseen_msg) { make_message(other,  me, "Hello") }

    Then { me.incoming_messages == [seen_msg] }
    Then { me.incoming_messages_by_sql == [seen_msg] }
    Then { me.incoming_messages_by_ar == [seen_msg] }
  end

end
