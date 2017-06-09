require 'rails_helper'

describe 'User create new test person' do
  let!(:male_1) { create(:man, height: 180, weight: 85)}
  let!(:male_2) { create(:man, height: 190, weight: 90)}
  let!(:female_1) { create(:woman, height: 160, weight: 50)}

  context 'within people path' do
    before do
      visit people_path
    end

    it 'should contains edit links' do
      expect(page).to have_link 'Edit',  href: edit_person_path(female_1.id)
      expect(page).to have_link 'Edit',  href: edit_person_path(male_2.id)
    end

    it 'should move to edit people path' do
      click_link 'Edit',  href: edit_person_path(female_1.id)

      expect(page).to have_current_path edit_person_path(female_1.id)
    end
  end

  context 'within edit person path' do
    before do
      visit edit_person_path(male_2.id)
    end

    context 'with valid data' do
      it 'should update person data' do
        fill_in 'Height', with: 187

        expect { click_button 'Update Person' }.to change {
          Person.find(male_2.id).height
        }.from(190).to(187)
      end

      it 'should redirect to people path' do
        click_button 'Update Person'

        expect(page).to have_current_path people_path
      end
    end
  end
end