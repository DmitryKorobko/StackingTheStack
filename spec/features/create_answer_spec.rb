require_relative 'features_helper'

feature 'User answer', %(
  In order to exchange my knowledges
  As an authenticated user
  I want to be able to create answers
) do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Authenticated user creates answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'My answer'
    click_on 'Create'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'My answer'
    end
  end

  scenario 'User try to create invalid answer', js: true do
    sign_in(user)
    visit question_path(question)

    click_on 'Create'

    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Non-authenticated user try creates answer', js: true do
    visit question_path(question)
    expect(page).to have_content 'Only authenticated users have opportunity to creates answers.'
  end
end