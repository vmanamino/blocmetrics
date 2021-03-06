class Event < ActiveRecord::Base
  belongs_to :registered_application

  validates :name, presence: true
  validates :registered_application, presence: { message: "can\'t be blank" }
end
