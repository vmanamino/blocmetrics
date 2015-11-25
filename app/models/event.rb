class Event < ActiveRecord::Base
  belongs_to :registered_application

  validates :name, presence: true
  validates :registered_application, presence: { message: 'missing' }
#   validate :url_is_registered

#   def url_is_registered
#     errors.add(:registered_application_id, 'The app for your event must first be registered') unless registered_application_id.any?
#   end
end
