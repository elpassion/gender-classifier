module Classifier
  class NaiveBayesClassifier

    def initialize(values, classify_param, data_table)
      @values = values
      @classify_param = classify_param
      @data_table = data_table
    end

    def run
      classify_param_hash = data_table.send(classify_param.pluralize)
      result = classify_param_hash.reduce({}) do |hash, el|
        range = data_table.where("#{classify_param} = ?", el[1])
        hash[el[0]] = numerator_of_posterior(range)
        hash
      end
      result.max_by{|k,v| v}[0]
    end

    private

    attr_reader :values, :classify_param, :data_table

    def numerator_of_posterior(range)
      likehood_total = values.each.reduce(1) do |product, el|
        mean = mean(range, el[0])
        product *= likelihood(el[1], mean, variance(range, el[0]))
      end
      range.count.to_f / data_table.count * likehood_total
    end

    def likelihood(value, mean, variance)
      1/(Math.sqrt(2*Math::PI*variance)) * Math.exp(( - (value - mean)**2)/(2*variance))
    end

    def variance(range, param)
      total = range.reduce(0) { |sum, el| sum += (mean(range, param) - el.send(param)) **2 }
      total/(range.count - 1)
    end

    def mean(range, param)
      range.average(param)
    end

    def first_range
      @first_range ||= data_table.where("#{classify_param} = ?", 0 )
    end

    def second_range
      @second_range ||= data_table.where("#{classify_param} = ?", 1 )
    end

    def first_given_param #weight
      @first_given_param ||= values.keys.first
    end

    def second_given_param #height
      @second_given_param ||= values.keys.last
    end
  end
end
