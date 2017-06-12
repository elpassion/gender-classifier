module Classifier
  class PeopleGenderClassifier
    include ActiveModel::Validations

    validates :weight, :height, numericality: { greater_than: 0 }

    def initialize(weight:, height:)
       @weight = weight
       @height = height
     end

     def classify
       if self.valid?
         NaiveBayesClassifier.new(values: processing_values,
                                  classify_param: 'gender',
                                  data_table: Person).run
       else
         raise InvalidInput, self.errors.full_messages.join(', ')
       end
     end

     private

     attr_reader :weight, :height

     def processing_values
       { weight: weight, height: height }
     end
  end
  class InvalidInput < Error; end
end
