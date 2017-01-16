class Client < ApplicationRecord
  has_one :assessment 
   
  validates :firstname, :surname, :urn, presence: true
  validates :dd, numericality: {less_than_or_equal_to: 31}
  validates :mm, numericality: {less_than_or_equal_to: 12}
  validates :yyyy, numericality: true
  
end
