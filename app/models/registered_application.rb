class RegisteredApplication < ActiveRecord::Base
  scope :visible_to, -> (user) { where(user_id: user.id) }

  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true
end
