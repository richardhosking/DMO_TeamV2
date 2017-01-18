class User < ApplicationRecord
  attr_accessor :remember_token
  
  before_save { self.email = email.downcase } # save all email addresses in lowercase

  validates :name,  presence: true, length: { maximum: 50 }
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false} # prevents two emails with upper and lower case letters 
  
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  validates :privileges, presence: true
  PRIVILEGES_CATEGORY = %w(Admin DMO Clinician User Observer) # various user categories to enforce access levels 
  
  # Class method to return the hash digest of a given string (use in testing fixture)
  # set computational cost at minimum
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
						  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
 
  # Class method to return a random token for secure cookies 
  def User.new_token
    SecureRandom.urlsafe_base64    
  end
  
  # Class method to remember a user associated with placing a permanent cookie on the users browser
  # This method stores an encrypted remember_token in the DB for later comparison
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
# Returns true if the given token matches the digest in memory associated with this user
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
 
# Forgets a currently logged in user
  def forget
    update_attribute(:remember_digest, nil)
  end
  
end
