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

  subject { described_class.new(values: value_hash, classify_param: 'gender', data_table: Person) }
  let(:value_hash) { { height: 150, weight: 50} }

  describe '#run' do
    context 'testing female params' do
      it 'should return woman' do
        expect(subject.run).to eq 'female'
      end
    end

    context 'testing male params' do
      let(:value_hash) { { height: 180, weight: 80} }
      it 'should return man' do
        expect(subject.run).to eq 'male'
      end
    end
  end

  #testing private functions because of TDD and to check if every calculation is performed properly
  context 'testing private methods' do
    describe '#numerator_of_posterior' do
      it 'returns proper value for male' do
        expect(subject.send(:numerator_of_posterior, Person.male)).to be_within(0.001e-11).of 2.446e-11
      end

      it 'returns proper value for female' do
        expect(subject.send(:numerator_of_posterior, Person.female)).to be_within(0.001e-4).of 1.477e-4
      end
    end

    describe '#likelihood' do
      it 'returns proper value' do
        value = 6
        mean = 5.855
        variance = 0.035
        expect(subject.send(:likelihood, value, mean, variance)).to be_within(0.001).of 1.579
      end
    end

    describe '#mean' do
      it "returns proper value for man's height" do
        expect(subject.send(:mean, Person.male, 'height')).to eq 180.75
      end

      it "returns proper value for man's weight" do
        expect(subject.send(:mean, Person.male, 'weight')).to eq 81.25
      end

      it "returns proper value for woman's height" do
        expect(subject.send(:mean, Person.female, 'height')).to eq 165
      end

      it "returns proper value for woman's weight" do
        expect(subject.send(:mean, Person.female, 'weight')).to eq 59.25
      end
    end

    describe '#variance' do
      it "returns proper value for man's height" do
        expect(subject.send(:variance, Person.male, 'height')).to eq 42.25
      end

      it "returns proper value for man's weight" do
        expect(subject.send(:variance, Person.male, 'weight')).to be_within(0.001).of 72.917
      end

      it "returns proper value for woman's height" do
        expect(subject.send(:variance, Person.female, 'height')).to be_within(0.001).of 83.333
      end

      it "returns proper value for woman's weight" do
        expect(subject.send(:variance, Person.female, 'weight')).to be_within(0.001).of 95.583
      end
    end
  end
end
