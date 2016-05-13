class Event < ActiveRecord::Base
    belongs_to :host, :class_name => "User"
    has_many :guests, :through => :invites
    has_many :invites, :foreign_key => "attended_event_id"
    
  scope :upcoming_events, -> { where("event_date >= ?", Date.today) }
  scope :past_events, -> { where("event_date < ?", Date.today) }
    
    
end
