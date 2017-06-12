class HomeController < ApplicationController
  def index; end

  def calculate
    @gender = Classifier::PeopleGenderClassifier.new(
      weight: person[:weight].to_i,
      height: person[:height].to_i
    ).classify
    render 'index'
  rescue Classifier::Error => e
    @error = e
    render 'index'
  end

  private

  def person
    params[:person]
  end
end
