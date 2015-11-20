class RegisteredApplication < ActiveRecord::Base
  scope :visible_to, -> (user) { where(user_id: user.id) }

  belongs_to :user
  has_many :events, dependent: :destroy

  validates :name, presence: true
  validates :url, presence: true
  validates :url, uniqueness: true

  def count_events
    events = self.events.group_by(&:name)
    each_event = Hash.new(0)
    events.each do |key, _value|
      each_event[key] = events[key].count
    end
    each_event
  end
end
