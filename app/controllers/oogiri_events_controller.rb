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
    @oogiri_event = OogiriEvent.new(oogiri_event_params)

    if @oogiri_event.save
      redirect_to @oogiri_event, notice: "イベント「@oogiri_event.title」を登録しました。"
    else 
      render :new
    end
  end

  def edit
    @oogiri_event = OogiriEvent.find(params[:id])
  end

  def update
    oogiri_event = OogiriEvent.find(params[:id])
    oogiri_event.update!(oogiri_event_params)
    redirect_to oogiri_events_url, notice: "イベント「#{oogiri_event.title}」を更新しました。"
  end

  def destroy
    oogiri_event = OogiriEvent.find(params[:id])
    oogiri_event.destroy
    redirect_to oogiri_events_url, notice: "イベント「#{oogiri_event.title}」を削除しました。"
  end


  private

  def oogiri_event_params
    params.require(:oogiri_event).permit(:title, :description)
  end
end
