class User < ActiveRecord::Base
  attr_accessible :name

  def self.active_users
    order(:name)
  end

end
