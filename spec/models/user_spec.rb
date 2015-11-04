require 'rails_helper'

describe User do
#   before do
#     @user = create(:user)
#   end
  it { should have_many(:registered_applications).dependent(:destroy) }
end