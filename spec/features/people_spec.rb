require 'rails_helper'

describe 'when visiting people page' do
  let!(:male_1) { create(:man, height: 180, weight: 85)}
  let!(:male_2) { create(:man, height: 190, weight: 90)}
  let!(:female_1) { create(:woman, height: 160, weight: 50)}

  context 'within root path' do
    before { visit root_path }

    it 'should contain test data link' do
      expect(page).to have_link 'Test data', href: people_path
    end

    it 'should move to people path' do
      click_link 'Test data'
      expect(page).to have_current_path people_path
    end
  end

  context 'within people path' do
    before { visit people_path }

    it 'should see List of People headline' do
      expect(page).to have_content 'List of People'
    end

    it 'should contain list of people' do
      expect(page).to have_selector('table tr', count: 4)
      expect(find_all('tr').last.text).to match female_1.gender
    end
  end
end
