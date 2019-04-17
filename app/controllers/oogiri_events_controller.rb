class OogiriEventsController < ApplicationController

  def index
    @oogiri_events = OogiriEvent.all.order(created_at: :desc)
  end

  def show
    @oogiri_event = OogiriEvent.find(params[:id])
  end

  def new
    @oogiri_event = OogiriEvent.new
  end

  def create
    oogiri_event = OogiriEvent.new(oogiri_event_params)
    oogiri_event.save!
    redirect_to oogiri_events_url, notice: "新たに「#{oogiri_event.title}」を登録しました。"
  end

  def edit
  end


  private

  def oogiri_event_params
    params.require(:oogiri_event).permit(:title, :description)
  end
end
