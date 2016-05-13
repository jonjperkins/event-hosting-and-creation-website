class Invite < ActiveRecord::Base
    belongs_to :attended_event, :class_name => 'Event'
    belongs_to :guest, :class_name => 'User'
end
