require 'rails_helper'

describe Person do
  context 'When colling gender instance functions' do
    let!(:female_1) { FactoryGirl.create(:woman)}
    let!(:female_2) { FactoryGirl.create(:woman)}
    let!(:male_1) { FactoryGirl.create(:man)}
    let!(:female_3) { FactoryGirl.create(:woman)}
    let!(:male_2) { FactoryGirl.create(:man)}

    describe '#male' do
      it 'should return proper records' do
        expect(described_class.male).to eq [male_1, male_2]
      end
    end

    describe '#female' do
      it 'should return proper records' do
        expect(described_class.female).to eq [ female_1, female_2, female_3 ]
      end
    end
  end
end
