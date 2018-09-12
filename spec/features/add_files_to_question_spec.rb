require_relative 'features_helper'

feature 'Add files to question', %(
  In order to illustrate my question
  As an author of question
  I want to be able to attach files
) do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds file when asks question' do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Text text text'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

  scenario 'User adds many files when asks question' do
    click_on 'Add file'
    within('div#attachments') do
      expect(page).to have_xpath("./div", count: 2)
    end
  end
end
