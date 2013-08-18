class Message < ActiveRecord::Base
  attr_accessible :body, :from

  belongs_to :user
  has_many :receivers, dependent: :destroy
  has_many :recipients, through: :receivers, source: :user

  def addressed_to(names)
    name_list = names.split(/,/).map { |s| s.strip }
    name_list.each do |name|
      user = User.find_by_name(name)
      receivers.new(user: user)
    end
  end
end
