require 'rails_helper'

describe 'when visiting root page' do
  let!(:male_1) { create(:man, height: 180, weight: 85)}
  let!(:male_2) { create(:man, height: 190, weight: 90)}
  let!(:male_3) { create(:man, height: 175, weight: 80)}
  let!(:male_4) { create(:man, height: 178, weight: 70)}
  let!(:female_1) { create(:woman, height: 160, weight: 50)}
  let!(:female_2) { create(:woman, height: 155, weight: 52)}
  let!(:female_3) { create(:woman, height: 175, weight: 70)}
  let!(:female_4) { create(:woman, height: 170, weight: 65)}

  before { visit root_path }

  it 'should see List of People headline' do
    expect(page).to have_content 'Gender Classifier'
  end

  context 'With valid data' do
    context 'When input mans-like params' do
      it 'should return male gender' do
        fill_in 'Weight', with: 90
        fill_in 'Height', with: 187

        click_button 'Predict Gender'
        expect(page).to have_content 'male'
      end
    end

    context 'When input womens-like params' do
      it 'should return male gender' do
        fill_in 'Weight', with: 50
        fill_in 'Height', with: 155

        click_button 'Predict Gender'
        expect(page).to have_content 'female'
      end
    end
  end

  context 'with invalid data' do
    it 'should display error' do
      fill_in 'Weight', with: 0
      fill_in 'Height', with: nil

      click_button 'Predict Gender'
      expect(page).to have_content 'Weight must be greater than 0, Height must be greater than 0'
    end
  end
end
