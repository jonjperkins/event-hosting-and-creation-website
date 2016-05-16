class EventsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  
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
  
  private
  
    def event_params
      params.require(:event).permit(:event_date, :description, :event_time,
                                    :location, :title)
    end
end
