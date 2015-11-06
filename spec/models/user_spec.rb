require 'rails_helper'

describe User do
  it { should have_many(:registered_applications).dependent(:destroy) }
end
