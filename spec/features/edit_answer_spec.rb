require_relative 'features_helper'

feature 'Answer editing', %(
  In order to fix mistake
  As an author of answer
  I want to be able to to edit my answer
) do
  given(:user) { create(:user) }
  given(:user_2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Unauthenticated user try to edit answer' do
    visit question_path(question)

    expect(page).to_not have_link('Edit')
  end

  describe 'Authenticated user' do

    scenario 'try to edit his answer', js: true do
      sign_in(user)
      visit question_path(question)
      click_on 'Edit'
      within '.answers' do
        fill_in 'Answer', with: 'Edited answer'
        click_on 'Save'
        expect(page).to_not have_content answer.body
        expect(page).to have_content'Edited answer'
        expect(page).to_not have_selector'textarea'
      end
    end

    scenario 'sees link to Edit' do
      sign_in(user)
      visit question_path(question)
      within '.answers' do
        expect(page).to have_link'Edit'
      end
    end

    scenario 'try to edit answer of other user' do
      sign_in(user_2)
      visit question_path(question)

      expect(page).to_not have_link'Edit'
    end
  end
end