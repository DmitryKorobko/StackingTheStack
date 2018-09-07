require_relative 'features_helper'

feature 'Watch question', %(
  In order to get list of existing questions
  As an authenticated or non-authenticated user
  I want to be able to watch questions list
) do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  before do
    visit questions_path
  end

  scenario 'Authenticated user try to watch questions' do
    sign_in(user)
    expect(page).to have_link question.title
  end

  scenario 'Non-authenticated user try to watch questions' do
    expect(page).to have_link question.title
  end
end
