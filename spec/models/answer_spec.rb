require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should belong_to :user }
  it { should have_many :attachments }
  it { should have_one :answer_rating }

  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :attachments }

  describe 'reputation' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }
    subject { build(:answer, user: user, question: question) }

    it_behaves_like 'calculates reputation'
  end
end
