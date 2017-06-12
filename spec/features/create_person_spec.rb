require 'rails_helper'

describe 'User create new test person' do
  context 'When uploading valid data' do
    before do
      visit new_person_path

      fill_in 'Height', with: 155
      fill_in 'Weight', with: 58
      select 'female', from: 'Gender'
    end

    it 'should redirect to people path' do
      click_button 'Create Person'

      expect(page).to have_current_path people_path
    end

    it 'should create record' do
      expect { click_button 'Create Person' }.to change { Person.count }.by(1)
    end
  end

  context 'When uploading invalid data' do
    before do
      visit new_person_path

      fill_in 'Height', with: 155
      select 'female', from: 'Gender'
    end

    it 'should render new' do
      click_button 'Create Person'

      expect(page).to have_current_path people_path
    end

    it 'should not create record' do
      expect { click_button 'Create Person' }.not_to change { Person.count }
    end

    it 'should display proper error message' do
      click_button 'Create Person'

      expect(page).to have_content "Weight can't be blank"
    end
  end

  context 'within people path' do
    before { visit people_path }

    it 'should contain new person link' do
      expect(page).to have_link 'New person', href: new_person_path
    end

    it 'clicking New person link should move to new person path' do
      click_link 'New person'

      expect(page).to have_current_path new_person_path
    end
  end
end
