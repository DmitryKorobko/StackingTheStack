require_relative 'features_helper'

feature 'Delete answer', %(
  In order to delete my answers
  As an authenticated user
  I want to be able to delete answers
) do
  given(:user) { create(:user) }
  given(:user_2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Authenticated user deletes his answer' do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      expect(page).to have_content 'MyAnswer'
      expect(page).to have_link 'Delete'
    end
  end

  scenario 'Authenticated user try to deletes question of other user' do
    sign_in(user_2)
    visit question_path(question)

    expect(page).to_not have_link 'Delete'
  end

  scenario 'Non-authenticated user try to deletes question' do
    visit question_path(question)

    expect(page).to_not have_link 'Delete'
  end
end