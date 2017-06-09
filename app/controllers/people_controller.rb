class PeopleController < ApplicationController

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to people_path
    else
      render 'new'
    end
  end

  def index
    @people = Person.all
  end

  private

  def person_params
    params.require(:person).permit(:weight, :height, :gender)
  end
end
