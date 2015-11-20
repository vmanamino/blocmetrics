require 'rails_helper'

describe Event do
  it { should belong_to(:registered_application) }
  it { should validate_presence_of(:name) }
end
