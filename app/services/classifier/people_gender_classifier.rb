module Classifier
  class PeopleGenderClassifier
    include ActiveModel::Validations

    validates :weight, :height, numericality: { greater_than: 0 }

    def initialize(weight:, height:)
      @weight = weight
      @height = height
    end

    def classify
      raise InvalidInput, errors.full_messages.join(', ') unless valid?
      NaiveBayesClassifier.new(values: processing_values,
                               classify_param: 'gender',
                               data_table: Person)
                          .run
    end

    private

    attr_reader :weight, :height

    def processing_values
      { weight: weight, height: height }
    end
  end
end
