class User < ApplicationRecord
  before_save { self.email = email.downcase } # save all email addresses in lowercase

  validates :name,  presence: true, length: { maximum: 50 }
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false} # prevents two emails with upper and lower case letters 
  
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  
  validates :privileges, presence: true
  PRIVILEGES_CATEGORY = %w(Admin DMO Clinician User Observer) # various user categories to enforce access levels 
  
  # Class method to return the hash digest of a given string (use in testing fixture)
  # set computational cost at minimum
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
						  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
end
