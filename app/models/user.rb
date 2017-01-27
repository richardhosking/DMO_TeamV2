class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  
  before_save :downcase_email  # save all email addresses in lowercase
  before_create :create_activation_digest # for activation email link 
  
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
# Generalize to use with password, remember persistent sessions and signup authentication 
  def authenticated?(attribute,token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
 
# Forgets a currently logged in user in a persistent session
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # Activate a new user
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
   end
  
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  # Sets password reset attributes
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)      
  end
  
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  # Checks that the reset link was not sent more than 2 hours ago - returns true if so 
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  
  
  private
  # uniqueness of email - upper and lower case are equivalent 
  def downcase_email
    email.downcase!
  end 
  
  # Creates and assigns activation token and digest
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
  
  
end
