require 'rails_helper'

RSpec.describe AnswerRating, type: :model do
  it { should belong_to :answer }
  it { should validate_presence_of :answer_id }
end
