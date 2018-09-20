require_relative 'features_helper'

feature 'Add rating for answer', %(
  In order to illustrate my answer
  As an author of answer
  I want to be able to add rating for answers
) do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Authenticated user adds rating up for answer', js: true do
    # fill_in 'Your answer', with: 'My answer'
    # click_on 'Create'
    # visit question_path(question)
    # click_link("up-rating-#{answer.id}")
    # visit question_path(question)
    #
    # within '.rating' do
    #   expect(page).to have_content '1'
    # end
  end

  scenario 'Authenticated user adds rating down for answer', js: true do
    # fill_in 'Your answer', with: 'My answer'
    # click_on 'Create'
    # visit question_path(question)
    # click_link("up-rating-#{answer.id}")
    # visit question_path(question)
    #
    # within '.rating' do
    #   expect(page).to have_content '-1'
    # end
  end
end
