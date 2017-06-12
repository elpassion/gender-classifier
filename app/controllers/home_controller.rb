class HomeController < ApplicationController

  def index
  end

  def calculate
    @gender = Classifier::PeopleGenderClassifier.new(weight: person[:weight].to_i,
                                           height: person[:height].to_i).classify
    render 'index'
  rescue Classifier::InvalidInput => e
    @error = e
    render 'index'
  rescue Classifier::NotEnoughData
    @error = 'Not enough test data! Upload some measurements in test data section.'
    render 'index'
  end

  private

  def person
    params[:person]
  end
end