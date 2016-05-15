class User < ActiveRecord::Base
    include SessionsHelper
    has_many :events, :foreign_key => 'host_id', dependent: :destroy
    has_many :invites, :foreign_key => 'guest_id', dependent: :destroy
    has_many :attended_events, :through => :invites, dependent: :destroy
    
    has_many :sent_invitations, :foreign_key => :sender_id, :class_name => "Invitation"
    has_many :received_invitations, :foreign_key => :receiver_id, :class_name => "Invitation"
  
    attr_accessor :remember_token
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 30 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6 }
    has_secure_password
    
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
    
    def User.new_token
      SecureRandom.urlsafe_base64
    end
    
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end
    
    def authenticated?(remember_token)
      return false if remember_digest.nil?
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    
    def forget
      update_attribute(:remember_digest, nil)
    end
    
    def upcoming_events
      self.attended_events.where("event_date > ?", Date.today)
    end
    
    def past_events
      self.attended_events.where("event_date < ?", Date.today)
    end
  
  

end
