require_relative 'features_helper'

feature 'Create question', %(
  In order to get answer from comunity
  As an authenticated user
  I want to be able to ask question
) do

  given(:user) { create(:user) }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Text text text'
    click_on 'Create'

    expect(page).to have_content 'Test question'
  end

  scenario 'Non-authenticated user creates question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end
