FactoryGirl.define do
  factory :person do
    weight 60
    height 165

    factory :woman do
      gender Person.genders[:female]
    end

    factory :man do
      gender Person.genders[:male]
    end
  end
end