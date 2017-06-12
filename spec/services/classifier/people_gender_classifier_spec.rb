require 'rails_helper'

describe Classifier::PeopleGenderClassifier do
  let!(:male_1) { create(:man, height: 180, weight: 85)}
  let!(:male_2) { create(:man, height: 190, weight: 90)}
  let!(:male_3) { create(:man, height: 175, weight: 80)}
  let!(:male_4) { create(:man, height: 178, weight: 70)}
  let!(:female_1) { create(:woman, height: 160, weight: 50)}
  let!(:female_2) { create(:woman, height: 155, weight: 52)}
  let!(:female_3) { create(:woman, height: 175, weight: 70)}
  let!(:female_4) { create(:woman, height: 170, weight: 65)}

  describe '#classify' do
    context 'with valid data' do
      it "should receive male when man's data given" do
        subject = described_class.new(weight: 80, height: 180)
        expect(subject.classify).to eq 'male'
      end
      it "should receive male when another man's data given" do
        subject = described_class.new(weight: 75, height: 178)
        expect(subject.classify).to eq 'male'
      end

      it "should receive female when woman's data given" do
        subject = described_class.new(weight: 50, height: 160)
        expect(subject.classify).to eq 'female'
      end
      it "should receive female when another woman's data given" do
        subject = described_class.new(weight: 60, height: 164)
        expect(subject.classify).to eq 'female'
      end
    end

    context 'with invalid data' do
      it 'should raise error when weight or height are empty' do
        subject = described_class.new(weight: nil, height: nil)
        expect{ subject.classify }.to raise_error(Classifier::InvalidInput, /Weight is not a number/)
    end

      it 'should raise error when weight or height ale equall or less then 0' do
        subject = described_class.new(weight: 0, height: 0)
        expect{ subject.classify }.to raise_error(Classifier::InvalidInput, /Height must be greater than 0/)
      end

      it 'should raise error when weight or height are not numbers' do
        subject = described_class.new(weight: 'aaa', height: 'bbbb')
        expect{ subject.classify }.to raise_error(Classifier::InvalidInput, /Weight is not a number/)
      end
    end
  end
end
