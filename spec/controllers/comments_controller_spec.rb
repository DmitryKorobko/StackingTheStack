require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  sign_in_user

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }

  describe 'POST #create' do
    it 'loads question if parent is question' do
      post :create, params: { comment: attributes_for(:comment), question_id: question, format: :js }
      expect(assigns(:parent)).to eq(question)
    end

    it 'loads answer if parent is answer' do
      post :create, params: { comment: attributes_for(:comment), answer_id: answer, format: :js }
      expect(assigns(:parent)).to eq(answer)
    end
  end
end
