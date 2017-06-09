require 'rails_helper'

describe 'when visiting root page' do
  let!(:male_1) { create(:man, height: 180, weight: 85)}
  let!(:male_2) { create(:man, height: 190, weight: 90)}
  let!(:female_1) { create(:woman, height: 160, weight: 50)}

  it 'should see List of People headline' do
    visit root_path

    expect(page).to have_content 'List of People'
  end

  it 'should contain list of people' do
    visit root_path

    expect(page).to have_selector('table tr', count: 4)
    expect(find_all('tr').last.text).to match female_1.gender
  end
end