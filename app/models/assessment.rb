class Assessment < ApplicationRecord
  belongs_to :client
  
  validates :pulse, numericality: {less_than_or_equal_to: 300}
  validates :resps, numericality: {less_than_or_equal_to: 100}
  validates :sats, numericality: {less_than_or_equal_to: 100}
  validates :temp, numericality: {less_than_or_equal_to: 43}
  validates :weight, numericality: {less_than_or_equal_to: 300}
  validates :hb, numericality: {less_than_or_equal_to: 210}
  validates :gluc, numericality: {less_than_or_equal_to: 60}
  validates :systolic, numericality: {less_than_or_equal_to: 300} 
  validates :diastolic, numericality: {less_than_or_equal_to: 250} 
  
end
