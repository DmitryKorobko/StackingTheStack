require_relative 'features_helper'

feature 'Favorite answer', %(
  In order to set answer as favorite
  As an question author
  I want to be able to change favorite answer
) do
  given(:user) { create(:user) }
  given(:user_2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user_2) }

  scenario 'Author of question changes favorite answer' do
    sign_in(user)
    visit question_path(question)

    click_on 'Set as favorite'

    expect(current_path).to eq question_path(question)
    within '.favorite' do
      expect(page).to have_content answer.body
    end
  end

  scenario 'Authenticated user, but not questions author try to change favorite answer' do
    sign_in(user_2)
    visit question_path(question)

    expect(page).to_not have_link 'Set as favorite'
  end

  scenario 'Non-authenticated user try to change favorite answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Set as favorite'
  end
end