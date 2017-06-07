module Classifier
  class NaiveBayesClassifier

    def initialize(values, classify_param, data_table)
      @values = values
      @classify_param = classify_param
      @data_table = data_table
    end

    private

    attr_reader :values, :classify_param, :data_table

    def first_range_first_param_mean
      first_range.average(first_given_param)
    end

    def first_range_second_param_mean
      first_range.average(second_given_param)
    end

    def second_range_first_param_mean
      second_range.average(first_given_param)
    end

    def second_range_second_param_mean
      second_range.average(second_given_param)
    end

    def first_range
      data_table.where("#{classify_param} = ?", 0 )
    end

    def second_range
      data_table.where("#{classify_param} = ?", 1 )
    end


    def first_given_param #weight
      values.keys.first
    end

    def second_given_param #height
      values.keys.last
    end
  end
end
