class InvitesController < ApplicationController
    
    def create
        #find the specific event.id
        @event = Event.find(params[:invite][:attended_event_id])
        #create the record on the through table using event and user id
        current_user.invites.create(:attended_event_id => @event.id)
        redirect_to(:back)
    end
    
    def destroy
        @invite = Invite.find(params[:id])
        current_user.invites.destroy(@invite)
        redirect_to(:back)
    end
        
    
    
end
