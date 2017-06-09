class PeopleController < ApplicationController
  before_action :set_person, only: [:edit, :update, :destroy]

  def index
    @people = Person.all
  end

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

  def edit
  end

  def update
    if @person.update(person_params)
      redirect_to people_path
    end
  end

  def destroy

  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:weight, :height, :gender)
  end
end
