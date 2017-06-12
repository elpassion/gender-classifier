require 'rails_helper'

describe 'User delete person' do
  let!(:male_1) { create(:man, height: 180, weight: 85)}
  let!(:male_2) { create(:man, height: 190, weight: 90)}
  let!(:female_1) { create(:woman, height: 160, weight: 50)}

  context 'within people path' do
    before { visit people_path }

    it 'should contains delete links' do
      expect(page).to have_link 'Delete',  href: person_path(female_1.id)
      expect(page).to have_link 'Delete',  href: person_path(male_2.id)
    end

    it 'should move to edit people path' do
      expect {
        click_link 'Delete',  href: person_path(female_1.id)
      }.to change{ Person.count }.by(-1)
    end

    it 'should redirect to people path' do
      click_link 'Delete',  href: person_path(female_1.id)
      expect(page).to have_current_path people_path
    end
  end
end
