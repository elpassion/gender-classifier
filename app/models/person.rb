class Person < ApplicationRecord
  enum gender: { male: 0, female: 1 }

  validates :height, presence: true, numericality: true
  validates :weight, presence: true, numericality: true
  validates :gender, presence: true
end
