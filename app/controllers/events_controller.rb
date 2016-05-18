class EventsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :update, :edit]
  before_action :correct_user, only: [:destroy, :update, :edit]
  
  
  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event created!"
      redirect_to @event
    else
      flash.now[:danger] = "Event not created, some information needed."
      render 'new'
    end
  end
  
  def show
    @event = Event.find_by(id: params[:id])
  end
  
  def index
    @events = Event.paginate :page => params[:page], :per_page => 5
  end
  
  def edit
    @event = Event.find_by(id: params[:id])
  end
  
  def update
    @event = Event.find_by(id: params[:id])
      if @event.update_attributes(event_params)
        flash[:success] = "Event updated!"
        redirect_to @event
      else
        render 'edit'
      end
  end
  
  def destroy
    Event.find_by(id: params[:id]).destroy
    flash[:success] = "Event deleted."
    redirect_to events_url
  end
  
  private
  
    def event_params
      params.require(:event).permit(:event_date, :description, :event_time,
                                    :location, :title)
    end
    
    def correct_user
      @user = Event.find(params[:id])
      redirect_to(root_url) unless @user.host_id == current_user.id
    end
    
end
