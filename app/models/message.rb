class Message < ActiveRecord::Base
  attr_accessible :body, :from

  belongs_to :user
  has_many :receivers, dependent: :destroy
  has_many :recipients, through: :receivers, source: :user
end
