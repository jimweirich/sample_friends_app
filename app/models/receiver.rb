class Receiver < ActiveRecord::Base
  belongs_to :message
  belongs_to :user
  attr_accessible :user
end
