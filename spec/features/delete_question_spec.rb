require_relative 'features_helper'

feature 'Create question', %(
  In order to delete my questions
  As an authenticated user
  I want to be able to delete question
) do

  given(:user) { create(:user) }
  given(:user_2) { create(:user) }
  given!(:question) { create(:question, user: user) }

  before do
    visit questions_path
  end

  scenario 'Authenticated user deletes his question' do
    sign_in(user)

    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Text text text'
    click_on 'Create'

    visit questions_path

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
