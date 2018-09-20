require 'rails_helper'

RSpec.describe UserToAnswerRating, type: :model do
  it { should validate_presence_of :answer_id }
  it { should validate_presence_of :user_id }
end
