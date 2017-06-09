module Classifier
  class PeopleGenderClassifier
     def initialize(weight:, height:)
       @weight = weight
       @height = height
     end

     def classify
       NaiveBayesClassifier.new(values: processing_values,
                                classify_param: 'gender',
                                data_table: Person).run
     end

     private

     attr_reader :weight, :height

     def processing_values
       {weight: weight, height: height}
     end
  end
end
