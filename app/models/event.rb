class Event < ActiveRecord::Base
    
    belongs_to :host, :class_name => "User"
    has_many :guests, :through => :invites, dependent: :destroy
    has_many :invites, :foreign_key => "attended_event_id", dependent: :destroy
    
    scope :upcoming_events, -> { where("event_date >= ?", Date.today) }
    scope :past_events, -> { where("event_date < ?", Date.today) }
  
    validates :title, presence: true, length: { maximum: 30 }
    validates :description, presence: true, length: { maximum: 50 }
    validates :location, presence: true, length: { maximum: 20 }
    validates :event_date, presence: true
    validates :event_time, presence: true
    
end
