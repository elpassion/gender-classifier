module Classifier
  class NaiveBayesClassifier
    def initialize(values, classify_param, data_table)
      @values = values
      @classify_param = classify_param
      @data_table = data_table
    end

    def run
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
      data_table.where("#{classify_param} = ?", value)
    end

    def variance(range, param)
      total = range.reduce(0) { |sum, el| sum += (mean(range, param) - el.send(param)) **2 }
      total/(range.count - 1)
    end

    def mean(range, param)
      range.average(param)
    end
  end
end
