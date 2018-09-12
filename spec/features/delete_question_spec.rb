require_relative 'features_helper'

feature 'Create question', %(
  In order to delete my questions
  As an authenticated user
  I want to be able to delete question
) do

  given(:user) { create(:user) }
  given(:user_2) { create(:user) }
  given!(:question) { create(:question, user: user) }

  describe 'From questions list' do
    before do
      question.reload
      visit questions_path
    end

    scenario 'Authenticated user deletes his question' do
      sign_in(user)

      expect(page).to have_link 'Delete'
    end

    scenario 'Authenticated user try to deletes question of other user' do
      sign_in(user_2)

      expect(page).to_not have_link 'Delete'
    end

    scenario 'Non-authenticated user try to deletes question' do
      expect(page).to_not have_link 'Delete'
    end
  end

  describe 'From question path' do
    before do
      question.reload
      visit question_path(question)
    end

    scenario 'Authenticated user deletes his question' do
      sign_in(user)

      visit question_path(question)

      expect(page).to have_link 'Delete question'
    end

    scenario 'Authenticated user try to deletes question of other user' do
      sign_in(user_2)

      visit question_path(question)

      expect(page).to_not have_link 'Delete question'
    end

    scenario 'Non-authenticated user try to deletes question' do
      expect(page).to_not have_link 'Delete question'
    end
  end
end
