require 'rails_helper'

describe Classifier::NaiveBayesClassifier do
  let!(:male_1) { create(:man, height: 180, weight: 85)}
  let!(:male_2) { create(:man, height: 190, weight: 90)}
  let!(:male_3) { create(:man, height: 175, weight: 80)}
  let!(:male_4) { create(:man, height: 178, weight: 70)}
  let!(:female_1) { create(:woman, height: 160, weight: 50)}
  let!(:female_2) { create(:woman, height: 155, weight: 52)}
  let!(:female_3) { create(:woman, height: 175, weight: 70)}
  let!(:female_4) { create(:woman, height: 170, weight: 65)}


#testing private functions mainly because of TDD
  context 'testing private methods' do

    let(:value_hash) { { height: 150, weight: 50} }
    subject { described_class.new(value_hash, 'gender', Person) }

    it 'calculate properly first range first param mean' do
      expect(subject.send(:first_range_first_param_mean)).to eq 180.75
    end

    it 'calculate properly first range second param mean' do
      expect(subject.send(:first_range_second_param_mean)).to eq 81.25
    end

    it 'calculate properly second range first param mean' do
      expect(subject.send(:second_range_first_param_mean)).to eq 165
    end

    it 'calculate properly second range second param mean' do
      expect(subject.send(:second_range_second_param_mean)).to eq 59.25
    end
  end

end