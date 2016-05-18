class Event < ActiveRecord::Base
    
    belongs_to :host, :class_name => "User"
    has_many :guests, :through => :invites, dependent: :destroy
    has_many :invites, :foreign_key => "attended_event_id", dependent: :destroy
    
    scope :upcoming_events, -> { where("event_date >= ?", Date.today) }
    scope :past_events, -> { where("event_date < ?", Date.today) }
  
    validates :title, presence: true, length: { maximum: 40 }
    validates :description, presence: true, length: { maximum: 200 }
    validates :location, presence: true, length: { maximum: 40 }
    validates :event_date, presence: true
    validates :event_time, presence: true
    validates :host_id, presence: true
    
end
