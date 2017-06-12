module Classifier
  class InvalidColumn < StandardError; end
  class NotEnoughData < StandardError; end
  class NaiveBayesClassifier
    def initialize(values:, classify_param:, data_table:)
      @values = values
      @classify_param = classify_param
      @data_table = data_table
    end

    def run
      validate_data
      calculate_posterior.max_by{|k,v| v}[0]
    end

    private

    attr_reader :values, :classify_param, :data_table

    def calculate_posterior
      classify_param_hash.reduce({}) do |hash, el|
        hash.update(el[0] => numerator_of_posterior(range(el[1])))
      end
    end

    def numerator_of_posterior(range)
      range.count.to_f / data_table.count * likehood_total(range)
    end

    def likehood_total(range)
      values.each.reduce(1) do |product, el|
        product *= likelihood(el[1], mean(range, el[0]), variance(range, el[0]))
      end
    end

    def likelihood(value, mean, variance)
      1/(Math.sqrt(2*Math::PI*variance)) * Math.exp(( - (value - mean)**2)/(2*variance))
    end

    def classify_param_hash
      data_table.send(classify_param.pluralize)
    end

    def range(value)
      range = data_table.where("#{classify_param} = ?", value)
      raise NotEnoughData if range.empty?
      range
    end

    def variance(range, param)
      total = range.reduce(0) { |sum, el| sum += (mean(range, param) - el.send(param)) **2 }
      raise NotEnoughData if total == 0
      total/(range.count - 1)
    end

    def mean(range, param)
      range.average(param)
    end

    def validate_data
      check_values
      check_classify_param
    end

    def check_values
      values.each_key do |value|
        check_column(value)
      end
    end

    def check_classify_param
      check_column(classify_param)
    end

    def check_column(value)
      column = data_table.columns_hash[value.to_s]
      unless column && column.type == :integer
        raise InvalidColumn, "Invalid column: #{value}"
      end
    end
  end
end
