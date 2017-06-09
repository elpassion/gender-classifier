require 'rails_helper'

describe 'User create new test person' do
  context 'When uploading valid data' do
    before do
      visit new_person_path

      fill_in 'Height', with: 155
      fill_in 'Weight', with: 58
      select 'female', from: 'Gender'
    end

    it 'should redirect to root path' do
      click_button 'Create Person'

      expect(page).to have_current_path root_path
    end

    it 'should create record' do
      expect { click_button 'Create Person' }.to change { Person.count }.by(1)
    end
  end
end